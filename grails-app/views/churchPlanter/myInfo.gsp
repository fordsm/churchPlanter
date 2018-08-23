<%@ page import="com.lifeway.cpDomain.EducationLevel" %>
<%@ page import="com.lifeway.cpDomain.Ethnicity" %>
<%@ page import="com.lifeway.cpDomain.Country" %>
<html>
    <head>
        <title><g:message code="message.churchPlanter.myInfo.title" /></title>
		<meta name="layout" content="main" />
		<g:javascript library="jquery"/>
    </head>
    <body>
    <div id="pageBody">

<div class="dialog">
  <h1><g:message code="message.churchPlanter.myInfo.title" /></h1>
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
            <g:form action="update" method="post" >
                <div class="dialog">
               
                    <table>
                        <tbody>
                        
                          <tr class="prop dotUnder">
                                <td valign="top" class="name">
                                    <label for="organization"><g:message code="message.churchPlanter.id.organization" /></label>
                                </td>
                                <td valign="top" class="value">
                                  <strong>${churchPlanterInstance.organization}</strong>
                                </td>
                            </tr>
                            <tr><td colspan="3" class="tdSep"> </td></tr>
                          <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state"><g:message code="message.churchPlanter.registration.FirstName" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'firstName', 'errors')}">
                                   <g:textField name="firstName" value="${churchPlanterInstance?.firstName}" />
                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state"><g:message code="message.churchPlanter.registration.LastName" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'lastName', ' errors')}">
                                     <g:textField name="lastName" value="${churchPlanterInstance?.lastName}" />
                                </td>
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
                                    <label for="email"><g:message code="message.churchPlanter.registration.Age" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'age', 'errors')}">
                                    <g:textField name="age" value="${churchPlanterInstance?.age}" />
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
                                                                  
                                <g:stateDropDown countryAbbrv="${churchPlanterInstance?.country?:'USA' }" name="state" selectedValue="${churchPlanterInstance?.state?:''}"/>
                                
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
                   <g:message code="message.churchPlanter.registration.participateFutureResearch" /> <g:checkBox name="participateFutureResearch" value="true" checked="${churchPlanterInstance.participateFutureResearch}"/>
                </div>
           <g:hiddenField name="return" value="myInfo" />
                    <g:submitButton name="create" class="choose" value="${message(code: 'message.churchPlanter.myInfo.update', default: 'Update')}" style="float: none;" />
                
            </g:form>
        </div>
</div>
<g:javascript src="planterHelper.js" />
</body>
</html>