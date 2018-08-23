package com.lifeway.churchplanter

import grails.plugin.rendering.pdf.PdfRenderingService


import com.itextpdf.*
import com.lifeway.cpDomain.ChurchPlanter
import com.lifeway.cpDomain.Reference
import com.lifeway.cpDomain.OrgResource
import com.lifeway.cpDomain.CategoryGroup
import com.lifeway.cpDomain.OrgUser
import com.lifeway.cpDomain.Organization
import com.lifeway.cpDomain.ResourceURL
import com.lifeway.cpDomain.Survey
import com.lifeway.cpDomain.SurveyResponse
import com.lifeway.utils.OrganizationHelper
import com.lifeway.utils.SurveyHelper
import com.lifeway.utils.TranslationHelper
import com.lifeway.cpDomain.TutorialResource
import com.lifeway.cpDomain.Locale
import org.springframework.context.i18n.LocaleContextHolder as LCH
import org.codehaus.groovy.grails.commons.ConfigurationHolder as CH
import org.springframework.context.i18n.LocaleContextHolder
import com.lifeway.utils.SearchHelper
import javax.mail.internet.*
import javax.servlet.ServletException


import grails.util.Environment;
import com.lifeway.java.utils.PropLoader;

class OrganizationController{
	EmailService emailService
	PdfRenderingService pdfRenderingService
	def index = {
	}

	// Sub organization List
	def subOrgList = {
		def orgId = (params.id)?:session.OrgId
		[organization:OrganizationHelper.getOrganization(session.OrgId,orgId)]
	}

	// Church planter list
	def churchPlanterList={
		OrgUser orgUser = OrgUser.get(session.UserId)
		def orgId = (params.id)?:session.OrgId
		def organization =  OrganizationHelper.getOrganization(session.OrgId, orgId)
		params.max =  params.max ? params.max.toInteger() : 20
		params.offset = params.offset ? params.offset.toInteger() : 0
		def churchPlanterList = ChurchPlanter.findAllByOrganizationInList(OrganizationHelper.getOganizationHierarchyList(organization),params)
		[churchPlanterList:churchPlanterList,organization:organization,churchPlanterListSize:ChurchPlanter.findAllByOrganizationInList(OrganizationHelper.getOganizationHierarchyList(organization)).size()]
	}

	// Church planter view
	def showChurchPlanter={
		flash.errorMessages=[]
		def churchPlanter = OrganizationHelper.getChurchPlanter(session.OrgId,params.id)
		if(churchPlanter){
			def surveyResponses = SurveyResponse.findAllByChurchPlanter(churchPlanter)
			def surveyResponseMap = [:]
			def umbrellaCompletedMap = [:]
			surveyResponses.each{response ->
				surveyResponseMap[response.survey.id] = response
				def results = CategoryGroup.findAll{
					survey == response.survey
				}
				umbrellaCompletedMap[response.survey.id] = (results != null && results.size() > 0)
			}
			Integer completedCount = 0
			def spouseReference = Boolean.FALSE
			def references = churchPlanter.references.findAll { repo -> repo.churchPlanterId.equals(churchPlanter.id) }
			Survey referencesSurvey = Survey.findByIsForReferences(true)//Will work as long as there is not another reference
			def surveyReferenceResponses = SurveyResponse.findAllByChurchPlanterAndSurvey(churchPlanter,referencesSurvey)
			surveyReferenceResponses.each{response ->		
				def categoryCode = response.reference?response.reference.category:''
				
				if(response.completionDate && !g.message(code:'message.churchPlanter.reference.Spouse').equals(categoryCode)){
					completedCount++
				}
				if(response.completionDate && g.message(code:'message.churchPlanter.reference.Spouse').equals(categoryCode)){
					spouseReference = Boolean.TRUE
				}
			}
			
				[churchPlanter:churchPlanter,
			    umbrellaCompletedMap:umbrellaCompletedMap,
				surveyResponse:surveyResponseMap,
				surveys:churchPlanter.passcode.surveys,
				references:references,
				referencesSurvey:referencesSurvey,
				completedCount:completedCount,
				spouseReference:spouseReference]
		} else{
			flash.errorMessages.add message(code:"message.organization.controller.churchPlanterNotFound")
			redirect(action:churchPlanterList)
		}
	}

	def subOrganization = {
	}

	def emailReport(to,from,messagecontent,userlist,isHtml){
	}



	// Maintenance View
	def maintenance={
		OrgUser orgUser = OrgUser.get(session.UserId)
		render(view:"maintenance",model:[organization:orgUser.organization])
	}

