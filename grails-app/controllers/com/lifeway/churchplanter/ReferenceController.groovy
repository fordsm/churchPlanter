package com.lifeway.churchplanter


import grails.plugin.rendering.pdf.PdfRenderingService;

import com.lifeway.cpDomain.ChurchPlanter
import com.lifeway.cpDomain.Organization
import com.lifeway.cpDomain.Question
import com.lifeway.cpDomain.Reference
import com.lifeway.cpDomain.Survey
import com.lifeway.cpDomain.SurveyResponse
import com.lifeway.cpDomain.Locale
import org.springframework.context.i18n.LocaleContextHolder as LCH
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import com.lifeway.utils.ChurchPlanterUtilities
import com.lifeway.utils.EncoderUtility
import com.lifeway.utils.SurveyHelper
import com.lifeway.cpDomain.Locale
import org.apache.log4j.Logger
import org.springframework.context.i18n.LocaleContextHolder
import org.springframework.web.servlet.support.RequestContextUtils as RCU


class ReferenceController extends SecureController{

	def mailService
	def messageSource
	//private static org.apache.log4j.Logger log = Logger.getLogger(EmailService.class);
	//EmailService emailService
	PdfRenderingService pdfRenderingService	
	
	def isSpouseExist =Boolean.FALSE

	def index = {
	}

	def show ={
		def churchPlanterInstance = ChurchPlanter.get(session.ChurchPlanterId)
		def references = Reference.findAllByChurchPlanter(churchPlanterInstance)
		isSpouseExist = result(references)
		def survey = Survey.findByIsForReferences(true)
		render(view: "churchPlanterReferences", model: [churchPlanterInstance:churchPlanterInstance,references:references,survey:survey,isSpouseExist:isSpouseExist])
	}

	boolean result (references ){
		references.find{reference ->
			if(reference.spouse){
			return true;
			}
		}
		
	}
		
	def add={
		def survey = Survey.findByIsForReferences(true)
		def churchPlanterInstance = ChurchPlanter.get(session.ChurchPlanterId)
		def references = Reference.findAllByChurchPlanter(churchPlanterInstance)
		def reference = new Reference(params)



		try{

			def collection = Reference.findAllByChurchPlanterAndCategory(churchPlanterInstance,params.category.toString())
			if(collection.size() >= 2){
				flash.message = message(code:"message.chruchPlanter.reference.mail.submit.twoCategoriesAllowed")
				redirect(action:"show", controller:"reference", id:params.churchPlanterInstance)
				return null
			}

			//The two categories rule will keep this biz rule from
			//executing. However,still good to have in case categories are increased
			Integer referenceCount = 0
			if(!reference.spouse){
				churchPlanterInstance.references.each{ref ->
					if(!ref.spouse){
						referenceCount++
					}
				}
			}
			if(referenceCount == 6){
				flash.message = message(code:"message.chruchPlanter.reference.mail.submit.maxOfSixReferences")
				redirect(action:"show", controller:"reference", id:params.churchPlanterInstance)
				return null
			}



			//Add Reference
			churchPlanterInstance.addToReferences(reference)

			reference.validate()
			if(!reference.hasErrors() )
			{
				churchPlanterInstance.save(flush:true,failOnError:true)
			}
			else{
				render(view: "churchPlanterReferences", model: [churchPlanterInstance: churchPlanterInstance,reference:reference,survey:survey,references:references])
				return null
			}

		} catch(Exception e){
			log.error e
			flash.message = "Unable to add reference. Please try again"
			redirect(action:show, id:params.churchPlanterInstance)
		}

		def originalLocale
		try {
			//Submit email to reference
			def queryString = churchPlanterInstance?.organization?.id+"&"+churchPlanterInstance?.id+"&"+reference?.id+"&"+ChurchPlanterUtilities.now(ChurchPlanterUtilities.DATE_PATTERN_NO_SEPERATOR)+"&"+reference.locale?.id
			def encodedQuesryString	= queryString.encodeAsChurchPlanter()
			def absoluteUrl = CH.config.grails.serverURL + "/reference/validateSession?token="+encodedQuesryString
			def messageTo = []

			HashMap mailBodyMap = new HashMap()
			mailBodyMap.put "url", absoluteUrl
			mailBodyMap.put "churchPlanterFirstName", churchPlanterInstance.firstName
			mailBodyMap.put "churchPlanterLastName", churchPlanterInstance.lastName
			mailBodyMap.put "referenceName", reference.name
			mailBodyMap.put "whyReceiving", reference.whyReceiving
			if(churchPlanterInstance.organization.name != null){
				mailBodyMap.put "organizationName", churchPlanterInstance.organization.name
			}
			else{
				mailBodyMap.put "organizationName", ""
			}

			messageTo.add reference.email

			def messageSubject = messageSource.getMessage('message.chruchPlanter.reference.mail.subject',null,new java.util.Locale(reference.locale.value,reference.locale.description))
			def replyTo =  messageSource.getMessage('message.system.LWR.user.email',null, new java.util.Locale(reference.locale.value,reference.locale.description))

			originalLocale = RCU.getLocale(request)

			//Must change current locale, to be able to e-mail in chosen language
			session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new java.util.Locale(reference.locale.value,reference.locale.description)
			if(reference.spouse){
				emailService.sendEmail(messageTo, messageSubject, mailBodyMap, "SpouseReferenceMailTemplate", replyTo)
			}else{
				emailService.sendEmail(messageTo, messageSubject, mailBodyMap, "referenceMailTemplate", replyTo)
			}
			session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new java.util.Locale(originalLocale.toString(),"")


			[churchPlanterInstance:churchPlanterInstance]
			flash.message = message(code:"message.chruchPlanter.reference.mail.sent")
			redirect(action:"show", controller:"reference", id:params.churchPlanterInstance)

		}catch(Exception e) {

			//If Exception is thrown,be sure to change locale back
			session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new java.util.Locale(originalLocale.toString(),"")

			//Delete entry of reference and force to try again
			Reference referenceInstance = Reference.get(reference.id)
			referenceInstance.delete(flush:true)

			flash.message="Email failed for"+reference.email
			log.error("Send email to reference failed:"+e.getMessage())
			redirect(action:"show", controller:"reference", id:params.churchPlanterInstance)
		}

	}


