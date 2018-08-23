

<%@ page import="com.lifeway.cpDomain.OrgResource" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orgResource.label', default: 'OrgResource')}" />
        <script type="text/javascript" src="${resource(dir:'js',file:'ckeditor/ckeditor.js')}"></script>
		<script type="text/javascript" src="${resource(dir:'js',file:'ckeditor/ckhelper.js')}"></script>	
	
<title><g:message code="message.churchPlanter.title" /></title>
    </head>
    <body>
        <div id="pageBody">
            <h1><g:message code="message.churchPlanter.maintenance.resource.Edit" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${orgResourceInstance}">
            <div class="errors">
                <g:renderErrors bean="${orgResourceInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${orgResourceInstance?.id}" />
                <g:hiddenField name="version" value="${orgResourceInstance?.version}" />
              
                    <table width="75%">
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name" width="20%" >
                                  <label for="organization"><g:message code="message.churchPlanter.maintenance.resource.organization"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgResourceInstance, field: 'organization', 'errors')}">
                                    <g:hiddenField name="organization.id" value="${orgResourceInstance?.organization?.id}"/>
                                    ${orgResourceInstance?.organization?.name}
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name" width="20%" >
                                  <label for="logoURL"><g:message code="message.churchPlanter.maintenance.resource.logoURL" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgResourceInstance, field: 'logoURL', 'errors')}">
                                    <g:textField name="logoURL" value="${orgResourceInstance?.logoURL}" />
                                </td>
                            </tr>
                        
                            <tr>
                                <td valign="top" class="name" width="20%" >
                                  <label for="resourceText"><g:message code="message.churchPlanter.maintenance.resource.resourceText" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgResourceInstance, field: 'resourceText', 'errors')}">                                  
                                   		 <g:textArea id="resourceText" style="display:none" name="resourceText" value="${orgResourceInstance?.resourceText}"/>
                                </td>
                            </tr>
                        
                        
                        </tbody>
                    </table>
              
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="updateOrgResource" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="deleteOrgResource" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
           </div>
    </body>
</html>
