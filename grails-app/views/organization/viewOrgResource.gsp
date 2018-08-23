
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
            <h1><g:message code="message.churchPlanter.maintenance.resource.heading" /></h1>
          
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
            <g:if test="${flash.error}">
			<div class="errors">				
				${flash.error}
			</div>
			</g:if> 
			<g:if test="${flash.errorMessages}">
            	<div class="errors">
            	<g:each in="${flash.errorMessages}" var="errorMessage">
            		<ul><li>${errorMessage}</li></ul>				
            	</g:each>
            	</div>
            </g:if>
             <g:form controller="organization">
                <table>
                    <tbody>                                       
                        <tr class="prop" >
                            <td width="40%" valign="top" class="name width15"><g:message code="orgResource.organization.label" default="Organization" /></td>                            
                            <td class="value" width="60%" valign="top" >
                            ${orgResourceInstance?.organization}</td>                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name width15"><g:message code="orgResource.logoURL.label" default="Logo URL" /></td>                            
                            <td valign="top" class="value" align="left">
                            <g:if test="${orgResourceInstance.logoURL }">
                            <img height="120" width="150" src="${fieldValue(bean: orgResourceInstance, field: "logoURL")}" />
                            </g:if>
                            <g:else>
                            <g:message code="message.resource.LogoMissing" />
                            </g:else>
                            </td>                            
                        </tr>                                          
                        
                        <tr class="prop">                          
                            <td valign="top" class="name" colspan="2"></td>                            
                        </tr>                         
                    </tbody>
                </table>
            	<br>
             	<g:link controller="organization" action="previewOrgResource" params="[approved:false]"  >
					<g:message code="message.resource.previewResource"/>
                </g:link>
                <g:if test="${approvedOrgResourceInstance}">
                <g:link controller="organization" action="previewOrgResource" params="[approved:true]">
					<br>  <g:message code="message.resource.previewApprovedResource" />
                </g:link>
                </g:if>
                <br>	<br>
            	<div class="buttons">               
                    <g:hiddenField name="id" value="${orgResourceInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="editOrgResource" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                 	<span class="button"><g:actionSubmit class="save" action="requestResourceApproval" value="${message(code: 'default.button.edit.submitForApproval', default: 'Submit for approval')}" /></span>                
            	</div>
             	</g:form>
             	<br>
             	<img  src="${resource(dir:'images/skin',file:'database_add.png')}" />
             
             <g:link controller="organization" action="createResourceURL" class="save" >${message(code: 'default.button.create.label', default: 'Create')} <g:message code="orgResource.resourceURL.label" default="Resource URL" /></g:link>                                                        
                <br>  <br>                                                     
             	<g:render template="/templates/resourceList" bean="${orgResourceInstance}" var="orgResourceInstance"  /><br>
         	 	<div style="font-style: italic;font-size: x-small;">*** <g:message code="message.resource.approval.disclaimer" /></div>
            	</div>
    </body>
</html>