	def validateSession={


		def token = params.token
		if(!token){ //No token was passed in
			flash.errorMessage = message(code:"message.chruchPlanter.reference.mail.token.invalidToken")
			render (view:"invalidToken",model:[churchPlanterId:churchPlanterId,dateToken:dateToken,organizationId:organizationId,referenceId:referenceId,localeId:localeId,token:token])
			return null
		}

		//Invalidate Session,(was having issues)
		session.invalidate()

		//Must redirect right after invalidating session
		redirect (action:"validateToken",params:[token:params.token])

	}


	def validateToken={



		boolean validToken = false
		boolean timeExpired = false


		def organizationId
		def churchPlanterId
		def referenceId
		def dateToken
		def localeId

		def token = params.token
		if(!token){ //No token was passed in
			flash.errorMessage = message(code:"message.chruchPlanter.reference.mail.token.invalidToken")
			render (view:"invalidToken",model:[churchPlanterId:churchPlanterId,dateToken:dateToken,organizationId:organizationId,referenceId:referenceId,localeId:localeId,token:token])
			return null
		}

		try{


			String decodedString = EncoderUtility.decode(token)
			String[] parts = decodedString.split(EncoderUtility.SEPERATOR)
			if(parts.length==5) {
				organizationId = parts[0]
				churchPlanterId = parts[1]
				referenceId = parts[2]
				dateToken = parts[3]
				localeId = parts[4]
				session.referenceId = referenceId
			}
			else{
				flash.errorMessage = message(code:"message.chruchPlanter.reference.mail.token.invalidToken")
				render (view:"invalidToken",model:[churchPlanterId:churchPlanterId,dateToken:dateToken,organizationId:organizationId,referenceId:referenceId,localeId:localeId,token:token])
				return null
			}


			//Must check if reference is even in the system anymore. CP may have deleted them
			//Do NOT want to check time expiration first, what if token time has expired but they are not even in system. Do not want to mislead user
			if(churchPlanterId && referenceId){

				boolean foundReference = false
				def references = Reference.findAllByChurchPlanter(ChurchPlanter.get(churchPlanterId))
				for(Reference r:references){
					if(r.id == referenceId.toInteger()){
						foundReference = true
					}
				}

				if(foundReference){
					//So far token is valid and have found reference
					//Check time expiration
					//if(Math.abs(ChurchPlanterUtilities.dateOld(dateToken))<=24 ) {

						//Everything passed!! Change Locale a& allow user to verify Email
						//Always check if user has clicked upper left local link first
						if(params?.lang){
							session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new java.util.Locale(params.lang,Locale.findByValue(params.lang).description)
						}
						else{
							//Change locale from what is being sent in token
							session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new java.util.Locale(Locale.get(localeId).value,Locale.get(localeId).description)
						}
						render (view:"verifyEmail",model:[churchPlanterId:churchPlanterId,dateToken:dateToken,organizationId:organizationId,referenceId:referenceId,localeId:localeId,token:token])
					//}
					//else{
					//	//Reference does exist, but their time has expired/ display a different message
					//	flash.errorMessage = message(code:"message.chruchPlanter.reference.mail.token.timeExpired")
					//	render (view:"invalidToken",model:[churchPlanterId:churchPlanterId,dateToken:dateToken,organizationId:organizationId,referenceId:referenceId,localeId:localeId,token:token])
					//}
				}
				else{
					//They were sent a message and the the CP deleted them after changing their mind.etc
					flash.errorMessage = message(code:"message.chruchPlanter.reference.mail.token.noLongerActive")
					render (view:"invalidToken",model:[churchPlanterId:churchPlanterId,dateToken:dateToken,organizationId:organizationId,referenceId:referenceId,localeId:localeId,token:token])
				}

			}
			else{
				flash.errorMessage = message(code:"message.chruchPlanter.reference.mail.token.invalidToken")
				render (view:"invalidToken",model:[churchPlanterId:churchPlanterId,dateToken:dateToken,organizationId:organizationId,referenceId:referenceId,localeId:localeId,token:token])
				return null
			}

		}
		catch(Exception e) {
			flash.errorMessage = message(code:"message.chruchPlanter.reference.mail.token.execution.error")
			redirect(action:invalidToken)
		}

	}



