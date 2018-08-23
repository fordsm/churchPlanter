package com.lifeway.churchplanter

import grails.plugin.rendering.pdf.PdfRenderingService

import org.springframework.context.i18n.LocaleContextHolder

import com.lifeway.cpDomain.ChurchPlanter
import com.lifeway.cpDomain.Locale
import com.lifeway.cpDomain.Passcode
import com.lifeway.cpDomain.Question
import com.lifeway.cpDomain.Survey
import com.lifeway.cpDomain.SurveyResponse
import com.lifeway.cpDomain.TutorialResource
import com.lifeway.utils.OrgResourceHelper
import com.lifeway.utils.SurveyHelper
import com.lifeway.utils.TranslationHelper
import org.springframework.web.servlet.support.RequestContextUtils as RCU
import org.springframework.context.i18n.LocaleContextHolder as LCH

import org.apache.commons.lang.StringUtils

import grails.util.Environment;
import com.lifeway.java.utils.PropLoader;


class ChurchPlanterController extends SecureController{
	EmailService emailService
	PdfRenderingService pdfRenderingService

	def index = {
		redirect(controller:'home', action:'login')
	}

	def menu = {

		def currentDate = new Date()
		def churchPlanter = ChurchPlanter.get(session.ChurchPlanterId)
		def surveys = churchPlanter.passcode.surveys
		def surveyHelper = new SurveyHelper()
		def isForReferenceSurveys = Survey.findAllByIsForReferences(true)


		//Two things are going on here
		//1.The model needs a cpDomain Local object
		//2.However if someone without a session clicks on CP logo to login, they need a java.util.Local object set

		//Check for locale from context holder or session.Be sure
		//to set context so you can find by cpDomain.Locale later for model

		//Must check params.lang first, in case user has clicked on upper left link
		if (params['lang']) {
			def tmpLocale = new java.util.Locale(params['lang'])
			RCU.getLocaleResolver(request).setLocale(request,response,tmpLocale)
			session.lang = params['lang']
			LCH.setLocale(tmpLocale)
		}
		else if(session.lang != null) {
			def tmpLocale = new java.util.Locale(session.lang)
			RCU.getLocaleResolver(request).setLocale(request,response,tmpLocale)
			LCH.setLocale(tmpLocale)
		}
		else if(LCH.getLocale()){
			session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = LCH.getLocale()
			RCU.getLocaleResolver(request).setLocale(request,response,LCH.getLocale())
		}
		else{
			//If all else fails default to English
			session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new java.util.Locale("en","US")
			RCU.getLocaleResolver(request).setLocale(request,response,new java.util.Locale("en","US"))
			LCH.setLocale(new java.util.Locale("en","US")) //This does not always work?? Go over with Scott
		}

		//Create cpDomain Locale for model
		def localeValue = LCH.getLocale()
		def Locale locale
		if(localeValue.country)
			if(localeValue.country.equalsIgnoreCase("English")){ //dont ask me, i have not idea how this is happening.(needs researched)
				locale = Locale.findByValue("en_US")
			}
			else{
				locale = Locale.findByValue(localeValue.language+"_"+localeValue.country )
			}
		else{
			locale = Locale.findByValue(localeValue.language)
		}


		def (completeSurveyResponses, completeSurveys, incompleteSurveys,responseSurveyMap) = surveyHelper.getSurveysByStatus(churchPlanter)
		//render LCH.getLocale()
		[currentDate:currentDate,churchPlanter:churchPlanter,completeSurveyResponses:completeSurveyResponses, completeSurveys:completeSurveys, incompleteSurveys:incompleteSurveys,responseSurveyMap:responseSurveyMap,locale:locale,isForReferenceSurveys:isForReferenceSurveys]
	}

	def myAccount = {
		def churchPlanter = ChurchPlanter.get(session.ChurchPlanterId)
		[churchPlanter:churchPlanter]
	}

	def requestPasscode = {
	}

