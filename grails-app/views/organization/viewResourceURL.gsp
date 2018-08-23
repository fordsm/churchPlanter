
<%@ page import="com.lifeway.cpDomain.ResourceURL" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'resourceURL.label', default: 'ResourceURL')}" />
        <title><g:message code="message.churchPlanter.title.resources" />: <g:message code="message.churchPlanter.maintenance.resource.domain.name" /></title>
    </head>
    <body> <g:form controller="organization">
        <div id="pageBody">
        	<a style="text-decoration: underline;" href="${createLink(controller:'organization', action:'resourceView',id:params.id)}"><g:message code="message.ResourceURL.label.list"/></a>
        	<br><br>
            <h1><g:message code="message.churchPlanter.maintenance.resource.domain.name" /></h1>
            <g:if test="${flash.message}">
           
            <div class="message">${flash.message}</div>
            </g:if>
          
           
                  <table>
                    <tbody>
                    
                      
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="message.churchPlanter.maintenance.resources.list.column.url" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: resourceURLInstance, field: "url")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="message.churchPlanter.maintenance.resources.list.column.displayText" /></td>
                            
                            <td valign="top" class="value" style="width: 40em; word-wrap: break-word">${fieldValue(bean: resourceURLInstance, field: "displayText")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
          
            <div class="buttons">
                
                    <g:hiddenField name="id" value="${resourceURLInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="editResourceURL" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="deleteResourceURL" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                
            </div>
        </div></g:form>
    </body>
</html>