	def delete={


		try{
			Reference referenceInstance = Reference.get(params.id)
			SurveyResponse surveyResponse = SurveyResponse.findByReference(referenceInstance)
			if(surveyResponse){
				surveyResponse.delete(flush:true)
			}
			referenceInstance.delete(flush:true)


			def churchPlanterInstance = ChurchPlanter.get(session.ChurchPlanterId)
			[churchPlanterInstance:churchPlanterInstance]

			flash.message="Reference deleted"
			redirect(action:"show", controller:"reference", id:params.churchPlanterInstance)
		} catch(Exception e){
			log.error e
			flash.message = "Unable to add reference. Please try again"
			redirect(action:show, id:params.churchPlanterInstance)
		}

	}





	def authenticateEmail={

		def email = params.email
		def organizationId = params.organizationId
		def churchPlanterId = params.churchPlanterId
		def referenceId = params.referenceId
		def localeId = params.localeId
		Reference reference = Reference.get(referenceId)

		if(!email){
			flash.errorMessage = message(code:"message.chruchPlanter.reference.login.invalidEmail")
			redirect (action:"validateToken",params:[token:params.token])

		}
		if(email.toLowerCase() != reference.email.toLowerCase()){
			flash.errorMessage = message(code:"message.chruchPlanter.reference.login.invalidEmail")
			redirect (action:"validateToken",params:[token:params.token])

		}

		boolean valid = false
		def references = Reference.findAllByChurchPlanter(ChurchPlanter.get(churchPlanterId))
		for(Reference r:references){
			if(r.email.equalsIgnoreCase(params.email)){
				valid = true
			}
		}


		if(valid) {
			//Will have to gather more information to display info on beIdentified page
			def cp = ChurchPlanter.get(churchPlanterId)
			def churchPlanterName = cp.firstName +" "+ cp.lastName

			def org = Organization.get(organizationId)
			def organizationName = org.name
			
			render(view:reference?.spouse?'beSpouseIdentified':'beIdentified',model:[churchPlanterId:churchPlanterId,organizationId:organizationId,reference:reference,referenceId:referenceId,localeId:localeId,churchPlanterName:churchPlanterName,organizationName:organizationName])
		}
		else{
			flash.errorMessage = message(code:"message.chruchPlanter.reference.login.invalidEmail")
			redirect(action:'validateToken',params:[token:params.token])
		}
	}