	def register = {
		String code
		Boolean max = false
		if(!session.passcodeCode && params.passcode){
			code = params.passcode
			session.passcodeCode = code
		}else if(session.passcodeCode && !params.passcode){
			code = session.passcodeCode
		}else{
			code = params.passcode
		}
		Passcode passcode = Passcode.findByCode(code)?:new Passcode(code:null)

		if(StringUtils.isBlank(passcode.code)||(!params.passcode && !passcode.code && !session.passcodeCode)){
			passcode.errors.reject("message.churchPlanter.registration.missingPasscode")
		}else if(!passcode.isUnlimited && passcode.timesUsed > 0){
			passcode.errors.reject("message.churchPlanter.registration.passcodeMax")
			max = true

		}else if(passcode.expirationDate < new Date()){
			passcode.errors.reject("message.churchPlanter.registration.passcodeExpired")
		}
		if(passcode.hasErrors()){
			if(max == false){
				render(view:"requestPasscode", model:[passcode:passcode])
		} else{
			render(view:"requestPasscodeMax", model:[passcode:passcode])}
	}

	[passcode:passcode]
}
def save = {
	Passcode passcode = Passcode.get(params.passcode.id)
	def churchPlanterInstance = new ChurchPlanter(params)

	if(params.password != params.cpassword){
		churchPlanterInstance.errors.rejectValue('password','message.churchPlanter.registration.cpass')
	}
	if(params.educationLevel.id.toInteger()!=1 && !params.educationInstitution){
		churchPlanterInstance.errors.rejectValue('educationInstitution','message.churchPlanter.registration.educationInstitution')
	}
	if(params.ethnicity.id.toInteger()==5 && !params.otherEthnicity){
		churchPlanterInstance.errors.rejectValue('otherEthnicity','message.churchPlanter.registration.otherEthnicity')
	}
	if(!params.terms){
		churchPlanterInstance.errors.reject('message.churchPlanter.registration.noTerms')
	}
	if(!params.password){
		churchPlanterInstance.errors.reject('message.churchPlanter.registration.passBlank')
	}
	churchPlanterInstance.password = churchPlanterInstance.password.encodeAsMessageDigest()
	if(!churchPlanterInstance.hasErrors() && churchPlanterInstance.save()){
		passcode.timesUsed = passcode.timesUsed.toInteger()+1
		passcode.save()
		session.ChurchPlanterId = churchPlanterInstance.id
		// BEGIN - logic for sending welcome mail upon successful registration
		emailService.sendWelcomeEmailUponSuccessfulRegistration(churchPlanterInstance)
		//END - logic for sending welcome mail upon successful registration
		redirect(action:'menu')
	} else{
		churchPlanterInstance.password = params.password
		render(view: "register", model: [churchPlanterInstance: churchPlanterInstance,passcode:passcode])
	}
}
def myInfo = {
	def churchPlanterInstance = ChurchPlanter.get(session.ChurchPlanterId)
	[churchPlanterInstance:churchPlanterInstance]
}
def update = {
	def churchPlanterInstance = ChurchPlanter.get(session.ChurchPlanterId)
	churchPlanterInstance.properties = params
	if(churchPlanterInstance.save()){
		flash.message =message(code:"message.churchPlanter.myInfo.success")
		redirect(action:"myAccount")
	}else{
		render(view: params.return, model: [churchPlanterInstance: churchPlanterInstance])
	}
}

def aboutMe = {
	def churchPlanter = ChurchPlanter.get(session.ChurchPlanterId)
	[churchPlanter:churchPlanter]
}

def changePassword = {
	def churchPlanterInstance = ChurchPlanter.get(session.ChurchPlanterId)
	[churchPlanterInstance:churchPlanterInstance]
}
def updatePassword = {

	def churchPlanterInstance = ChurchPlanter.get(session.ChurchPlanterId)
	if(params.password != params.cpassword){
		churchPlanterInstance.errors.reject('message.churchPlanter.registration.cpass')
	}else if(!params.password){
		churchPlanterInstance.errors.reject('message.churchPlanter.registration.passBlank')
	}else if(!params.currentPassword){
		churchPlanterInstance.errors.reject('message.churchPlanter.registration.currentPassBlank')
	}else if(churchPlanterInstance.password != params.currentPassword.encodeAsMessageDigest()){
		churchPlanterInstance.errors.reject('message.churchPlanter.registration.currentPassNoMatch')
	}else{
		churchPlanterInstance.properties = params
		churchPlanterInstance.password = churchPlanterInstance.password.encodeAsMessageDigest()
	}

	if(!churchPlanterInstance.hasErrors() && churchPlanterInstance.save()){
		flash.message =message(code:"message.churchPlanter.changePassword.success")
		redirect(action:"myAccount")
	}else{
		render(view: "changePassword", model: [churchPlanterInstance: churchPlanterInstance])
	}
}

def take = {
	def locale = Locale.findByValue(LocaleContextHolder.getLocale().toString())
	def survey = Survey.get(params.id)
	def surveyTitle = survey.getTranslationByLocale(locale)?.name?:""
	def churchPlanter = ChurchPlanter.get(session.ChurchPlanterId)
	def surveyHelper = new SurveyHelper()
	def surveyResponse = surveyHelper.getResponse(survey,churchPlanter)
	if(params.question  && surveyResponse) {
		surveyHelper.saveAnswers(params.question,surveyResponse)
		surveyResponse.refresh()
		if(survey.questions.size() == surveyResponse.answers.size()) {
			surveyResponse.completionDate = new Date()
			surveyResponse.cumulativeScore = surveyHelper.calculateCumulativeScore(surveyResponse)
			surveyResponse.save()
			if(survey.id == 1){
				churchPlanter.cpcaCompletionDate = new Date()
				churchPlanter.save(flush:true)
			}
			try{
				def pdfBuild = surveyHelper.pdfBuilder(surveyResponse)

				def tier1 = []
				def tier2 = []
				def tier3 = []
				def tier4 = []
				def temPlate = "/churchPlanter/summaryReport"

				if(survey.id == 1){
					temPlate = "/churchPlanter/summaryTieredReport"


					pdfBuild.categories.sort{a,b -> a.getName().compareTo((b.getName()))}.each{category ->
						if(category.tier == 1){
							tier1.add(category)
						}
						if(category.tier == 2){
							tier2.add(category)
						}
						if(category.tier == 3){
							tier3.add(category)
						}
						if(category.tier == 4){
							tier4.add(category)
						}
					}


					pdfBuild.tiers = [tier1, tier2, tier3, tier4]
					pdfBuild.followUps = []
				}

				def bytes = (pdfRenderingService.render(template: temPlate, model: pdfBuild)).buf
				if(!emailService.sendCompletedSurveyNotification(churchPlanter,survey,bytes,surveyTitle+" Survey Report for "+churchPlanter.toString()+".pdf","text/pdf")) {
					log.error("Completed Survey Notification Email Failed. Could not be sent to "+churchPlanter.organization.primaryContact)
				}
			}catch (Exception e){
				log.error e
			}
		}
	}

	def checkTranslation = surveyHelper.checkTranslation(survey,locale)
	def translations = surveyHelper.getTranslations(params,surveyResponse,locale)
	def model = [surveyTitle:surveyTitle,translations: translations, questionTotal: Question.findAllBySurvey(survey).size(), locale:locale,surveyResponse:surveyResponse,checkTranslation:checkTranslation]
	if (request.xhr) {
		render(template: "grid", model: model)
	}
	else {
		model
	}
}

def cpPreviewResource={
	ChurchPlanter churchPlanter = ChurchPlanter.get(session.ChurchPlanterId)
	def orgResourceInstance = null
	orgResourceInstance = OrgResourceHelper.getApprovedInstance(churchPlanter.organization,orgResourceInstance)

	if(orgResourceInstance != null) {
		[orgResourceInstance:orgResourceInstance]
	}else {
		flash.message=message(code:"message.resource.churchplanter.preview.unavailable")
	}
}

def summaryReport={
	def locale = Locale.findByValue(LocaleContextHolder.getLocale().toString())
	ChurchPlanter churchPlanter = ChurchPlanter.get(session.ChurchPlanterId?:params.ChurchPlanterId)
	Survey survey = Survey.get(params.id)
	def surveyHelper = new SurveyHelper()
	def surveyResponses = SurveyResponse.findAllBySurveyAndChurchPlanter(survey,churchPlanter)
	def surveyResponse = surveyResponses[surveyResponses.size()-1]
	TranslationHelper tc = new TranslationHelper()
	if(params.surveyResponse){
		surveyResponse = SurveyResponse.findByIdAndChurchPlanter(params.surveyResponse, churchPlanter)
	}
	if(!surveyResponse){ 
		flash.message =message(code:"message.churchPlanter.summaryReport.badRequest")
		redirect(action:'menu')
	}

	def pdfBuild = surveyHelper.pdfBuilder(surveyResponse)
	pdfBuild.englishCategoryNames = tc.getEnglishCategoryNames()
	
	if(params.pdf){
		def pdfFilename = message(code:"message.churchPlanter.surveyReport.pdfFileName", args:[
			(survey.getTranslationByLocale()?.name?:message(code:"message.churchPlanter.general.noTranslation")).encodeAsURL(),
			churchPlanter.toString()
		])+".pdf"
		renderPdf(template: 'summaryReport', model:pdfBuild, filename:pdfFilename)
	}else{
		pdfBuild
	}
}

def showStates = {
	render(template:"/churchPlanter/showStates",model:[countryAbbrv:params.countryAbbrv])
}
def tutorials = {
	Properties properties = new PropLoader("s3.properties").getProperties();
	String s3Url = properties.getProperty("S3_REMOTE_FILE_URL");
	String environment = Environment.getCurrent().toString().toLowerCase();

	def cpcaTutorials = TutorialResource.findAllByTypeAndIsChurchPlanter("CPCA Tutorials",true)
	def assessmentResources = TutorialResource.findAllByTypeAndIsChurchPlanter("Assessment Resources",true)
	def churchplanterResources = TutorialResource.findAllByTypeAndIsChurchPlanter("Church Planting Resources",true)

	render(view:"/templates/_tutorials", model:[cpcaTutorials:cpcaTutorials,assessmentResources:assessmentResources,churchplanterResources:churchplanterResources,s3Url:s3Url,environment:environment])
}
}
