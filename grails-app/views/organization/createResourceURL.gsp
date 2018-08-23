

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
            <h1><g:message code="message.ResourceURL.create.label" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${resourceURLInstance}">
            <div class="errors">
                <g:renderErrors bean="${resourceURLInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form controller="organization" action="saveResourceURL" method="post" >
              <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="url"><g:message code="message.churchPlanter.maintenance.resources.list.column.url" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: resourceURLInstance, field: 'url', 'errors')}">
                                    <g:textField name="url" value="${resourceURLInstance?.url}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="displayText"><g:message code="message.churchPlanter.maintenance.resources.list.column.displayText" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: resourceURLInstance, field: 'displayText', 'errors')}">
                                    <g:textArea name="displayText" value="${resourceURLInstance?.displayText}" maxlength="255" />                                   
                                    <g:hiddenField name="orgResource.id" value="${resourceURLInstance?.orgResource?.id?:orgResourceInstance?.id }"/>
                                </td>
                            </tr>
                        
                        
                        </tbody>
                    </table>
              
                <div class="buttons">
                    <span class="button"><g:submitButton action="saveResourceURL" name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