	def beIdentified={

		def referenceId = params.referenceId
		def reference =  Reference.get(referenceId)


		reference.beIdentified = new Boolean(params.beIdentified)
		reference.validate()
		if(!reference.hasErrors() )
		{
			//Save
			reference.save(flush:true,failOnError:true)

			//Then take appropriate directions from their choice
			if(!reference.beIdentified){

				//Contact Church Planter about deletion of reference
				def messageTo = []

				HashMap mailBodyMap = new HashMap()
				mailBodyMap.put "referenceName", reference.name

				def cp = ChurchPlanter.get(params.churchPlanterId)
				messageTo.add cp.email

				//There is no way of knowing what the CP's language choice is
				//Just check that the current locale is present

				//Check Locale before assuming everything is ok
				if(!LCH.getLocale()){
					session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new java.util.Locale("en","US")
					LCH.setLocale(new java.util.Locale("en","US")) //This does not always work?? Go over with Scott
				}

				def messageSubject = messageSource.getMessage('message.chruchPlanter.reference.mail.removedReferenceSubject',null,LCH.getLocale())
				def replyTo =  messageSource.getMessage('message.system.LWR.user.email',null, LCH.getLocale())

				emailService.sendEmail(messageTo, messageSubject, mailBodyMap, "removedReferenceTemplate", replyTo)


				//Delete reference (Deleting last, so we can use reference object info before deleting)
				SurveyResponse surveyResponse = SurveyResponse.findByReference(reference)

				if(surveyResponse){
					surveyResponse.delete(flush:true)
				}
				reference.delete(flush:true)

				render(view: "rejectedBeIdentified")
			}
			else{
				redirect(action:'take',params:[churchPlanterId:params.churchPlanterId,organizationId:params.organizationId,referenceId:params.referenceId,localeId:params.localeId])
			}


		}
		else{
			flash.errorMessage = message(code:"message.chruchPlanter.reference.unableToSaveBeIdentified")
			render(view: "beIdentified", model:[churchPlanterId:params.churchPlanterId,organizationId:params.organizationId,referenceId:params.referenceId,localeId:params.referenceId])
			return null

		}


	}