	// Organizational User List
	def orgUserList={
		OrgUser orgUser = OrgUser.get(session.UserId)
		def orgId = (params.id)?:session.OrgId
		def modificationPrivileges = true
		params.max =  params.max ? params.max.toInteger() : 10
		params.offset = params.offset ? params.offset.toInteger() : 0
		def organization = OrganizationHelper.getOrganization(session.OrgId,orgId)
		def orgUserTotalList =  OrgUser.findAllByOrganizationAndIdNotEqual(organization,orgUser.id)
		def orgUserList = OrgUser.findAllByOrganizationAndIdNotEqual(organization,orgUser.id,params)

		if((!orgUser.hasAdminPrivileges)||(orgId.toInteger() != session.OrgId)) {
			modificationPrivileges = false
		}
		[orgUserList:orgUserList,modificationPrivileges:modificationPrivileges,orgUserListSize:orgUserTotalList.size(),organization:organization]
	}

	// Org User View
	def viewOrgUser={
		OrgUser orgUser = OrgUser.get(session.UserId)
		def modificationPrivileges = false
		def orgUserInstance = OrganizationHelper.getOrgUser(session.OrgId,params.id)
		if(orgUserInstance) {
			if(((session.hasAdminPrivileges)&&(orgUserInstance.organization.id == session.OrgId))||(orgUserInstance.id == session.UserId)) {
				modificationPrivileges = true
			}
			[orgUserInstance:orgUserInstance,modificationPrivileges:modificationPrivileges]
		}else {
			redirect(action:"orgUserList")
		}
	}

	// create org user
	def createOrgUser={
		if(session.hasAdminPrivileges) {
			render (view:"createOrgUser",model:[organization:Organization.get(session.OrgId)])
		}else {
			redirect(controller:"organization", action:"orgUserList", id: orgUser.organization.id)
		}
	}


	// Edit Org User
	def editOrgUser={
		OrgUser orgUser = OrgUser.get(session.UserId)
		def orgUserInstance  = OrgUser.get(params.id)
		def modificationPrivileges = false
		flash.errorMessages=[]
		if(orgUserInstance) {
			if(((session.hasAdminPrivileges)&&(orgUserInstance.organization.id == session.OrgId))||(orgUserInstance.id == session.UserId)) {
				modificationPrivileges = true
				render(view: "editOrgUser", model: [orgUserInstance: orgUserInstance])
			}
			else {
				render(view: "viewOrgUser", model: [orgUserInstance:orgUserInstance,modificationPrivileges:modificationPrivileges])
			}
		}else {
			flash.errorMessages.add  message(code:"message.organization.controller.OrgUserNotFound")
			redirect(controller:"organization", action:"orgUserList", id: session.OrgId)
		}
	}

	//Save Org User
	def saveOrgUser = {
		def orgUserInstance = new OrgUser(params)
		if(params.password != params.confirmpassword) {
			orgUserInstance.errors.rejectValue('password','message.churchPlanter.registration.cpass',"Your passwords do not match")
		}else if(!params.password) {
			orgUserInstance.errors.rejectValue('password','message.churchPlanter.registration.passBlank',"Your password cannot be blank")
		}
		else{
			orgUserInstance.password=orgUserInstance.password.encodeAsMessageDigest()
		}
		if(!orgUserInstance.hasErrors() && orgUserInstance.save()) {
			flash.message = message(code:"message.organization.controller.OrgUserSaved")
			redirect(controller:"organization", action:"orgUserList", id: orgUserInstance.organization.id)
		}else{
			orgUserInstance.errors.reject("message.organization.controller.OrgUserNotSaved","User could not be saved !!!")
			orgUserInstance.password = params.password
			render(view: "createOrgUser", model: [organization:Organization.get(session.OrgId),orgUserInstance: orgUserInstance])
		}
	}

	// Update Org User
	def updateOrgUser = {
		flash.errorMessages=[]
		def orgUserInstance = OrgUser.get(params.id)
		if(orgUserInstance) {
			orgUserInstance.properties = params

			if(orgUserInstance.save()) {
				flash.message = message(code:"message.organization.controller.OrgUserUpdated")
				redirect(controller:"organization", action:"viewOrgUser", id:params.id)
			}else {
				orgUserInstance.errors.reject("message.organization.controller.OrgUserNotSaved","User could not be saved !!!")
				render(view: "editOrgUser", model: [orgUserInstance: orgUserInstance])
			}
		}else {
			flash.errorMessages.add  message(code:"message.organization.controller.OrgUserNotFound")
			redirect(controller:"organization", action:"orgUserList", id: session.OrgId)
		}
	}

	// Delete Org User
	def deleteOrgUser = {
		flash.errorMessages=[]
		OrgUser orgUser = OrgUser.get(session.UserId)
		def orgUserInstance = OrgUser.get(params.id)
		if (orgUserInstance && session.hasAdminPrivileges && session.OrgId == orgUserInstance.organization.id) {
			try {
				orgUserInstance.delete(flush: true)
				flash.message =  message(code:"message.organization.controller.OrgUserDeleted")
				redirect(controller:"organization", action:"orgUserList", id:params.id)
			}
			catch (Exception e) {
				log.error e
				flash.errorMessages.add message(code:"message.organization.controller.OrgUserDeleteFailed")
				redirect(controller:"organization", action:"viewOrgUser", id:params.id)
			}
		}else {
			flash.errorMessages.add  message(code:"message.organization.controller.OrgUserNotFound")
			redirect(action: "orgUserList")
		}
	}

