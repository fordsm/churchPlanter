package com.lifeway.utils

import java.math.BigDecimal

import org.apache.log4j.Logger
import org.springframework.context.i18n.LocaleContextHolder

import com.lifeway.cpDomain.Answer
import com.lifeway.cpDomain.Question
import com.lifeway.cpDomain.Survey
import com.lifeway.cpDomain.SurveyResponse
import com.lifeway.cpDomain.Translation
import com.lifeway.cpDomain.Threshold
import com.lifeway.cpDomain.Locale
import com.lifeway.cpDomain.Category
import com.lifeway.cpDomain.CategoryGroup
import com.lifeway.cpDomain.CategoryLine
import com.lifeway.utils.TranslationHelper

class SurveyHelper {
	private static org.apache.log4j.Logger log = Logger.getLogger(SurveyHelper.class);

	def Questions(survey){
	}
	def setNewResponse(churchPlanter,survey){
		def surveyResponse = new SurveyResponse([survey:survey,churchPlanter:churchPlanter])
		if(!(surveyResponse && (surveyResponse.save(flush:true)))) {
			surveyResponse = false
			throw new Exception("surveyResponse SAVE FAILED. An exception occurred while saving the surveyResponse object"+surveyResponse)
		}
		return surveyResponse
	}
	def setNewResponse(churchPlanter,survey,reference){
		def surveyResponse = new SurveyResponse([survey:survey,churchPlanter:churchPlanter,reference:reference])
		if(!(surveyResponse && (surveyResponse.save(flush:true)))) {
			surveyResponse = false
			throw new Exception("surveyResponse SAVE FAILED. An exception occurred while saving the surveyResponse object"+surveyResponse)
		}
		return surveyResponse
	}
	def getResponse(survey,churchPlanter) {
		def currentDate = new Date()
		def surveyResponses = SurveyResponse.findAllBySurveyAndChurchPlanter(survey,churchPlanter)
		def surveyResponse = false
		if(surveyResponses.size() > 0){
			surveyResponse = surveyResponses[surveyResponses.size()-1]

			if(surveyResponse.completionDate){
				if(survey.totalCpResponsesAllowed > 1 && surveyResponses.size() < survey.totalCpResponsesAllowed){
					if((currentDate-surveyResponse.completionDate) >= survey.responseInterval){
						surveyResponse = setNewResponse(churchPlanter,survey)
					}
				}
			}
		}
		try{
			if(!surveyResponse){
				surveyResponse = setNewResponse(churchPlanter,survey)
			}
		}catch(Exception e) {
			log.error e
		}

		return surveyResponse
	}

	def getResponse(survey,churchPlanter,reference) {

		def currentDate = new Date()
		def surveyResponse = SurveyResponse.findByChurchPlanterAndReference(churchPlanter,reference)

		try{
			if(!surveyResponse){
				surveyResponse = setNewResponse(churchPlanter,survey,reference)
			}
		}catch(Exception e) {
			log.error e
		}

		return surveyResponse
	}

	def getTranslations(params,surveyResponse,locale){
		def translations
		if(surveyResponse.completionDate){
			translations =false
		}else{
			params.max = Math.min(params.max ? params.int('max') : 10, 100)
			params.sort= 'sequenceNumber'
			params.order='asc'
			def answeredQuestions = []
			if(surveyResponse.answers){
				answeredQuestions.addAll(surveyResponse.answers.question.id)
			}
			def questions
			if(answeredQuestions.size() > 0){
				params.offset = 0
				questions = Question.findAllBySurveyAndIdNotInList(surveyResponse.survey,answeredQuestions,params)
			} else{
				questions = Question.findAllBySurvey(surveyResponse.survey,params)
			}

			if(questions){
				translations = Translation.findAllByQuestionInListAndLocale(questions,locale)
			} else{
				translations = false
			}
		}

		return translations
	}
	def checkTranslation(survey,locale){
		def questions = Question.findAllBySurvey(survey)
		def translations = Translation.findAllByQuestionInListAndLocale(questions,locale)
		if(questions.size() == translations.size()){
			return true
		} else{
			return false
		}
	}
	def saveAnswers(answers,surveyResponse){
		answers.each{ questionId,answer->
			if(!Answer.findBySurveyResponseAndQuestion(surveyResponse,Question.get(questionId))){
				new Answer(surveyResponse:surveyResponse,churchPlanter:surveyResponse.churchPlanter,question:Question.get(questionId),value:answer).save(flush:true)
			}
		}
	}