	def take = {
		if(!session.referenceId && !params.referenceId){
			redirect(controller:'home',action:'login')
		}

		Survey survey = Survey.findByIsForReferences(true)//Will work as long as there is not another reference

		def locale
		//Being passed in from email sent when reference created
		if(params.localeId != null){
			locale = Locale.get(params.localeId)
			session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new java.util.Locale(locale?.value,"")
		}
		else{//If not being passed in, get from local settings
			locale = Locale.findByValue(LocaleContextHolder.getLocale().toString())
		}
		def reference = Reference.get(session.referenceId?:params.referenceId)
		if(!reference){
			redirect(controller:'home',action:'login')
		}
		def surveyTitle = survey.getTranslationByLocale().name
		def organization = reference.churchPlanter.organization
		def churchPlanter = reference.churchPlanter


		def surveyHelper = new SurveyHelper()

		def surveyResponse = surveyHelper.getResponse(survey,churchPlanter,reference) //.this is adding??
		if(params?.question  && surveyResponse) {
			
			surveyResponse.reference = reference

			surveyHelper.saveAnswers(params.question,surveyResponse)
			surveyResponse.refresh()
			if(survey.questions.size() == surveyResponse.answers.size()) {
				surveyResponse.completionDate = new Date()
				surveyResponse.cumulativeScore = surveyHelper.calculateCumulativeScore(surveyResponse)
				reference.hasCompleted = true
				reference.save(flush:true)
				boolean isSpouseReport = reference.isSpouse()
				//surveyResponse.save()
				//int rowsAffected = sql.executeUpdate("update surveyResponse set completionDate = Õsecret addressÕ")

				try{
					def pdfBuild = surveyHelper.pdfBuilder(surveyResponse)
				//	def bytes = (pdfRenderingService.render(template: '/churchPlanter/summaryReport', model: pdfBuild)).buf

					//If All 6 are complete, send to org
					def surveyResponses = SurveyResponse.findAllByChurchPlanterAndSurvey(churchPlanter,survey)
					int completedCount = 0
					def referenceTotalMap = new LinkedHashMap<String,Integer>()
					def referenceScoreMap = new LinkedHashMap<String,Integer>()
					def finalSurveyResponses = new ArrayList<SurveyResponse>()
					
					for(SurveyResponse sr:surveyResponses){
						if(isSpouseReport && sr.completionDate !=null){
							if(g.message(code:'message.churchPlanter.reference.Spouse').
									equalsIgnoreCase(sr.reference?sr.reference.category:'')){
									completedCount++
									finalSurveyResponses.add(sr)
									
							}
							}else if(sr.completionDate !=null &&
								!g.message(code:'message.churchPlanter.reference.Spouse').
									equalsIgnoreCase(sr.reference?sr.reference.category:'')){
							completedCount++
							finalSurveyResponses.add(sr)
							}
						}
				

					//BUILD SUMMARY REPORT AND SEND OUT AS LAST REFERENCE HAS COMPLETED LAST SURVEY
					if(completedCount == 6 || isSpouseReport){
						//Get all 6 survey responses
						finalSurveyResponses.each{ sr ->

							def tmpPdfBuild = surveyHelper.pdfBuilder(sr)
							tmpPdfBuild.categoryPercentageMap.each
							{ catId,score ->
								if(referenceTotalMap[catId]){
									referenceTotalMap[catId] = referenceTotalMap[catId] + score
								}else{
									referenceTotalMap.putAt(catId, score)
								}
							}
						}

						referenceTotalMap.each{k,v ->
							if(!referenceScoreMap[k]){
								referenceScoreMap.putAt(k, (v/completedCount).setScale(0, BigDecimal.ROUND_HALF_UP))
							}

						}

						pdfBuild.categoryPercentageMap = referenceScoreMap

						def cpSurveyResponse = SurveyResponse.findByChurchPlanterAndSurvey(churchPlanter,Survey.get(1))
						if(cpSurveyResponse){
							def cpPercentageMap = surveyHelper.calculateCumulativeCategoryScores(cpSurveyResponse)
							pdfBuild.cpPercentageMap = cpPercentageMap
						}
						def tmpBytes
						if(isSpouseReport){
							tmpBytes = (pdfRenderingService.render(template: '/reference/spouseReferenceReport', model: pdfBuild)).buf
						}else{	
						 	tmpBytes = (pdfRenderingService.render(template: '/reference/referenceReport', model: pdfBuild)).buf
						}
						 //Email the org the 6 completed surveys
						if(!emailService.sendCompletedSurveyNotification(churchPlanter,survey,tmpBytes,surveyTitle+" Survey Report for "+churchPlanter.toString()+".pdf","text/pdf")) {
							printLn "Completed Survey Notification Email Failed. Could not be sent to " + organization.primaryContact
						}


						//return null
						//if return null left in place we get this
						// No such property: surveyResponses for class: com.lifeway.utils.SurveyHelper groovy.lang.MissingPropertyException: No such property: surveyResponses for class: com.lifeway.utils.SurveyHel
						//I think coming from survey Helper line 47 getREponse
					}

				}catch (Exception e){
					log.error e
				}
			}
		}


		def checkTranslation = surveyHelper.checkTranslation(survey,locale)
		def translations = surveyHelper.getTranslations(params,surveyResponse,locale)

		//If no translation exist force to English
		if(!translations){
			flash.errorMessage = message(code:"No translation found, defaulting to English")
			session['org.springframework.web.servlet.i18n.SessionLocaleResolver.LOCALE'] = new java.util.Locale("en","US")

		}

		def model = [churchPlanterId:churchPlanter.id,organizationId:organization.id,surveyTitle:surveyTitle,translations: translations, questionTotal: Question.findAllBySurvey(survey).size(), locale:locale,surveyResponse:surveyResponse,checkTranslation:checkTranslation]
		if (request.xhr) {

			render(template: "grid", model: model)

		}
		else {
			model
		}


	}

}