	// Resource View renders a view of the organization resources
	def resourceView={
		OrgUser orgUser = OrgUser.get(session.UserId)
		Organization org = orgUser.organization
		def orgResourceInstance = null
		def approvedOrgResourceInstance = null
		org.orgResources.each{orgResource ->
			if(orgResource && (!orgResource.isApproved)) {
				orgResourceInstance=orgResource
			}
			if(orgResource && (orgResource.isApproved)) {
				approvedOrgResourceInstance=orgResource
			}
		}
		if(orgResourceInstance) {
			render (view:"viewOrgResource",model:[organization:org,orgResourceInstance:orgResourceInstance,approvedOrgResourceInstance:approvedOrgResourceInstance])
		}
		else {
			orgResourceInstance = new OrgResource()
			orgResourceInstance.organization = org
			render (view:"createOrgResource",model:[organization:org,orgResourceInstance:orgResourceInstance])
		}
	}

	// Save resource
	def saveResource = {
		OrgUser orgUser = OrgUser.get(session.UserId)
		Organization org = orgUser.organization
		def orgResourceInstance = null

		org.orgResources.each{orgResource ->
			if(orgResource && (!orgResource.isApproved)) {
				orgResourceInstance=orgResource
			}
		}
		if(!orgResourceInstance) {
			orgResourceInstance = new OrgResource(params)
			orgResourceInstance.organization = org
			flash.errorMessages=[]
			try{
				if(orgResourceInstance.save(flush:true)) {
					flash.message =message(code:"message.churchPlanter.organization.OrgResourceSaved")
					redirect(controller:"organization", action:"resourceView")
				}else{
					render(view: "createOrgResource", model: [orgResourceInstance: orgResourceInstance])
				}
			}
			catch(Exception e) {
				flash.errorMessages.add message(code:"message.churchPlanter.organization.OrgResourceNotSaved")
				render(view: "createOrgResource", model: [orgResourceInstance: orgResourceInstance])
			}
		}else {
			redirect(action: "resourceView")
		}
	}

	// view org resource
	def viewOrgResource=
	{
		OrgUser orgUser = OrgUser.get(session.UserId)
		Organization org = orgUser.organization
		def orgResourceInstance = null
		def approvedOrgResourceInstance = null

		org.orgResources.each{orgResource ->
			if(orgResource && (!orgResource.isApproved)) {
				orgResourceInstance=orgResource
			}
			if(orgResource && (orgResource.isApproved)) {
				approvedOrgResourceInstance=orgResource
			}
		}
		if(orgResourceInstance) {
			[orgResourceInstance:orgResourceInstance,approvedOrgResourceInstance:approvedOrgResourceInstance]
		}else {
			redirect(action: "resourceView")
		}
	}

	// view resource URL
	def viewResourceURL=
	{
		OrgUser orgUser = OrgUser.get(session.UserId)
		Organization org = orgUser.organization
		def resourceURLInstance = ResourceURL.get(params.id)
		def orgResourceInstance = null

		orgUser.organization.orgResources.each{orgResource ->
			if(orgResource && (!orgResource.isApproved)) {
				orgResourceInstance=orgResource
			}
		}
		if(resourceURLInstance && (orgResourceInstance) &&(orgResourceInstance.id ==resourceURLInstance.orgResource.id))
			[resourceURLInstance:resourceURLInstance]
		else
			redirect(controller:"organization", action:"resourceView")
	}

	/*
	 *  create resource URL
	 */
	def createResourceURL={
		OrgUser orgUser = OrgUser.get(session.UserId)
		def orgResourceInstance = null

		orgUser.organization.orgResources.each{orgResource ->
			if(orgResource && (!orgResource.isApproved)) {
				orgResourceInstance=orgResource
			}
		}

		if(orgResourceInstance) {
			render (view:"createResourceURL",model:[orgResourceInstance:orgResourceInstance])
		}else {
			redirect(controller:"organization", action:"resourceView")
		}
	}

	/*
	 *  Save Resource URL for an org resource
	 */

	def saveResourceURL= {
		OrgUser orgUser = OrgUser.get(session.UserId)
		Organization org = orgUser.organization

		def resourceURLInstance = new ResourceURL(params)
		if(resourceURLInstance.save()) {
			flash.message = message(code:"message.churchPlanter.organization.OrgResourceURLSaved")
			redirect(controller:"organization", action:"resourceView")
		}else {
			render(view: "createResourceURL", model: [orguser:orgUser,organization:org,resourceURLInstance: resourceURLInstance])
		}
	}

	/*
	 *  Edit Resource URL
	 */
	def editResourceURL={
		def resourceURLInstance  = ResourceURL.get(params.id)
		render(view: "editResourceURL", model: [resourceURLInstance: resourceURLInstance])
	}

	/*
	 * Edit Org Resource 
	 */

