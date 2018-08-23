<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
		<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js"></script>
    </head>
    <body>
   
    <div id="pageBody">
<g:if test="${flash.message}">
	<div class="message">
	${flash.message}
	</div>
</g:if>
<H1>${organization}</H1>
<div class="dialog">


		<g:form controller='organization'>
			<g:hiddenField name="id" value="${organization.id}"/>
			<g:actionSubmit class="choose" action="churchPlanterList" value="${message(code: 'message.orgUser.menu.label.churchPlanter')}" />
		
			<g:if test="${request.getSession(false)?.hasAdminPrivileges && (organization.id==orgUser.organization.id)}">		
			<g:actionSubmit class="choose" action="maintenance" value="${message(code: 'message.orgUser.menu.label.maintenance')}" />	
			</g:if> 	
		
			<g:if test="${!request.getSession(false)?.hasAdminPrivileges || organization.id!=orgUser.organization.id}">		
			<g:actionSubmit class="choose" action="orgUserList" value="${message(code: 'message.churchPlanter.maintenance.users')}" />	
			</g:if>
							
			<g:if test="${organization.childOrganizations}">
				<g:actionSubmit class="choose" action="subOrgList" value="${message(code: 'message.orgUser.menu.label.subOrganizations')}" />&nbsp;&nbsp;	
			</g:if>	
			<g:actionSubmit class="choose" action="tutorials" value="${message(code: 'message.organization.menu.tutorials')}" />				
		</g:form>			
</div>
    
</div>
</body>
</html>