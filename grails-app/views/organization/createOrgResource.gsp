
 
<%@ page import="com.lifeway.cpDomain.OrgResource" %>
<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
		<script type="text/javascript" src="${resource(dir:'js',file:'ckeditor/ckeditor.js')}"></script>	
		<script type="text/javascript" src="${resource(dir:'js',file:'ckeditor/ckhelper.js')}"></script>	
		
    </head>
    <body>
    	<div id="pageBody">
            <h1><g:message code="message.churchPlanter.maintenance.resources.orgResource"/></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
       
            <g:hasErrors bean="${orgResourceInstance}">
            <div class="errors">
                <g:renderErrors bean="${orgResourceInstance}" as="list" />
            </div>
            </g:hasErrors>
          
          	<g:if test="${flash.errorMessages}">
            	<div class="errors">
            	<g:each in="${flash.errorMessages}" var="errorMessage">
            		<ul><li>${errorMessage}</li></ul>				
            	</g:each>
            	</div>
            </g:if>
            <g:form controller="organization" action="saveResource" >
                  
                    <table width="75%">
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name" width="20%">
                                    <label for="organization"><g:message code="orgResource.organization.label" default="Organization" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgResourceInstance, field: 'organization', 'errors')}">
                                  <g:hiddenField name="organization.id" value="${orgResourceInstance?.organization?.id}"/>
                                    <g:link controller="home" action="menu">${orgResourceInstance?.organization?.name}</g:link>
                                 </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name" width="20%">
                                    <label for="logoURL"><g:message code="orgResource.logoURL.label" default="Logo URL" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgResourceInstance, field: 'logoURL', 'errors')}">
                                   <g:textField name="logoURL" value="${orgResourceInstance?.logoURL}" />
                                </td>
                            </tr>
                        
                            <tr>
                                <td valign="top" class="name" width="20%">
                                    <label for="resourceText"><g:message code="orgResource.resourceText.label" default="Resource Text" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgResourceInstance, field: 'resourceText', 'errors')}">                           
                               		 <g:textArea id="resourceText" style="display:none" name="resourceText" value="${orgResourceInstance?.resourceText}"/>
                               	</td>
                            </tr>
                        
                        </tbody>
                    </table>
               
                <div class="buttons">
                    <span class="button">
                    <g:submitButton  name="create" action="saveResource" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
