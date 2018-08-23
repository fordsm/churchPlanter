package com.lifeway.churchplanter

import com.lifeway.cpDomain.Organization
import com.lifeway.cpDomain.Page

class MarketingController {

	def index = {
		def orgs = Organization.findAllByIsExcludedFromMarketing(false)
		[orgs:orgs]
		}
	def org = {
		Organization org = Organization.get(params.id)
		[org:org]
		}
	def page = {
		Page page = Page.get(params.id)
		[page:page]
		}
}
