package com.lifeway.utils

import com.lifeway.cpDomain.OrgUser
import com.lifeway.cpDomain.Organization
import com.lifeway.cpDomain.ChurchPlanter
import org.codehaus.groovy.grails.web.servlet.mvc.GrailsParameterMap


class SearchHelper {

	def getOrganizationSearchResults(params){
		def queryResults = null

		def c = Organization.createCriteria()
		queryResults = c.scroll(){
			if(params.name) {
				and {
					ilike("name", "%${params.name}%")
				}
			}
			if(!params?.sort){
				order("name","asc")
			}else{
				if(params?.sort == "parentOrganization"){
					parentOrganization {
						order('name', params.order)
					}
				}else if(params?.sort == "primaryContact"){
					primaryContact{
						and{
							order("firstName", params.order)
							order("lastName", params.order)
						}
					}
				}else{
					order(params.sort, params.order)
				}
			}
		}
		return getResultSubset(queryResults, params)
	}

	def getOrgUserSearchResults(params){
		def queryResults = null

		def c = ChurchPlanter.createCriteria()
		queryResults = c.scroll(){
			if(params.firstName) {
				and {
					ilike("firstName", "%${params.firstName}%")
				}
			}
			if(params.lastName) {
				and {
					ilike("lastName", "%${params.lastName}%")
				}
			}
			if(params.email) {
				and {
					ilike("email", "%${params.email}%")
				}
			}
			//			if(params.organizationId) {
			//				and {
			//					organization{
			//						idEq(params.organizationId.toLong())
			//					}
			//				}
			//			}
			//			if(params.childOrgs) {
			//				organization {
			//					'in'('id', params.childOrgs)
			//				}
			//			}
			if(!params?.sort){
				and{
					order("firstName","asc")
					order("lastName","asc")
				}
			}else{
				if(params?.sort == "organization"){
					organization{
						order("name", params.order)
					}
				}else{
					order(params.sort, params.order)
				}
			}
		}
		return getResultSubset(queryResults, params)
	}

	def getUserSearchResults(GrailsParameterMap params){
		def queryResults = null
		List childOrgList = []
		if(params.regDate1){
			params.regDate1 =  new java.util.Date(params.regDate1.toString())
		}
		if(params.regDate2){
			params.regDate2 =  new java.util.Date(params.regDate2.toString())
		}
		if(params.cpcaDate1){
			params.cpcaDate1 =  new java.util.Date(params.cpcaDate1.toString())
		}
		if(params.cpcaDate2){
			params.cpcaDate2 =  new java.util.Date(params.cpcaDate2.toString())
		}
		if(params.childOrgs && params.childOrgs.getClass().isArray()){
			params.childOrgs.each{child ->
				log.info("found...." + child)
				childOrgList.add(Long.parseLong(child))
			}

		}else if(params.childOrgs  && !params.childOrgs.getClass().isArray()){
			if(params.childOrgs.isLong()){
				childOrgList.add(Long.parseLong(params.childOrgs))
			}
		}

		def c = ChurchPlanter.createCriteria()
		queryResults = c.scroll(){
			if(params.firstName) {
				and {
					ilike("firstName", "%${params.firstName}%")
				}
			}
			if(params.lastName) {
				and {
					ilike("lastName", "%${params.lastName}%")
				}
			}
			if(params.email) {
				and {
					ilike("email", "%${params.email}%")
				}
			}
			if(params.organizationId && params.childOrgs == null) {
				and {
					log.info("using org id");
					organization{ idEq(params.organizationId) }
				}
			}

			if(params.childOrgs){

				log.info("child orgs..........." + childOrgList);

				log.info("using child org");
				and {
					organization{ 'in'('id', childOrgList) }
				}


			}

			//			if(params.organizationId && params.childOrgs == null) {
			//				and {
			//					organization{ idEq(params.organizationId) }
			//				}
			//			}else if(params.childOrgs && params.childOrgs.size()==1){
			//				and {
			//
			//					organization{ idEq(params.childOrgs) }
			//
			//				}
			//			}
			//
			//			if(childOrgList.size() > 0){
			//				and {
			//					organization{ 'in'('id', childOrgList) }
			//				}
			//			}


			if(params.regDate1 && params.regDate2) {
				and {
					between("registrationDate", params.regDate1, params.regDate2)
				}
			}
			if(params.regDate1 && !(params?.regDate2)) {
				and {
					between("registrationDate", params.regDate1, params.regDate1 + 30)
				}
			}
			if(!(params.regDate1) && params?.regDate2) {
				and {
					between("registrationDate", params.regDate2 - 30, params.regDate2)
				}
			}


			if(params.cpcaDate1 && params.cpcaDate2) {
				and {
					between("cpcaCompletionDate", params.cpcaDate1, params.cpcaDate2)
				}
			}
			if(params.cpcaDate1 && !(params?.cpcaDate2)) {
				and {
					between("cpcaCompletionDate", params.cpcaDate1, params.cpcaDate1 + 30)
				}
			}
			if(!(params.cpcaDate1) && params?.cpcaDate2) {
				and {
					between("cpcaCompletionDate", params.cpcaDate2 - 30, params.cpcaDate2)
				}
			}
			/*
			 if(params.nambCompDate1 && params.nambCompDate2) {
			 and {
			 between("nambCompletionDate", params.nambCompDate1, params.nambCompDate2)
			 }
			 }
			 if(params.nambCompDate1 && !(params?.nambCompDate2)) {
			 and {
			 between("registrationDate", params.nambCompDate1, params.nambCompDate1 + 30)
			 }
			 }
			 if(!(params.nambCompDate1) && params?.nambCompDate2) {
			 and {
			 between("registrationDate", params.nambCompDate2 - 30, params.nambCompDate2)
			 }
			 }
			 */
			if(params.isPlanting) {
				and {
					eq("isPlanting", params.isPlanting.toBoolean())
				}
			}
			if(params.passcode) {
				and {
					passcode{
						eq("code", params.passcode)
					}
				}
			}
			if(!params?.sort){
				and{
					order("firstName","asc")
					order("lastName","asc")
				}
			}else{
				if(params?.sort == "organization"){
					organization{

						order("name", params.order)
					}
				}else{
					order(params.sort, params.order)
				}
			}
		}

		return getResultSubset(queryResults, params)
	}

	def getResultSubset(queryResults, params){
		queryResults.last()
		def querySubResults = new ArrayList()
		def total = queryResults.getRowNumber()

		if(total != -1) {
			queryResults.first()
			int off=params.offset?.toInteger()?:0
			int mx =params.max?.toInteger()?:50
			int till = ((total+1)>(off+mx))?(off+mx):(total+1)
			for(int i =off;i<till;i++) {
				queryResults.setRowNumber(i)
				querySubResults.add(queryResults.get(0))
			}
		}
		[total + 1, querySubResults]
	}
}