	def List<Survey> getBaseSurveys(){
		def surveys = []

		def cpcaSurvey = Survey.get(1)
		def spGiftSurvey = Survey.get(2)

		if(cpcaSurvey){
			surveys.add(cpcaSurvey)
		}
		if(spGiftSurvey){
			surveys.add(spGiftSurvey)
		}
		return surveys
	}

	def calculateCumulativeCategoryScores(surveyResponse) {
		def categoryPointsMap = new LinkedHashMap<String,Integer[]>()
		def categoryPercentageMap = new LinkedHashMap<String,Integer>()
		TranslationHelper th = new TranslationHelper()
		def englishNames = th.getEnglishCategoryNames()

		surveyResponse?.answers.each{ answer ->
			def tempValue = 0
			if(answer.question.questionType.id == 1){
				answer.question.categories.sort{a,b -> a.getName().compareTo((b.getName()))}.each{ category ->
					//println("answer size:   " + answer.question?.possibleAnswers.size())
					if(answer.question?.possibleAnswers && answer.question?.possibleAnswers.size()>0){

						def tempList = answer.question.possibleAnswers.sort{ a,b->
							(a.value).compareTo((b.value))
						}
						def tempPointValue = tempList[tempList.size() - 1]
						tempPointValue = tempPointValue.value.toInteger()
						if(!category.excludeFromReports) {
							if(categoryPointsMap.keySet().contains(category.id)) {
								tempValue = categoryPointsMap.get(category.id)[0] + answer.value.toInteger()
								tempPointValue = categoryPointsMap.get(category.id)[1] + tempPointValue
								categoryPointsMap.put(category.id, [tempValue, tempPointValue])
							}else {
								categoryPointsMap.put(category.id, [
									answer.value.toInteger(),
									tempPointValue
								])
								log.info("adding......" + tempPointValue)
							}
						}
					}
				}
			} else {
				//println("skipped question....")
			}
		}

		categoryPointsMap.keySet().each {
			categoryPercentageMap.put(it,((categoryPointsMap.get(it)[0] / categoryPointsMap.get(it)[1])*100).setScale(0, BigDecimal.ROUND_HALF_UP))
		}

		return categoryPercentageMap
	}

	def calculateCumulativeScore(surveyResponse) {
		def categoryPercentageMap = new SurveyHelper().calculateCumulativeCategoryScores(surveyResponse)
		BigDecimal avgCumulativeScore = BigDecimal.ZERO

		if(categoryPercentageMap) {
			BigDecimal cumulativeScore = BigDecimal.ZERO
			categoryPercentageMap.keySet().each {
				cumulativeScore += categoryPercentageMap.get(it)
			}
			def categoryPercentageMapSize = new BigDecimal(categoryPercentageMap.keySet().size().toString())
			if(categoryPercentageMapSize > 0) {
				avgCumulativeScore = cumulativeScore.divide(categoryPercentageMapSize,2,BigDecimal.ROUND_HALF_UP)
			}
		}

		return avgCumulativeScore
	}
	def getSurveysByStatus(churchPlanter){
		def completeSurveyResponses = [:]
		def completeSurveys = []
		def incompleteSurveys = churchPlanter.passcode.surveys
		def responseSurveyMap = [:]
		churchPlanter.surveyResponses.sort{ a,b->
			(a.id).compareTo((b.id))
		}.each{ response->
			if(response.completionDate){
				if(!completeSurveys.contains(response.survey)){
					completeSurveys.add(response.survey)
				}
				completeSurveyResponses[response.survey.id] = response
				incompleteSurveys.remove(response.survey)
			}
		}

		//		SurveyResponse.findAllByChurchPlanterAndCompletionDateIsNull(churchPlanter).each{ response->
		//			if(!incompleteSurveys.contains(response.survey) && response.survey.isForReferences == false){
		//				incompleteSurveys.add(response.survey)
		//			}
		//		}
		//		incompleteSurveys.each{ survey ->
		//			if(survey.isForReferences == true){
		//				incompleteSurveys.remove(survey)
		//			}
		//		}
		def referenceSurvey = Survey.findAllByIsForReferences(true)
		if(referenceSurvey){
			referenceSurvey.each{rSurvey->
				incompleteSurveys.remove(rSurvey)
			}
		}

		churchPlanter.passcode.surveys.each{ survey ->
			responseSurveyMap.put(survey.id, SurveyResponse.withCriteria{
				eq("churchPlanter",churchPlanter)
				eq("survey",survey)
				isNotNull('completionDate')
			}
			)
		}

		[
			completeSurveyResponses,
			completeSurveys,
			incompleteSurveys,
			responseSurveyMap
		]
	}
	
	
	def getCategoryGroupModel(selectedSurvey, categoryPercentageMap, englishNames){
		def categoryGroupModel = new CategoryGroupModel()
		def categoryGroups = CategoryGroup.findAll(sort:"sequenceNumber"){
			survey == selectedSurvey
		}
		//Sort the categories
	
		categoryGroups.each{
			def currCategoryGroup = it;
			List<Category> sortedList = it.category.sort{
				it.getName()
			}
			sortedList.each{
				def currCategory = it;
				def score = categoryPercentageMap.get(it.id)
				def name = englishNames.get(it.id)
				def categoryLines = CategoryLine.findAll(sort:"line"){
					category == currCategory
				}
				if(score != null){
					CategoryModel catModel = new CategoryModel(currCategoryGroup, it, currCategoryGroup.color, score, name, categoryLines)
					categoryGroupModel.categoryModels.add(catModel)
					categoryLines.each{
						categoryGroupModel.allLines.add(it.line)
					}
					categoryGroupModel.categoryGroups.add(currCategoryGroup)
					//Search for a follow up question.
					def followUpQuestions = Threshold.findAll{
						category == currCategory && survey == selectedSurvey && rangeLow < score && rangeHigh > score										
					}
					Set<String> followUps = categoryGroupModel.followUpQuestions.get(currCategoryGroup)
					if(followUps == null){
						followUps = new LinkedHashSet<>()
					}
					followUps.addAll(followUpQuestions)
					if(!followUps.isEmpty()){
						categoryGroupModel.followUpQuestions.put(currCategoryGroup, followUps)
					}
				}
			}
		}
		categoryGroupModel
	}
	
