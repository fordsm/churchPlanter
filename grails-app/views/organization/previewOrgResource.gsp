
<%@ page import="com.lifeway.cpDomain.OrgResource" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orgResource.label', default: 'OrgResource')}" />
        <title><g:message code="message.churchPlanter.title" /></title>
    </head>
    <body>
        <div id="pageBody">
        	
            <h1>
            <g:if test="${orgResourceInstance.isApproved}">
            			<g:message code="message.resource.previewApprovedResource" />
            </g:if>
            <g:else>
                        <g:message code="message.churchPlanter.maintenance.previewResource.heading" />
          	</g:else>
            </h1><br>
            <a style="text-decoration: underline;" href="${createLink(controller:'organization', action:'resourceView')}">
        	<g:message code="message.ResourceURL.label.list"/></a>
        	<br>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if><br>
            <g:render template="/templates/previewOrgResourceCore" bean="${orgResourceInstance}" var="orgResourceInstance"  />
            </div>
    </body>
</html>
