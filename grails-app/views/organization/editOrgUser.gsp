<%@ page import="com.lifeway.cpDomain.Country" %>
<%@ page import="com.lifeway.cpDomain.Role" %>
<%@ page import="com.lifeway.cpDomain.PositionScope" %>
<%@ page import="com.lifeway.cpDomain.OrgUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orgUser.label', default: 'OrgUser')}" />
        <title><g:message code="message.churchPlanter.title"/></title>
        <g:javascript library="jquery"/>
    </head>
    <body>
        <div id="pageBody">
            <h1><g:message code="message.user.edit.label"/></h1>
            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
            <g:hasErrors bean="${orgUserInstance}">
            <div class="errors">
                <g:renderErrors bean="${orgUserInstance}" as="list" />        	         
            </div>
            </g:hasErrors>
            
            
            <g:form method="post"  controller="organization" >
                <g:hiddenField name="id" value="${orgUserInstance?.id}" />
                <g:hiddenField name="version" value="${orgUserInstance?.version}" />
              
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="organization"><g:message code="message.user.id.organization" /></label>
                                </td>
                                <td valign="top" class="value">
                                		<g:hiddenField name="organization.id" value="${orgUserInstance?.organization?.id}" />
                                		<g:link controller="home" action="menu">${orgUserInstance?.organization?.name}</g:link>
                                </td>
                                
                            </tr>
                                                    
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="firstName"><g:message code="message.user.id.firstName" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${orgUserInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lastName"><g:message code="message.user.id.lastName" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${orgUserInstance?.lastName}" />
                                </td>
                            </tr>
                        	
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="address.line1"><g:message code="message.user.id.addressLine1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'address.line1', 'errors')}">
                                	<g:textField name="address.line1" value="${orgUserInstance?.address?.line1}" />
                                </td>
                            </tr>
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="address.line2"><g:message code="message.user.id.addressLine2" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'address.line2', 'errors')}">
                                	<g:textField name="address.line2" value="${orgUserInstance?.address?.line2}" />
                                </td>
                            </tr>
                        	<tr class="prop">
                                <td valign="top" class="name">
                                    <label for="address.city"><g:message code="message.user.id.city" /></label>
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
                                <td valign="top" class="name">
                                    <label for="address.zipCode"><g:message code="message.user.id.zipcode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'address.zipCode', 'errors')}">
                                	<g:textField name="address.zipCode" value="${orgUserInstance?.address?.zipCode}" />
                                </td>
                            </tr>
                        	
                        	<tr class="prop">
                                <td valign="top" class="name">
                                  <label for="email"><g:message code="message.user.id.email"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${orgUserInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="phone"><g:message code="message.user.id.phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'phone', 'errors')}">
                                    <g:textField name="phone" value="${orgUserInstance?.phone}" />
                                </td>
                            </tr>
                        	
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="role"><g:message code="message.user.id.role" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'role', 'errors')}">
                                    <g:select name="role.id" from="${Role.list()}" optionKey="id" value="${orgUserInstance?.role?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="positionScope"><g:message code="message.user.id.positionScope" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'positionScope', 'errors')}">
                                    <g:select name="positionScope.id" from="${PositionScope.list()}" optionKey="id" value="${orgUserInstance?.positionScope?.id}"  />
                                </td>
                            </tr>
                        	<g:if test="${(request.getSession(false)?.UserId != orgUserInstance.id)}">
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="hasAdminPrivileges"><g:message code="message.user.id.adminPrivileges"/></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: orgUserInstance, field: 'hasAdminPrivileges', 'errors')}">
                                    <g:checkBox name="hasAdminPrivileges" value="${orgUserInstance?.hasAdminPrivileges}" />
                                </td>
                            </tr>
                        	</g:if>
                        </tbody>
                    </table>
                
                
                 <div style="display:block; height:100px;">
                 <g:actionSubmit class="choose" action="updateOrgUser" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    <g:if test="${(request.getSession(false)?.UserId != orgUserInstance.id)}">
                   <g:actionSubmit class="choose" action="deleteOrgUser" value="${message(code: 'default.button.delete.label', default: 'Delete')}" />
                   	</g:if>
                  </div>  
            </g:form>
            
            <div style="break:both;"></div>
        </div>
       
    </body>
</html>