	def editOrgResource={
		OrgUser orgUser = OrgUser.get(session.UserId)
		Organization org = orgUser.organization
		def orgResourceInstance = null
		org.orgResources.each{orgResource ->
			if(orgResource && (!orgResource.isApproved)) {
				orgResourceInstance=orgResource
			}
		}

		if(orgResourceInstance) {
			render(view: "editOrgResource", model: [orgResourceInstance: orgResourceInstance])
		}else {
			redirect(controller:"organization", action:"resourceView")
		}
	}


	/*
	 * update Resource URL
	 */

	def updateResourceURL={
		def resourceURLInstance = ResourceURL.get(params.id)
		resourceURLInstance.properties = params
		if(resourceURLInstance.save()){
			flash.message = message(code:"message.churchPlanter.organization.OrgResourceURLUpdated")
			redirect(controller:"organization", action:"viewResourceURL", id:params.id)
		}else{
			render(view: "editResourceURL", model: [resourceURLInstance: resourceURLInstance])
		}
	}

	/*
	 * Delete Resource URL
	 */

	def deleteResourceURL={
		def resourceURLInstance = ResourceURL.get(params.id)
		flash.errorMessages=[]
		if (resourceURLInstance) {
			try {

				resourceURLInstance.delete(flush: true)
				flash.message = message(code:"message.churchPlanter.organization.OrgResourceURLDeleted")
				redirect(controller:"organization", action:"resourceView", id:params.id)
			}
			catch (Exception e) {
				flash.errorMessages.add message(code:"message.churchPlanter.organization.OrgResourceURLNotDeleted")
				redirect(controller:"organization", action:"resourceView", id:params.id)
			}
		}else {
			flash.errorMessages.add message(code:"message.churchPlanter.organization.OrgResourceURLNotFound")
			redirect(action: "resourceView")
		}
	}

	/*
	 * update Org Resource
	 */

	def updateOrgResource={

		def orgResourceInstance = OrgResource.get(params.id)
		orgResourceInstance.properties = params
		if(orgResourceInstance.save()){
			flash.message = message(code:"message.churchPlanter.organization.OrgResourceUpdated")
			redirect(controller:"organization", action:"viewOrgResource", id:params.id)
		}else{
			render(view: "editOrgResource", model: [orgResourceInstance: orgResourceInstance])
		}
	}

	/*
	 * Delete Org Resource
	 */

	def deleteOrgResource={
		def orgResourceInstance = OrgResource.get(params.id)
		flash.errorMessages=[]
		if (orgResourceInstance) {
			try {

				orgResourceInstance.delete(flush: true)
				flash.message = message(code:"message.churchPlanter.organization.OrgResourceDeleted")
				redirect(controller:"organization", action:"resourceView", id:params.id)
			}
			catch (Exception e) {
				flash.error = message(code:"message.churchPlanter.organization.OrgResourceNotDeleted")
				redirect(controller:"organization", action:"resourceView", id:params.id)
			}
		}else {
			flash.errorMessages.add message(code:"message.churchPlanter.organization.OrgResourceNotFound")
			redirect(action: "resourceView")
		}
	}



	def previewOrgResource= {
		OrgUser orgUser = OrgUser.get(session.UserId)
		Organization org = orgUser.organization

		def orgResourceInstance = null

		org.orgResources.each{orgResource ->
			if(orgResource && (!orgResource.isApproved) && (params.approved=='false')) {
				orgResourceInstance=orgResource
			}
			if(orgResource && (orgResource.isApproved) && (params.approved=='true')) {
				orgResourceInstance=orgResource
			}
		}
		if(orgResourceInstance) {
			[orgResourceInstance:orgResourceInstance]
		}else {
			redirect(action: "resourceView")
		}
	}

	def requestResourceApproval= {
		def orgResourceInstance = OrgResource.get(params.id)
		orgResourceInstance.approvalRequested = Boolean.TRUE
		orgResourceInstance.save(flush:true)
		OrgUser orgUser = OrgUser.get(session.UserId)
		if(emailService.sendResourceApprovalRequestEmail(orgUser)) {
			flash.message = message(code:"message.resource.approval.mail.successfullySent")
			redirect(action: "resourceView")
		}else {

			flash.error =  message(code:"message.resource.approval.mail.failed")
			redirect(action: "resourceView")
		}
	}

	def summaryReport = {
		flash.errorMessages=[]
		def churchPlanter = OrganizationHelper.getChurchPlanter(session.OrgId,params.ChurchPlanterId)
		TranslationHelper tc = new TranslationHelper()
		if(churchPlanter) {
			Survey survey = Survey.get(params.id)
			def surveyHelper = new SurveyHelper()
			def surveyResponse = SurveyResponse.findBySurveyAndChurchPlanter(survey,churchPlanter)

			def pdfBuild = surveyHelper.pdfBuilder(surveyResponse)
			pdfBuild.englishCategoryNames = tc.getEnglishCategoryNames()
			if(params.pdf) {
				def pdfFilename = message(code:"message.churchPlanter.surveyReport.pdfFileName", args:[
					survey.getTranslationByLocale()?.name?:"",
					churchPlanter.toString()
				])+".pdf"
				renderPdf(template: '/churchPlanter/summaryReport', model:pdfBuild, filename:pdfFilename)
			}else {
				render(view:'/churchPlanter/summaryReport',model:pdfBuild)		
			}
		}else{
			flash.errorMessages.add message(code:"message.organization.controller.churchPlanterNotFound")
			redirect(action:churchPlanterList)
		}
	}
	
