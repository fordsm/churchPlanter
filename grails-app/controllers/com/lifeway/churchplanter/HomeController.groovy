package com.lifeway.churchplanter

import grails.util.Environment

import com.lifeway.cpDomain.ChurchPlanter
import com.lifeway.cpDomain.Passcode
import com.lifeway.cpDomain.OrgUser
import com.lifeway.cpDomain.Organization
import com.lifeway.utils.ChurchPlanterUtilities
import com.lifeway.utils.EncoderUtility
import com.lifeway.utils.SurveyHelper;
import com.lifeway.cpDomain.Page

class HomeController extends SecureController{
	EmailService emailService
	def index = {
		if(session.UserId){
			redirect(action:"choose")
		} else if(session.ChurchPlanterId){
			redirect(controller:'churchPlanter', action:'list')
		} else{
			redirect(action:"login")
		}
	}

	def login = {
		if(session.UserId){
			session.UserId = null
		}
		if(session.ChurchPlanterId){
			session.ChurchPlanterId = null
		}
		if(params.caller.equals("orgUser")) {
			render(view:"orgUserLogin")
		}
	}

	def logout = {
		session.invalidate()
		redirect(controller:'home', action:'login')
	}

	def menu = {
		OrgUser orgUser = OrgUser.findById(session.UserId)
		def orgId = params.id
		if(!orgId) {
			orgId = orgUser.organization.id
		}


		render(view:"menu", model:[orgUser:orgUser,organization:Organization.get(orgId)])
	}

	def forgottenPassword = {}
	def changePassword ={
		def userInstance = OrgUser.get(session.UserId)
		[userInstance:userInstance]
	}
	def updateChangedPassword={
	}
	def resetPassword = {
		def token = params.token
		Boolean tokenValidity = false
		try{
			if(token) {
				String decodedString = EncoderUtility.decode(token)

				String[] parts = decodedString.split(EncoderUtility.SEPERATOR)
				if(parts.length==3) {
					def userId = parts[0]
					def caller = parts[1]
					def dateToken = parts[2]

					if((userId)) {
						def user = ("orgUser".equals(caller))?(OrgUser.get(userId)):(ChurchPlanter.get(userId))
						//if(user && (Math.abs(ChurchPlanterUtilities.dateOld(dateToken))<=24) ) {
						tokenValidity = true
						def userInstance = user
						render (view:"resetPassword",model:[userInstance:userInstance,caller:caller])
						//}
					}
				}
			}

			if(!tokenValidity) {
				flash.errorMessage = message(code:"message.orgUser.password.recovery.token.invalid")
				redirect(action:login)
			}
		}
		catch(Exception e) {
			flash.errorMessage = message(code:"message.orgUser.password.recovery.execution.error")
			redirect(action:login)
		}
	}

	def updatePassword={
		def location = params.changepassword
		def caller = null
		def userInstance = null
		flash.clear()
		if(!location) {
			caller = params.caller
			userInstance = ("orgUser".equals( params.caller))?(OrgUser.get(params.id)):(ChurchPlanter.get(params.id))
		}else {
			userInstance = OrgUser.get(params.id)

			if(params.oldpassword.encodeAsMessageDigest()!=userInstance.password) {

				userInstance.errors.reject("message.churchPlanter.changePassword.IncorrectOldPassword","Incorrect Old Password")
			}
		}
		if(!userInstance.hasErrors()){
			if(params.password != params.cpassword) {

				userInstance.errors.rejectValue('password','message.churchPlanter.registration.cpass',"Your passwords do not match")
			}else if(!params.password) {
				userInstance.errors.rejectValue('password','message.churchPlanter.registration.passBlank',"Your password cannot be blank")
			}
			else {
				userInstance.password=params.password.encodeAsMessageDigest()
			}
		}
		if(!location) {
			if(!userInstance.hasErrors() && userInstance.save()) {
				flash.message =message(code:"message.churchPlanter.changePassword.success")
				redirect(action:"login",params:["caller":caller])
			}else{
				render(view: "resetPassword",model:[userInstance:userInstance,caller:caller])
			}
		}
		else {
			if(!userInstance.hasErrors() && userInstance.save()) {
				flash.message =message(code:"message.churchPlanter.changePassword.success")
				redirect(controller:"organization", action:"viewOrgUser", id:userInstance.id)
			}else{
				render(view: "changePassword",model:[userInstance:userInstance])
			}
		}
	}

	def mailForgottenPasswordDetails= {
		def email = params.email
		def caller = params.caller
		def user = ("orgUser".equals(caller))?(OrgUser.findByEmail(email)):(ChurchPlanter.findByEmail(email))

		flash.clear()
		if(user) {

			try {

				if(emailService.sendForgottenPasswordRecoveryEmail(user,caller)) {
				emailService.sendForgottenPasswordRecoveryEmail(user,caller)
					flash.message = message(code:"message.orgUser.login.forgotten.password.emailSent")
					redirect(action:"login",params:["caller":caller])
				}else {
					flash.errorMessage = message(code:"message.orgUser.login.forgotten.password.email.error")
					render(view:"forgottenPassword")

				}
			}
			catch(Exception e){
				    log.error "Error: ${e.message}", e
			}
		}
		else {
			flash.errorMessage = message(code:"message.orgUser.login.forgotten.password.email.notFound")
			render(view:"forgottenPassword")
		}
	}

	def showSiteMap= {
		def pageList = Page.findAllByPublishAndParentPage(true,null);
		render(view: "siteMap",model:[pageList:pageList])
	}

	def enterPasscode= {
	}
}
