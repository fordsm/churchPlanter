

<%@ page import="com.lifeway.cpDomain.ResourceURL" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'resourceURL.label', default: 'ResourceURL')}" />
        <title><g:message code="message.churchPlanter.title" /></title>
    </head>
    <body>
        <div id="pageBody">
            <h1><g:message code="message.ResourceURL.edit.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${resourceURLInstance}">
            <div class="errors">
                <g:renderErrors bean="${resourceURLInstance}" as="list" />
            </div>
            </g:hasErrors>
             <g:form method="post" controller="organization">
                <g:hiddenField name="id" value="${resourceURLInstance?.id}" />
                <g:hiddenField name="version" value="${resourceURLInstance?.version}" />
              
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="url"><g:message code="message.churchPlanter.maintenance.resources.list.column.url" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: resourceURLInstance, field: 'url', 'errors')}">
                                    <g:textField name="url" value="${resourceURLInstance?.url}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="displayText"><g:message code="message.churchPlanter.maintenance.resources.list.column.displayText" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: resourceURLInstance, field: 'displayText', 'errors')}">
                                    <g:textArea name="displayText" value="${resourceURLInstance?.displayText}" />
                                    <g:hiddenField name="orgResource.id" value="${resourceURLInstance?.orgResource?.id }"/>
                                </td>
                            </tr>
                        
                        
                        </tbody>
                    </table>
                
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="updateResourceURL" value="${message(code: 'default.button.update.label')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="deleteResourceURL" value="${message(code: 'default.button.delete.label')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
