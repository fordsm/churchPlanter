<html>
<head>
<title><g:if test="${!params.caller}"><g:message code="message.churchPlanter.titles.forgottenpasswordCp" /></g:if><g:else><g:message code="message.churchPlanter.titles.forgottenpasswordOrgUser" /></g:else></title>
<meta name="layout" content="main" />
</head>
<body>
<div id="pageBody"><g:if test="${flash.message}">
	<div class="message">
	${flash.message}
	</div>
</g:if> <g:if test="${flash.errorMessage}">
	<div class="errors">
	${flash.errorMessage}
	</div>
</g:if>
<h1><g:if test="${!params.caller}">
	<g:message code="message.churchPlanter.titles.forgottenpasswordCp" />
</g:if> <g:else>
	<g:message code="message.churchPlanter.titles.forgottenpasswordOrgUser" />
</g:else></h1>

<div class="box">
<div class="boxContent">
<h4><g:message code="message.churchPlanter.titles.password.recover" /></h4>
<p class="boxText"><g:message
	code="message.churchPlanter.titles.forgottenpassword.recoveryInstructions" /></p>

<g:form controller="home" action="mailForgottenPasswordDetails">
	<table cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td><label for="email"><g:message
				code="message.orgUser.login.label.userName" />: </label></td>
			<td class="input"><g:textField name="email" /></td>
		</tr>
	</table>
	<g:hiddenField value="${params.caller}" name="caller" />
	<g:submitButton name="submit" class="boxSubmit" value="submit" />
</g:form></div>
</div>

<div style="clear: both;"></div>
<div class="bottomLink"><g:if test="${!params.caller}">
	<a href="${createLink(controller:'home', action:'forgottenPassword',params:[caller:'orgUser'])}"><g:message code="message.churchPlanter.titles.forgottenpasswordOrganizationUser"/></a>
</g:if> <g:else>
<a href="${createLink(controller:'home', action:'forgottenPassword')}"><g:message code="message.churchPlanter.titles.forgottenpasswordCpUser"/></a>
</g:else></div>
</div>



</body>
</html>