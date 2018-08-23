
<%@ page import="com.lifeway.cpDomain.OrgResource" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orgResource.label', default: 'OrgResource')}" />
        <title>Resources</title>
    </head>
    <body>
        <div id="pageBody">
        	<g:if test="${flash.message }">
        		<div class="message">
        			${flash.message}
        		</div>
        	</g:if>
        	<g:if test="${orgResourceInstance}">        	
            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if><br>
            <g:render template="/templates/previewOrgResourceCore" bean="${orgResourceInstance}" var="orgResourceInstance"  />
            </g:if>
            <g:else>
            	<br>
            	<div style="font-style: italic;"><g:message code="message.resource.churchplanter.preview.unavailable.visitAgain" /></div>
            </g:else>
            
         </div>
           
    </body>
</html>