	def umbrellaReport={
		flash.errorMessages=[]
		def churchPlanter = OrganizationHelper.getChurchPlanter(session.OrgId,params.ChurchPlanterId)
		TranslationHelper tc = new TranslationHelper()
		if(churchPlanter) {
			Survey survey = Survey.get(params.id)
			def surveyHelper = new SurveyHelper()
			def surveyResponse = SurveyResponse.findBySurveyAndChurchPlanter(survey,churchPlanter)

			def pdfBuild = surveyHelper.pdfBuilder(surveyResponse)
			pdfBuild.englishCategoryNames = tc.getEnglishCategoryNames()
			if(params.pdf) {
				def pdfFilename = message(code:"message.churchPlanter.umbrellaReport.pdfFileName", args:[
					survey.getTranslationByLocale()?.name?:"",
					churchPlanter.toString()
				])+".pdf"
				renderPdf(template: 'umbrellaReport', model:pdfBuild, filename:pdfFilename)
			}else {
				pdfBuild
			}
		}else{
			flash.errorMessages.add message(code:"message.organization.controller.churchPlanterNotFound")
			redirect(action:churchPlanterList)
		}
	}
	
	def tieredReport={
		flash.errorMessages=[]
		def churchPlanter = OrganizationHelper.getChurchPlanter(session.OrgId,params.ChurchPlanterId)
		if(churchPlanter) {
			Survey survey = Survey.get(params.id)
			def surveyHelper = new SurveyHelper()
			def surveyResponse = SurveyResponse.findBySurveyAndChurchPlanter(survey,churchPlanter)

			def pdfBuild = surveyHelper.pdfBuilder(surveyResponse)
			def tier1 = []
			def tier2 = []
			def tier3 = []
			def tier4 = []

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

			if(params.pdf) {
				def pdfFilename = message(code:"message.churchPlanter.tieredReport.pdfFileName", args:[
					survey.getTranslationByLocale()?.name?:"",
					churchPlanter.toString()
				])+".pdf"
				renderPdf(template: '/organization/tieredReport', model:pdfBuild, filename:pdfFilename)
			}else {
				render(view:"/organization/tieredReport",model:pdfBuild)
			}



		}else{
			flash.errorMessages.add message(code:"message.organization.controller.churchPlanterNotFound")
			redirect(action:churchPlanterList)
		}
	}


	/*Created for 360 degree*/
	def referenceSummaryReport={

		def locale = Locale.findByValue(LocaleContextHolder.getLocale().toString())

		flash.errorMessages=[]
		def churchPlanter = OrganizationHelper.getChurchPlanter(session.OrgId,params.ChurchPlanterId)
		if(churchPlanter) {
			Survey survey = Survey.findByIsForReferences(true)
			def surveyHelper = new SurveyHelper()

			def reference = Reference.get(params.ReferenceId)
			def surveyResponse = SurveyResponse.find('from SurveyResponse as sr where sr.survey=:survey and sr.churchPlanter=:churchPlanter and reference=:reference',[survey:survey,churchPlanter:churchPlanter,reference:reference])

			def pdfBuild = surveyHelper.pdfBuilder(surveyResponse)

			if(params.pdf) {
				def pdfFilename = message(code:"message.churchPlanter.surveyReport.pdfFileName", args:[
					survey.getTranslationByLocale(locale).name,
					churchPlanter.toString()
				])+".pdf"
				renderPdf(template: '/churchPlanter/summaryReport', model:pdfBuild, filename:pdfFilename)
			}else {
				render(view:"/churchPlanter/summaryReport",model:pdfBuild)
			}
		}else{
			flash.errorMessages.add message(code:"message.organization.controller.churchPlanterNotFound")
			redirect(action:churchPlanterList)
		}
	}

	def emailForm={
		def locale = Locale.findByValue(LocaleContextHolder.getLocale().toString())

		def mailToList = []
		OrgUser orgUser = OrgUser.get(session.UserId)
		//mailToList = OrganizationHelper.getMailToList(orgUser)
		def churchPlanter = ChurchPlanter.get(params.ChurchPlanterId)
		def survey = Survey.get(params.id)
		def attachment = message(code:params.tiered?"message.churchPlanter.tieredReport.pdfFileName":"message.churchPlanter.surveyReport.pdfFileName", args:[
			survey.getTranslationByLocale(locale).name,
			churchPlanter.toString()
		])+".pdf"
		[mailToList:mailToList,attachment:attachment]
	}





