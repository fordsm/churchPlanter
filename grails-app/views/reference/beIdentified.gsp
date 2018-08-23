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
		 &nbsp;<g:message code="message.churchPlanter.reference.360.wouldYouLikeToBeIdentified1"/>
		 </br></br>
		&nbsp;<g:message code="message.churchPlanter.reference.360.wouldYouLikeToBeIdentified2" args="[churchPlanterName, organizationName]" />
		 </br></br>
		*Name:${reference.name}</br>
		*Title:${reference.title}</br>
		*Email:${reference.email}</br>
		*Phone Number:${reference.phoneNumber}</br>
		*Years Known:${reference.yearsKnown}</br>
		</br></br>
		&nbsp;<g:message code="message.churchPlanter.reference.360.wouldYouLikeToBeIdentified3"/></br></br>
		
		*<g:message code="message.churchPlanter.reference.360.wouldYouLikeToBeIdentified4"/>
		*<g:message code="message.churchPlanter.reference.360.wouldYouLikeToBeIdentified5"/>
		</br></br>
		
		<g:message code="message.churchPlanter.reference.360.wouldYouLikeToBeIdentified6"/>

		</p>
			
		    <table cellspacing="0" cellpadding="0" border="0">
		   	<tr>
				<td>

				
				</br>
				</br>
				</td>
			</tr>
			<tr>
				<td>			
					<a class="link"  style="text-decoration: underline;font-size:medium" href="${createLink(controller:'reference', action:'beIdentified', params:[beIdentified:'false',churchPlanterId:churchPlanterId,organizationId:organizationId,referenceId:referenceId,localeId:localeId])}" title="Clicking “no” will delete your name from the candidate’s list."><g:message code="message.churchPlanter.reference.360.beIdentifiedNo"/></a>
					&nbsp;&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					</br>
					<a class="link"  style="text-decoration: underline;font-size:medium" href="${createLink(controller:'reference', action:'beIdentified', params:[beIdentified:'true',churchPlanterId:churchPlanterId,organizationId:organizationId,referenceId:referenceId,localeId:localeId])}" title="Clicking “yes” will take you to the assessment."><g:message code="message.churchPlanter.reference.360.beIdentifiedYes"/></a>
				</td>
			</tr>
		  </table>
						
	
	    </div>
	</div>

	

</div>

</div>
</body>
</html>