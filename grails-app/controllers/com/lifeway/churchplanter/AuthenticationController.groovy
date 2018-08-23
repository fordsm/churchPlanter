package com.lifeway.churchplanter

import org.apache.commons.lang.StringUtils
import com.lifeway.utils.SurveyHelper
import com.lifeway.cpDomain.ChurchPlanter
import com.lifeway.cpDomain.OrgUser


class AuthenticationController {

	def authenticateUser={
		def surveyHelper = new SurveyHelper()
		

		if(params.login) {
			def orgUser = OrgUser.findByEmail (params.login)
			if(orgUser) {
				if(orgUser.password == params.password.encodeAsMessageDigest()) {
					session.UserId = orgUser.id
					session.OrgId=orgUser.organization.id
					if(orgUser.hasAdminPrivileges) {
						session.setAttribute "hasAdminPrivileges", true
					}
					redirect(controller:'home', action:'menu')
				}
				else {
					flash.error  = "login"
					flash.errorMessage = message(code:"message.churchPlanter.login.userLogin.loginFailed")
					redirect(controller:'home', action:'login',params:[caller:'orgUser'])
				}
			}
			else {
				flash.error = "login"
				flash.errorMessage = message(code:"message.churchPlanter.login.userLogin.loginFailed")
				redirect(controller:'home', action:'login',params:[caller:'orgUser'])
			}
		}else {
			flash.error  = "login"
			flash.errorMessage = message(code:"message.churchPlanter.login.userLogin.loginEmpty")
			redirect(controller:'home', action:'login',params:[caller:'orgUser'])
		}
	}

	def authenticateCP={
		def surveyHelper = new SurveyHelper()
		
		if(params.cplogin) {
			def churchPlanter = ChurchPlanter.findByEmail (params.cplogin)

			if(churchPlanter) {
				if(churchPlanter.password == params.password.encodeAsMessageDigest()) {
					session.ChurchPlanterId=churchPlanter.id
					surveyHelper.checkPasscodeSurveys(churchPlanter)
					redirect(controller:'churchPlanter', action:'menu')
				}
				else {
					flash.error  = "login"
					flash.errorMessage = message(code:"message.churchPlanter.login.userLogin.loginFailed")
					redirect(controller:'home', action:'login')
				}
			}
			else {
				flash.error = "login"
				flash.errorMessage = message(code:"message.churchPlanter.login.userLogin.loginFailed")
				redirect(controller:'home', action:'login')
			}
		}else{
		flash.error  = "login"
		flash.errorMessage = message(code:"message.churchPlanter.login.userLogin.loginEmpty")
		redirect(controller:'home', action:'login')
		}
	}
}
