package com.lifeway.churchplanter
import grails.converters.*
import com.lifeway.cpDomain.Organization
import com.lifeway.cpDomain.OrganizationType
import com.lifeway.cpDomain.Page
import com.lifeway.utils.OrganizationResponse
import com.lifeway.utils.PageResponse
import com.lifeway.utils.OrgResourceHelper
import com.lifeway.utils.PageHelper

class RestServicesController {

    def index = { }
	def organizationList = {
		def organizations
		if(!params.parentId && !params.type){
			organizations = Organization.findAllByParentOrganizationIsNullAndIsExcludedFromMarketing(false)
		}else if(params.parentId){
			def parentOrg = Organization.get(params.parentId.toInteger())
			organizations = Organization.findAllByParentOrganizationAndIsExcludedFromMarketing(parentOrg,false)
		}else if(params.type){
			def orgType = OrganizationType.findByName(params.type)
			organizations = Organization.findAllByOrganizationTypeAndIsExcludedFromMarketing(orgType,false)
		}
		def orgList = []
		organizations.each{org ->
			orgList.add(new OrganizationResponse(id:org.id,name:org.name,aboutUs:org.aboutUs,isDiscountEligible:org.isDiscountEligible))
		}
		render orgList as XML
    }
	def pagesList = {
		def pages = Page.findAllByPublish(true)
		def pageList = []
		pages.each{page ->
			pageList.add(new PageResponse(id:page.id,title:page.title,content:page.content,sequenceNumber:page.sequenceNumber))
		}
		render pageList as XML
	}
	def page = {
		def page = Page.get(params.id)
		
		def pageList = []
		
			pageList.add(new PageResponse(id:page.id,title:page.title,content:page.content,sequenceNumber:page.sequenceNumber))
	
		render pageList as XML
	}
	def organization = {
		if(params.id){
		def org =  Organization.get(params.id)
		def orgResourceInstance = null
		def resourceUrls = [:]
		orgResourceInstance = OrgResourceHelper.getApprovedInstance(org,orgResourceInstance)
		orgResourceInstance.resourceURLs.sort{a,b-> a.id.compareTo(b.id)}.each{url ->
			if(url.isApproved){
				resourceUrls.put(url.url,url.displayText)
				}
			 }

		render new OrganizationResponse(id:org.id,name:org.name,aboutUs:org.aboutUs,isDiscountEligible:org.isDiscountEligible, orgresource:orgResourceInstance,webPage:org.webPage,linkMap:resourceUrls)  as XML
		}else{
		render("")
		}
	}
	def renderTemplate = 
	{}
	
	def pagesHierarchy =
	{
		def pageHelper = new PageHelper();
		def pages = Page.findAllByParentPageIsNullAndPublish(true,[sort:"sequenceNumber", order:"asc"])
		def pageList = []
		pages.each{page ->
			
			def childPagesOfPage = Page.findAllByParentPageAndPublish(page,true,[sort:"sequenceNumber", order:"desc"])
			def pageResponse = new PageResponse(id:page.id,title:page.title,name:page.name,content:page.content,sequenceNumber:page.sequenceNumber)
			pageResponse = pageHelper.pagesHierarchyHelper(pageResponse,childPagesOfPage)
			pageList.add(pageResponse)
		}
		render pageList as XML
	}
	
	
}
