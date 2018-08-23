<html>
    <head>
        <title><g:message code="message.churchPlanter.titles.orguserlogin"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
    </head>
    <body>
    <div id="pageBody">
        <g:if test="${flash.message}">
			<div class="message">${flash.message}</div>
	     </g:if>
	      <g:if test="${flash.errorMessage}">
			<div class="errors">${flash.errorMessage}</div>
	     	</g:if>
	<h1><g:message code="message.churchPlanter.titles.orguserlogin"/></h1>
         <div class="box">
	    <div class="boxContent">
		<h4><g:message code="message.orgUser.login.label.login"/></h4>
		<p class="boxText"><g:message code="message.orgUser.login.label.alreadyRegistered" /></p>
		<g:form controller="authentication" action="authenticateUser">
		    <table cellspacing="0" cellpadding="0" border="0">
			<tr>
			    <td><label><g:message code="message.orgUser.login.label.userName"/>:</label></td><td class="input"><g:textField name="login"/></td>
			</tr>
			<tr>
			    <td><label><g:message code="message.orgUser.login.label.password"/>:</label></td><td class="input"><g:passwordField name="password"/></td>
			</tr>
		    </table>
		  <g:submitButton class="boxSubmit" value=" " name="submit" />
		</g:form>      
	    </div>
	 </div>
	<div style="clear:both;"></div>
    	<div class="bottomLink"><a href="${createLink(controller:'home', action:'forgottenPassword',params:[caller:'orgUser'])}"><g:message code="message.orgUser.login.label.forgottenPassword"/></a></div>
	<div class="bottomLink"><a href="${createLink(controller:'home', action:'login')}"><g:message code="message.orgUser.login.label.churchPlanterLogin"/></a></div>
	</div>
</body></html>