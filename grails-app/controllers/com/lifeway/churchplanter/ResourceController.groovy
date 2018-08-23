package com.lifeway.churchplanter

import com.lifeway.cpDomain.OrgResource
import com.lifeway.cpDomain.OrgUser
import com.lifeway.cpDomain.Organization
import com.lifeway.cpDomain.ResourceURL


class ResourceController {

	def list={
		OrgUser orgUser = OrgUser.findById(session.UserId)
		Organization org = orgUser.organization
		[orguser:orgUser,organization:org,orgResources:org.orgResources]
	}

	def view={
		ResourceURL resourceURL = ResourceURL.findById(params.id)
		[resourceURL:resourceURL]
	}
}
