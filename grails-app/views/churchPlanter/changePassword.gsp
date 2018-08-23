<html>
    <head>
        <title><g:message code="message.churchPlanter.changePassword.title" /></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
    </head>
    <body>
    <div id="pageBody">

<div class="dialog">
  <h1><g:message code="message.churchPlanter.changePassword.title" /></h1>
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
            <g:form action="updatePassword" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="message.churchPlanter.registration.Email" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <strong>${churchPlanterInstance.email}</strong>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="message.churchPlanter.registration.CurrentPassword" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="password" name="currentPassword" value="" />
                                </td>
                            </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="message.churchPlanter.registration.newPassword" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: churchPlanterInstance, field: 'password', 'errors')}">
                                    <input type="password" name="password" value="" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name" class="value ${hasErrors(bean: churchPlanterInstance, field: 'password', 'errors')}">
                                    <label for="cpassword"><g:message code="message.churchPlanter.registration.cPassword" /></label>
                                </td>
                                <td valign="top" class="value">
                                    <input type="password" name="cpassword" value="" />
                                </td>
                            </tr>
                    </tbody>
                    </table>
                     
                </div>
               
                <div style="clear: both"></div>
                    <g:submitButton name="change" class="choose" value="${message(code: 'message.churchPlanter.changePassword.update', default: 'Update')}" style="float: none;" />
                
            </g:form>
        </div>
</div>
</body>
</html>