	def getLines(surveyResponse){
		Line.findAll(){
			survey == surveyResponse.survey
		}
	}

	def pdfBuilder(surveyResponse){
		TranslationHelper th = new TranslationHelper()
		def englishNames = th.getEnglishSurveyNames()
		def englishCategoryNames = th.getEnglishCategoryNames(surveyResponse.survey)
		Boolean showBaseLegend = false
		Boolean showIdealLegend = false
		def legendCss = "legendTD"
		def dividend = 0
		Boolean useRisk = false
		Boolean isSpouseReport = false

		def categoryPercentageMap= calculateCumulativeCategoryScores(surveyResponse)
	    
		def categories = null
		if(categoryPercentageMap.size() > 0){
			//println("getting categories...")
			categories = Category.getAll(categoryPercentageMap.keySet().toList()).sort{a,b -> a.getName().compareTo((b.getName()))}
		}else{
			//println("no categories...")
			categories = false
		}
		
		def categoryGroupModel = getCategoryGroupModel(surveyResponse.survey, categoryPercentageMap, englishCategoryNames)
		
		def churchPlanter = surveyResponse.churchPlanter

		if(categories != false && categories.size() > 0){
			if(categories.findAll{it?.baseThreshold}.size() > 0){
				showBaseLegend = true
			}
			if(categories.findAll{it?.idealThreshold}.size() > 0){
				showIdealLegend = true
			}
		}

		if(englishNames[surveyResponse.survey.id]=="Spiritual Formation Inventory"){
			legendCss = legendCss + " sfi"
		}
		if(englishNames[surveyResponse.survey.id]=="Risk Factor Analysis "){
			legendCss = legendCss + " risk"
			useRisk = true
			showIdealLegend = false
		}

		[
			categoryGroupModel:categoryGroupModel,
			churchPlanter:surveyResponse.churchPlanter,
			surveyResponse:surveyResponse,
			categoryPercentageMap:categoryPercentageMap,
			categories:categories,
			showBaseLegend:showBaseLegend,
			showIdealLegend:showIdealLegend,
			legendCss:legendCss,
			useRisk:useRisk,
			englishCategoryNames:englishCategoryNames,
			isSpouseReport:isSpouseReport

		]
	}

	def checkPasscodeSurveys(churchPlanter){
		churchPlanter.passcode.surveys.each{ survey ->
			if(!survey.isForReferences){
				if(!SurveyResponse.findByChurchPlanterAndSurvey(churchPlanter,survey)){
					setNewResponse(churchPlanter,survey)
				}
			}
		}

	}
}
