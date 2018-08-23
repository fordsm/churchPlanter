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
					<g:renderErrors bean="${passcode}" as="list" />
				</div>
            </g:hasErrors>
            <g:if test="${flash.error}">
	            <div class="errors">
	            	${flash.errorMessage}
	            </div>
            </g:if>
		<div class="bigBox">
	    <div class="boxContent">
		<h4><g:message code="message.orgUser.login.label.login"/></h4>
		<p class="boxText"><g:message code="message.orgUser.login.label.alreadyRegistered"/></p>
		<g:form controller="authentication" action="authenticateCP">
		    <table cellspacing="0" cellpadding="0" border="0">
			<tr><td><label><g:message code="message.orgUser.login.label.userName"/>:</label></td><td class="input"><g:textField name="cplogin"/></td></tr>
			<tr><td><label><g:message code="message.orgUser.login.label.password"/>:</label></td><td  class="input"><g:passwordField name="password"/></td></tr>
		    </table>
			<g:submitButton class="boxSubmit" value=" " name="submit" />
		</g:form>
	    </div>
	</div>
	<div style="clear:both;"></div>
	<a href="${createLink(controller:'home', action:'forgottenPassword')}"><g:message code="message.orgUser.login.label.forgottenPassword"/></a>
</div>

</div>
</body>
</html>