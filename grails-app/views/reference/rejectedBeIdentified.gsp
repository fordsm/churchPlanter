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
	<div>
	    <div>
	    <p>
   		 </br></br>
		 &nbsp;<g:message code="message.churchPlanter.reference.360.rejectedToBeIdentified1"/>
		 </br></br>

		</p>
			

						
	
	    </div>
	</div>

	

</div>

</div>
</body>
</html>