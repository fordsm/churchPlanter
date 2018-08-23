<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
	
    </head>
    <body>
    <div id="pageBody">

<div class="dialog">
   
    <h1><g:message code="message.churchPlanter.registerPasscode"/></h1>
    <div class="tdSep"></div>
   	  <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
             <g:hasErrors bean="${userInstance}">
             
             	<div class="errors">     
					<g:renderErrors bean="${userInstance}" as="list" />
				</div>
            </g:hasErrors>
            <g:if test="${flash.errorMessage}">
	            <div class="errors">
	            	<ul><li>${flash.errorMessage}</li></ul>
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
	<div class="bottomLink"><a href="${createLink(controller:'home', action:'forgottenPassword')}"><g:message code="message.orgUser.login.label.forgottenPassword"/></a></div>
	<div class="bottomLink"><a href="${createLink(controller:'home', action:'login',params:[caller:'orgUser'])}"><g:message code="message.orgUser.login.label.userLogin"/></a></div>
	<div class="bottomLink"><a href="http://churchplanter.lifeway.com/page/organizationList/Sponsor">Purchase Passcode</a></div>
</div>

</div>
</body>
</html>