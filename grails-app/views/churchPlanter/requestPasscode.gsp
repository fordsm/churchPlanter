<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
    </head>
    <body>
    <div id="pageBody">

<div class="dialog">
<g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
             <g:hasErrors bean="${passcode}">
             	<div class="errors">
					<g:renderErrors bean="${passcode}" as="list" codec="none"/>
				</div>
            </g:hasErrors>
            <g:if test="${flash.error}">
	            <div class="errors">
	            	${flash.errorMessage}
	            </div>
            </g:if>
		<div class="bigBox">
	    <div class="boxContent">
		<h4><g:message code="message.orgUser.login.label.churchPlanterRegistration"/></h4>
		<p class="boxText"><g:message code="message.orgUser.login.label.enterPasscodeMsg"/></p>
		<g:form controller="churchPlanter" action="register">
		    <table cellspacing="0" cellpadding="0" border="0">
			<tr><td><label><g:message code="message.orgUser.login.label.enterPasscode"/>:</label></td><td  class="input"><g:textField name="passcode"/></td></tr>
		    </table>
		<g:submitButton class="boxSubmit" value=" "  name="submit" />
		</g:form>
	    </div>
	</div>
	<div style="clear:both;"></div>
	<a href="${createLink(controller:'home', action:'forgottenPassword')}"><g:message code="message.orgUser.login.label.forgottenPassword"/></a>
</div>

</div>
</body>
</html>