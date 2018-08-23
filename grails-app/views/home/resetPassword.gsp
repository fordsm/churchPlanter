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
            
             <g:hasErrors bean="${userInstance}">
             
             	<div class="errors">     
					<g:renderErrors bean="${userInstance}" as="list" />
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
                                    <label for="password"><g:message code="message.user.id.login" /></label>
                                </td>
                                <td valign="top" class="name">
                                   ${userInstance?.email} <g:hiddenField name="id" value=" ${userInstance?.id}" />
                                  <g:hiddenField name="caller" value="${caller}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="password"><g:message code="message.churchPlanter.registration.Password" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">                                    	                               
                                   	<g:passwordField name="password" value="${userInstance.hasErrors()?params.password:''}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name" >
                                    <label for="cpassword"><g:message code="message.churchPlanter.registration.cPassword" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: userInstance, field: 'password', 'errors')}">                                    
                                    <g:passwordField name="cpassword" value="${userInstance.hasErrors()?params.cpassword:''}" />
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