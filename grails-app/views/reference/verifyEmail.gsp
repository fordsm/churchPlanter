<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
    </head>
    <body>
    <div id="pageBody">

<div class="dialog">
   
    <h1><g:message code="message.churchPlanter.reference.360.surveyTitle"/></h1>
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
	<div class="box">
	    <div class="boxContent">
		<h4><g:message code="message.churchPlanter.reference.360.surveyVerify"/></h4>
		<p class="boxText"><g:message code="message.churchPlanter.reference.360.pleaseVerify"/></p>
		<g:form controller="reference" action="authenticateEmail">
		    <table cellspacing="0" cellpadding="0" border="0">
			<tr><td><label><g:message code="message.churchPlanter.reference.email"/>:</label></td>
			
				<td class="input">
					<g:hiddenField name="churchPlanterId" value="${churchPlanterId}"/>
					<g:hiddenField name="organizationId" value="${organizationId}"/>					
					<g:hiddenField name="dateToken" value="${dateToken}"/>
					<g:hiddenField name="referenceId" value="${referenceId}" />
					<g:hiddenField name="localeId" value="${localeId}" />
					<g:hiddenField name="token" value="${params.token}" />
					<g:textField name="email"/>
				</td>
			
			</tr>
		  </table>
			<g:submitButton class="boxSubmit" value=" " name="submit" />
		</g:form>
	    </div>
	</div>

	

</div>

</div>
</body>
</html>