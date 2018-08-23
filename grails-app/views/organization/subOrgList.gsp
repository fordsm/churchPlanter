<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
    </head>
    <body>
    <div id="pageBody">
		<h1>${organization.name}-<g:message code="message.suborg.listing.heading"/></h1>
		<div class="listTop"></div>
		 <table width="100%" class="list" cellspacing="5">
                    <tr><td class="listContainer">
		    <table width="100%" border="0">
			<g:if test="${organization.childOrganizations}">                    								
						<tr>
							<th><g:message code="message.orgUser.suborg.list.list.column.name"/></th>
							<th><g:message code="message.orgUser.suborg.list.list.column.tools"/></th>
						</tr> 
                    </g:if>
                     <g:if test="${organization.childOrganizations.isEmpty()}"><tr><td>
		 				<g:message code="message.churchPlanter.subOrgList.empty" args="[organization.name]"  ></g:message></td></tr>
					 </g:if>
  		<g:each var="org" sort="true" in="${organization.childOrganizations.sort{a,b-> a.name.compareTo(b.name)} }" status="counter">
			<tr class='<g:if test="${counter % 2 == 0}">mainList</g:if><g:else>subList</g:else> alignLeft' >
			    <td><a href="${createLink(controller:"home",action:'menu',id:org.id)}">${org.name}</a></td>
			    <td><g:if test="${org.childOrganizations.size()>0}"><a href="${createLink(action:'subOrgList',id:org.id)}"><g:message code="message.suborg.listing.link.suborg"/></a> | </g:if><a href="${createLink(action:'churchPlanterList',id:org.id)}"><g:message code="message.suborg.listing.link.churchPlanter"/></a> | <a href="${createLink(action:'orgUserList',id:org.id)}"><g:message code="message.churchPlanter.maintenance.users"/></a></td>
			   
			</tr>
  		</g:each>
  		
		    </table>
		   </td></tr>
		 </table>
		
		 <div class="listBottom"></div>
    </div>
    </body>
    </html>