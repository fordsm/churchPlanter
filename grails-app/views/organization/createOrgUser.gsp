<%@ page import="com.lifeway.cpDomain.Role" %>
<%@ page import="com.lifeway.cpDomain.PositionScope" %>
<%@ page import="com.lifeway.cpDomain.OrgUser" %>
<%@ page import="com.lifeway.cpDomain.Country" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orgUser.label', default: 'OrgUser')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <g:javascript library="jquery"/>
    </head>
    <body>
        <div id="pageBody">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
          	
            <g:hasErrors bean="${orgUserInstance}">
            <div class="errors">
                <g:renderErrors bean="${orgUserInstance}" as="list" />                      	
            </div>
            </g:hasErrors>
            <g:form action="saveOrgUser" method="post">                
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="organization"><g:message code="message.user.id.organization" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'organization', 'errors')}">
                                    <g:hiddenField name="organization.id" value="${orgUserInstance?.organization?.id?:organization.id}"/>
                                    <g:link controller="home" action="menu" >${orgUserInstance?.organization?.name?:organization.name}</g:link>
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="firstName"><g:message code="message.user.id.firstName" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${orgUserInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="lastName"><g:message code="message.user.id.lastName"  /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${orgUserInstance?.lastName}" />
                                </td>
                            </tr>
                        	
                        	<tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="address.line1"><g:message code="message.user.id.addressLine1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'address.line1', 'errors')}">
                                	<g:textField name="address.line1" value="${orgUserInstance?.address?.line1}" />
                                </td>
                            </tr>
                        	<tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="address.line2"><g:message code="message.user.id.addressLine2" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'address.line2', 'errors')}">
                                	<g:textField name="address.line2" value="${orgUserInstance?.address?.line2}" />
                                </td>
                            </tr>
                        	<tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="address.city"><g:message code="message.user.id.city"  /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'address.city', 'errors')}">
                                	<g:textField name="address.city" value="${orgUserInstance?.address?.city}" />
                                </td>
                            </tr>
                            
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="country"><g:message code="message.orgUser.country" default="Country"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserPlanterInstance, field: 'address.country', 'errors')}">
                                    <g:select name="address.country" from="${Country.list().sort{a,b-> a.name.compareTo(b.name)}}" optionKey="abbrv" value="${orgUserInstance?.address?.country?:'USA'}" class="country" id="country" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state"><g:message code="message.user.State" default="State"/></label>
                                </td>
                                <td valign="top" id="state" class="value ${hasErrors(bean: orgUserPlanterInstance, field: 'address.state', 'errors')}">
                                                                  
                                <g:stateDropDown countryAbbrv="${orgUserInstance?.address?.country?:'USA' }" name="address.state" selectedValue="${orgUserInstance?.address?.state?:''}"/>
                                
                                </td>
                            </tr>
                   
                        	<tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="address.zipCode"><g:message code="message.user.id.zipcode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'address.zipCode', 'errors')}">
                                	<g:textField name="address.zipCode" value="${orgUserInstance?.address?.zipCode}" />
                                </td>
                            </tr>
                        	
                        	<tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="email"><g:message code="message.user.id.email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${orgUserInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="phone"><g:message code="message.user.id.phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'phone', 'errors')}">
                                    <g:textField name="phone" value="${orgUserInstance?.phone}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name width15" >
                                    <label for="password"><g:message code="message.user.id.password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'password', 'errors')}">
                                    <g:passwordField name="password" value="${orgUserInstance?.password}" />
                                </td>
                            </tr>
                     	   <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="password"><g:message code="message.user.id.confirm.password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'password', 'errors')}">
                                    <g:passwordField name="confirmpassword" value="${params?.confirmpassword}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="role"><g:message code="message.user.id.role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${Role.list()}" optionKey="id" value="${orgUserInstance?.role?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="positionScope"><g:message code="message.user.id.positionScope"  /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'positionScope', 'errors')}">
                                    <g:select name="positionScope.id" from="${PositionScope.list()}" optionKey="id" value="${orgUserInstance?.positionScope?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="hasAdminPrivileges">
                                    <g:message code="message.user.id.adminPrivileges" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'hasAdminPrivileges', 'errors')}">
                                    <g:checkBox name="hasAdminPrivileges" value="${orgUserInstance?.hasAdminPrivileges}" />
                                </td>
                            </tr>
                        
                        
                        </tbody>
                    </table>
             
                <div class="buttons">
                    <span class="button">
                    <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                    </span>
                </div>
            </g:form>
        </div>

    </body>
   
</html>
