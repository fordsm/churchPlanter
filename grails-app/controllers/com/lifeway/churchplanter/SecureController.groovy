package com.lifeway.churchplanter


class SecureController {

	def beforeInterceptor = [	action:		this.&auth,
		except:	[
			'login',
			'logout',
			'authenticateUser',
			'authenticateCP',
			'register',
			'save',
			'requestPasscode',
			'forgottenPassword',
			'mailForgottenPasswordDetails',
			'resetPassword',
			'enterPasscode',
			'updatePassword',
			'passSearch']
	]

	private auth() {
		def adminExclusiveActionList = [
			'resourceView',
			'saveResource',
			'viewOrgResource',
			'viewResourceURL',
			'createResourceURL',
			'editOrgResource',
			'editResourceURL',
			'saveResourceURL',
			'updateResourceURL',
			'updateOrgResource',
			'deleteResourceURL',
			'deleteOrgResource',
			'previewOrgResource',
			'requestResourceApproval'
		]

		def churchPlanterFreeAccessList = [
			'register',
			'save',
			'requestPasscode',
			'showStates'
		]
		
		def referenceAccessList = [
			'authenticateEmail',
			'invalidToken',
			'requestPasscode',
			'take',
			'validateToken',
			'validateSession',
			'beIdentified'
		]
		
		def searchEngineAccessList = [
			'showSiteMap'
		]

		if((controllerName == 'home')&& (!searchEngineAccessList.contains(actionName))) {
			if(!session.UserId) {
				redirect(controller:'home', action:'login')
				return false
			}
		}

		if((controllerName == 'organization')) {
			if(!session.UserId) {
				redirect(controller:'home', action:'login')
				return false
			}

			if((!session.hasAdminPrivileges) && (adminExclusiveActionList.contains(actionName))) {
				redirect(controller:'home', action:'menu')
				return false
			}
		}

		if(controllerName == 'churchPlanter' && (!churchPlanterFreeAccessList.contains(actionName))) {
			if(!session.ChurchPlanterId ) {
				redirect(controller:'home', action:'login')
				return false
			}
		}
		if(controllerName == 'reference'  && (!referenceAccessList.contains(actionName))) {
			if(!session.ChurchPlanterId) {
				redirect(controller:'home', action:'login')
				return false
			}
		}
	}
}