	def referenceEmailForm={
		def isSpouseReport = false
		def attachment
		def locale = Locale.findByValue(LocaleContextHolder.getLocale().toString())
		if(params.spouse){
			isSpouseReport=true
		}
		def mailToList = []
		OrgUser orgUser = OrgUser.get(session.UserId)
		mailToList = OrganizationHelper.getMailToList(orgUser)
		def churchPlanter = ChurchPlanter.get(params.ChurchPlanterId)
		Survey survey = Survey.findByIsForReferences(true)
		
		if(isSpouseReport){
			attachment = message(code:"message.churchPlanter.spouse.referenceReport.pdfFileName", args:[
				survey.getTranslationByLocale(locale).name,
				churchPlanter.toString()])+".pdf"
		}else{
			attachment = message(code:"message.churchPlanter.referenceReport.pdfFileName", args:[
				survey.getTranslationByLocale(locale).name,
				churchPlanter.toString()])+".pdf"
		}
		 
		render(view:"referenceForm",model:[mailToList:mailToList,attachment:attachment,isSpouseReport:isSpouseReport])

	}

	def sendReportEmail={
		flash.errorMessages=[]
		OrgUser orgUser = OrgUser.get(session.UserId)
		def churchPlanter = ChurchPlanter.get(params.ChurchPlanterId)
		def survey = Survey.get(params.id)
		def surveyHelper = new SurveyHelper()
		def surveyResponse = SurveyResponse.findBySurveyAndChurchPlanter(survey,churchPlanter)
		def mailToList = []

		def pdfBuild = surveyHelper.pdfBuilder(surveyResponse)
		if(params.tiered){
			def tier1 = []
			def tier2 = []
			def tier3 = []
			def tier4 = []
			pdfBuild.categories.sort{a,b -> a.id.compareTo((b.id))}.each{category ->
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
		def docBytes = (pdfRenderingService.render(template: params.tiered?'/organization/tieredReport':'/churchPlanter/summaryReport', model: pdfBuild)).buf
		def filename = message(code: params.tiered?"message.churchPlanter.tieredReport.pdfFileName":"message.churchPlanter.surveyReport.pdfFileName", args:[
			survey.getTranslationByLocale().name,
			churchPlanter.toString()
		])+".pdf"

		def tmpMailToList = []
		//String was never tested:Added cleansing code
		if((params.mailToList) instanceof String ) {
			String tmpString = params.mailToList
			tmpString = tmpString.replaceAll("\\s+", " ");//remove extra white spaces
			tmpString = tmpString.replace(" ",",")//replace white space(s) with comma
			tmpString = tmpString.replace(";",",")//replace semicolons with comma
			tmpString = tmpString.replaceAll("\\;+", ";");//remove extra semicolons
			tmpString = tmpString.replaceAll("\\,+", ",");//remove extra commas

			tmpMailToList = tmpString.split(',')//split by comma

			tmpMailToList.each {strEmail-> mailToList.add strEmail}
		}else{
			params.mailToList.each {strEmail-> mailToList.add strEmail}
		}

		if(mailToList.size() < 1) {
			flash.errorMessages.add message(code:"message.organization.controller.churchPlanter.surveyReport.email.reciepint.blank")
			redirect (action:"emailForm",id:survey.id,params:[ChurchPlanterId:churchPlanter.id] )
		}
		else{

			//Check for invalid email addresses
			boolean hasInvalidEmails = false;
			def invalidEmails = new StringBuilder()
			for(email in mailToList){
				def tmp = emailService.isValidEmailAddress(email)
				if(!tmp){
					invalidEmails.append(email+" ")
					hasInvalidEmails = true
				}
			}

			if(hasInvalidEmails){
				flash.errorMessages.add message(code:"message.organization.controller.churchPlanter.surveyReport.invalidEmailAddress",args:[invalidEmails])
				redirect (action:"emailForm",id:survey.id,params:[ChurchPlanterId:churchPlanter.id] )
			}
			else{

				try{
					if(emailService.sendEmailWithAttachment(mailToList, params.messageSubject,params.messageBody,orgUser.email,docBytes,filename,"text/pdf")) {
						flash.message = message(code:"message.organization.controller.churchPlanter.surveyReport.emailSent")
						redirect (action:"showChurchPlanter",id:params.ChurchPlanterId)
					}
				}
				catch ( org.springframework.mail.MailParseException e) {
					if(e.getCause() != null && e.getCause() instanceof javax.mail.internet.AddressException){
						if(e.getMessage().find("Illegal whitespace in address")){
							flash.errorMessages.add message(code:"message.organization.controller.churchPlanter.surveyReport.whitespace")
							redirect (action:"emailForm",id:survey.id,params:[ChurchPlanterId:churchPlanter.id] )
						}
					}
					else{
						
						log.error "The Email Could Not Be Sent for User "+orgUser+" to the following users >>  "+params.mailToList
						flash.errorMessages.add message(code:"message.organization.controller.churchPlanter.surveyReport.emailFailed")
						redirect (action:"emailForm",id:survey.id,params:[ChurchPlanterId:churchPlanter.id] )
					}
				}
				catch (Exception e) {
					log.error "The Email Could Not Be Sent for User "+orgUser+" to the following users >>  "+params.mailToList
					flash.errorMessages.add message(code:"message.organization.controller.churchPlanter.surveyReport.emailFailed")
					redirect (action:"emailForm",id:survey.id,params:[ChurchPlanterId:churchPlanter.id] )
				}
			}
		}



	}
	def sendReferenceReportEmail = {
		def isSpouseReport = false
		def referenceTotalMap = new LinkedHashMap<String,Integer>()
		def referenceScoreMap = new LinkedHashMap<String,Integer>()
		def finalSurveyResponses = new ArrayList<SurveyResponse>()
		def spouseReference = new SurveyResponse()
		flash.errorMessages=[]
		OrgUser orgUser = OrgUser.get(session.UserId)
		def churchPlanter = ChurchPlanter.get(params.ChurchPlanterId)
		def survey = Survey.get(params.id)
		def surveyHelper = new SurveyHelper()
		def surveyResponse = SurveyResponse.findBySurveyAndChurchPlanter(survey,churchPlanter)
		def surveyResponses = SurveyResponse.findAllByChurchPlanterAndSurvey(churchPlanter,survey)
		int completedCount = 0
		def mailToList = []
		def pdfBuild = surveyHelper.pdfBuilder(surveyResponse)
		if(params.spouse){
			isSpouseReport=true
			pdfBuild.isSpouseReport= true;
		}
		for(SurveyResponse sr:surveyResponses){
		if(isSpouseReport && sr.completionDate !=null){
			if(g.message(code:'message.churchPlanter.reference.Spouse').
					equalsIgnoreCase(sr.reference?sr.reference.category:'')){
					spouseReference = sr
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
		if(completedCount >= 1 ){

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
			
		}
		def docBytes
		def filename	
		if(isSpouseReport){
			docBytes = (pdfRenderingService.render(template: '/reference/spouseReferenceReport', model: pdfBuild)).buf
		 	filename = message(code: 'message.churchPlanter.spouse.referenceReport.pdfFileName', args:[
			survey.getTranslationByLocale().name,
			churchPlanter.toString()
		])+".pdf"
		}else{
		 	docBytes = (pdfRenderingService.render(template: '/reference/referenceReport', model: pdfBuild)).buf
		 	filename = message(code: 'message.churchPlanter.referenceReport.pdfFileName', args:[
			survey.getTranslationByLocale().name,
			churchPlanter.toString()
		])+".pdf"
		
		}
		def tmpMailToList = []
		//String was never tested:Added cleansing code
		if((params.mailToList) instanceof String ) {
			String tmpString = params.mailToList
			tmpString = tmpString.replaceAll("\\s+", " ");//remove extra white spaces
			tmpString = tmpString.replace(" ",",")//replace white space(s) with comma
			tmpString = tmpString.replace(";",",")//replace semicolons with comma
			tmpString = tmpString.replaceAll("\\;+", ";");//remove extra semicolons
			tmpString = tmpString.replaceAll("\\,+", ",");//remove extra commas

			tmpMailToList = tmpString.split(',')//split by comma

			tmpMailToList.each {strEmail-> mailToList.add strEmail}
		}else{
			params.mailToList.each {strEmail-> mailToList.add strEmail}
		}

		if(mailToList.size() < 1) {
			flash.errorMessages.add message(code:"message.organization.controller.churchPlanter.surveyReport.email.reciepint.blank")
			redirect (action:"emailForm",id:survey.id,params:[ChurchPlanterId:churchPlanter.id] )
		}
		else{

			//Check for invalid email addresses
			boolean hasInvalidEmails = false;
			def invalidEmails = new StringBuilder()
			for(email in mailToList){
				def tmp = emailService.isValidEmailAddress(email)
				if(!tmp){
					invalidEmails.append(email+" ")
					hasInvalidEmails = true
				}
			}

			if(hasInvalidEmails){
				flash.errorMessages.add message(code:"message.organization.controller.churchPlanter.surveyReport.invalidEmailAddress",args:[invalidEmails])
				redirect (action:"emailForm",id:survey.id,params:[ChurchPlanterId:churchPlanter.id] )
			}
			else{

				try{
					if(emailService.sendEmailWithAttachment(mailToList, params.messageSubject,params.resourceText,orgUser.email,docBytes,filename,"text/pdf")) {
						flash.message = message(code:"message.organization.controller.churchPlanter.surveyReport.emailSent")
						redirect (action:"showChurchPlanter",id:params.ChurchPlanterId)
					}
				}
				catch ( org.springframework.mail.MailParseException e) {
					if(e.getCause() != null && e.getCause() instanceof javax.mail.internet.AddressException){
						if(e.getMessage().find("Illegal whitespace in address")){
							flash.errorMessages.add message(code:"message.organization.controller.churchPlanter.surveyReport.whitespace")
							redirect (action:"emailForm",id:survey.id,params:[ChurchPlanterId:churchPlanter.id] )
						}
					}
					else{
						log.error "The Email Could Not Be Sent for User "+orgUser+" to the following users >>  "+params.mailToList
						flash.errorMessages.add message(code:"message.organization.controller.churchPlanter.surveyReport.emailFailed")
						redirect (action:"emailForm",id:survey.id,params:[ChurchPlanterId:churchPlanter.id] )
					}
				}
				catch (Exception e) {
					log.error "The Email Could Not Be Sent for User "+orgUser+" to the following users >>  "+params.mailToList
					flash.errorMessages.add message(code:"message.organization.controller.churchPlanter.surveyReport.emailFailed")
					redirect (action:"emailForm",id:survey.id,params:[ChurchPlanterId:churchPlanter.id] )
				}
			}
		}

		
		}
	
	
	def referenceReport = {
		def surveyHelper = new SurveyHelper()
		ChurchPlanter churchPlanter = ChurchPlanter.get(params.ChurchPlanterId)
		Survey survey = Survey.get(params.id)
		//If All 6 are complete, send to org
		def surveyResponses = SurveyResponse.findAllByChurchPlanterAndSurvey(churchPlanter,survey)
		def spouseReference = new SurveyResponse()
		def isSpouseReport = false
		int completedCount = 0
		def referenceTotalMap = new LinkedHashMap<String,Integer>()
		def referenceScoreMap = new LinkedHashMap<String,Integer>()
		def finalSurveyResponses = new ArrayList<SurveyResponse>()
		def pdfBuild = surveyHelper.pdfBuilder(SurveyResponse.findByChurchPlanterAndSurvey(churchPlanter,survey))
		if(params.spouse){
			isSpouseReport=true
			pdfBuild.isSpouseReport= true;
		}
		for(SurveyResponse sr:surveyResponses){
			if(isSpouseReport && sr.completionDate !=null){
			if(g.message(code:'message.churchPlanter.reference.Spouse').
					equalsIgnoreCase(sr.reference?sr.reference.category:'')){
					spouseReference = sr
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
		if(completedCount >= 1 ){
			//Get all 6 survey responses or Spouse 
			finalSurveyResponses.each{ surveyResponse ->
				def tmpPdfBuild = surveyHelper.pdfBuilder(surveyResponse)
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
			
			
			if(params.pdf) {
				if(isSpouseReport){
					def pdfFilename = message(code:"message.churchPlanter.spouse.referenceReport.pdfFileName", args:[
						survey.getTranslationByLocale()?.name?:"",
						churchPlanter.toString()
					])+".pdf"
					renderPdf(template: '/reference/spouseReferenceReport', model:pdfBuild, filename:pdfFilename)
				}else{
					def pdfFilename = message(code:"message.churchPlanter.referenceReport.pdfFileName", args:[
					survey.getTranslationByLocale()?.name?:"",churchPlanter.toString()])+".pdf"
					renderPdf(template: '/reference/referenceReport', model:pdfBuild, filename:pdfFilename)
				}
			}else {
				if(isSpouseReport){
					render(view:"spouseReferenceReport",model:pdfBuild)
				}else{
					render(view:"referenceReport",model:pdfBuild)
				}
			}

			
		}

		
		
		}
	
	
	
	def viewChurchPlanterReports= {
	}
	
	def searchList={
		params.max = 20
		OrgUser orgUser = OrgUser.get(session.orgUserId)
		def orgId = (params.id)?:session.OrgId
		def organization =  Organization.get(session.OrgId)
		
		params.organizationId = organization?.id
		
		params.max =  params.max ? params.max.toInteger() : 20
		params.offset = params.offset ? params.offset.toInteger() : 0
		def churchPlanterList = ChurchPlanter.findAllByOrganizationInList(OrganizationHelper.getOganizationHierarchyList(organization),params)
		
		
		
//		if(params.childOrgs == null){
//			params.childOrgs = organization.getAllChildOrganizations()
//			params.selectAllDept = true
//		}
		def sh = new SearchHelper()
		def (userInstanceTotal, userInstanceList) = sh.getUserSearchResults(params)
		println(userInstanceList)
		[userInstanceTotal:userInstanceTotal,userInstanceList:userInstanceList, orgUser:orgUser,params:params,organization:organization,churchPlanterListSize:ChurchPlanter.findAllByOrganizationInList(OrganizationHelper.getOganizationHierarchyList(organization)).size()]
		
	}
	
	def tutorials = {
		Properties properties = new PropLoader("s3.properties").getProperties();
		String s3Url = properties.getProperty("S3_REMOTE_FILE_URL");
		String environment = Environment.getCurrent().toString().toLowerCase();

		def cpcaTutorials = TutorialResource.findAllByType("CPCA Tutorials")
		def assessmentResources = TutorialResource.findAllByType("Assessment Resources")
		def churchplanterResources = TutorialResource.findAllByType("Church Planting Resources")

		render(template:"/templates/tutorials", model:[cpcaTutorials:cpcaTutorials,assessmentResources:assessmentResources,churchplanterResources:churchplanterResources,s3Url:s3Url,environment:environment])
	}
	
}
