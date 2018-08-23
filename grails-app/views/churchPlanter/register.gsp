<%@ page import="com.lifeway.cpDomain.Country" %>
<%@ page import="com.lifeway.cpDomain.EducationLevel" %>
<%@ page import="com.lifeway.cpDomain.Ethnicity" %>
<html>
    <head>
        <title><g:message code="message.churchPlanter.registration.title" /></title>
		<meta name="layout" content="main" />
		<g:javascript library="jquery"/>
    </head>
    <body>
    <div id="pageBody">

<div class="dialog">
  <h1><g:message code="message.churchPlanter.registration.title" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
             <g:hasErrors bean="${churchPlanterInstance}">
             	<div class="errors">
					<g:renderErrors bean="${churchPlanterInstance}" as="list" />
				</div>
            </g:hasErrors>
            <g:if test="${flash.error}">
	            <div class="errors">
	            	${flash.errorMessage}
	            </div>
            </g:if>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                         <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="organization"><g:message code="message.churchPlanter.registration.organization" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: passcode, field: 'organization', 'errors')}">
                                <g:if test="${passcode?.organization?.getOrgandChildOrganizations()?.size() > 1 }">
                                    <select name="organization.id" class="organization" id="organization.id" >
                                   <option value="${passcode.organization.id}" style="font-weight:bold;" >${passcode.organization.name}</option>
	                                   <g:each in="${passcode.organization.getAllChildOrganizations().sort{a,b-> a.name.compareTo(b.name)}}">
	                                   		<option value="${it.id}" > -- ${it.name}</option>
	                                   </g:each>
                                    </select>
                                </g:if><g:else>
                                <strong>${passcode.organization.name}</strong>
                                	<g:hiddenField name="organization.id" value="${passcode.organization.id}" />
                                </g:else></td>
                            </tr>
                         <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="message.churchPlanter.registration.Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${churchPlanterInstance?.email}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="message.churchPlanter.registration.Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'password', 'errors')}">
                                    <g:passwordField name="password" value="${params?.password}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name" class="value ${hasErrors(bean: churchPlanterInstance, field: 'password', 'errors')}">
                                    <label for="cpassword"><g:message code="message.churchPlanter.registration.cPassword" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <g:passwordField name="cpassword" value="${params?.cpassword}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstName"><g:message code="message.churchPlanter.registration.FirstName" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" value="${churchPlanterInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastName"><g:message code="message.churchPlanter.registration.LastName" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" value="${churchPlanterInstance?.lastName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="country"><g:message code="message.churchPlanter.registration.country" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'country', 'errors')}">
                                    <g:select name="country" from="${Country.list().sort{a,b-> a.name.compareTo(b.name)}}" optionKey="abbrv" value="${churchPlanterInstance?.country?:'USA'}" class="country" id="country" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state"><g:message code="message.churchPlanter.registration.State" /></label>
                                </td>
                                <td valign="top" id="state" class="value ${hasErrors(bean: churchPlanterInstance, field: 'state', 'errors')}">
                                                                  
                                <g:stateDropDown countryAbbrv="${churchPlanterInstance?.country?:'USA' }" name="state" selectedValue="${churchPlanter?.state?:''}"/>
                                
                                </td>
                            </tr>
                        
                           
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="age"><g:message code="message.churchPlanter.registration.Age" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'age', 'errors')}">
                                    <g:select name="age" from="${18..65}" value="${fieldValue(bean: churchPlanterInstance, field: 'age')}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="gender"><g:message code="message.churchPlanter.registration.Gender" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'gender', 'errors')}">
                                    <g:select name="gender" from="${['Male','Female']}" value="${churchPlanterInstance?.gender}" valueMessagePrefix="churchPlanter.gender"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ministryServiceYears"><g:message code="message.churchPlanter.registration.MinistryServiceYears" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'ministryServiceYears', 'errors')}">
                                    <g:textField name="ministryServiceYears" value="${fieldValue(bean: churchPlanterInstance, field: 'ministryServiceYears')}" />
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="educationLevel"><g:message code="message.churchPlanter.registration.EducationLevel" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'educationLevel', 'errors')}">
                                    <g:select name="educationLevel.id" from="${EducationLevel.list()}" optionKey="id" value="${churchPlanterInstance?.educationLevel?.id}" class="educationLevel" />
                                </td>
                            </tr>
                        
                            <tr class="prop" id="educationInstitutionRow">
                                <td valign="top" class="name">
                                    <label for="educationInstitution"><g:message code="message.churchPlanter.registration.EducationInstitution" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'educationInstitution', 'errors')}">
                                    <g:textField name="educationInstitution" value="${churchPlanterInstance?.educationInstitution}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ethnicity"><g:message code="message.churchPlanter.registration.Ethnicity" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'ethnicity', 'errors')}">
                                    <g:select name="ethnicity.id" from="${Ethnicity.list()}" optionKey="id" value="${churchPlanterInstance?.ethnicity?.id}"  class="ethnicity" />
                                </td>
                            </tr>
                        
                            <tr class="prop" id="otherEthnicityRow">
                                <td valign="top" class="name">
                                    <label for="otherEthnicity"><g:message code="message.churchPlanter.registration.otherEthnicity" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'otherEthnicity', 'errors')}">
                                    <g:textField name="otherEthnicity" value="${churchPlanterInstance?.otherEthnicity}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="isPlanting"><g:message code="message.churchPlanter.registration.isPlanting" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'isPlanting', 'errors')}">
                                    <g:checkBox name="isPlanting" value="${churchPlanterInstance?.isPlanting}" />
                                </td>
                            </tr>
                        	
                        </tbody>
                    </table>

                    <g:message code="message.churchPlanter.registration.participateFutureResearch" /> <g:checkBox name="participateFutureResearch" value="${churchPlanterInstance?.participateFutureResearch}"  />
                                
                     <div style="clear: both; height:30px;"></div>
                    <h1><g:message code="message.churchPlanter.registration.termsHeading" /></h1>
                    <strong><g:message code="message.churchPlanter.registration.termsNotice" /></strong>
                    
                    <g:textArea name="termsText" value="${message(code: 'message.churchPlanter.registration.terms')}" style="width:500px; heigh:250px;" disabled="disabled"/>
                    
                </div>
				<g:checkBox name="terms" value="1" checked="${params.terms}"/> <g:message code="message.churchPlanter.registration.termsAgree" />
                <div style="clear: both"></div>
                <g:hiddenField name="passcode.id" value="${passcode.id}" />
                    <g:submitButton name="create" class="choose" value="${message(code: 'message.churchPlanter.registration.submitButtonText', default: 'Register')}" style="float: none;" />
                
            </g:form>
        </div>
</div>
<g:javascript src="planterHelper.js" />
</body>
</html>