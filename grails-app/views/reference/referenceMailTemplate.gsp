<%@ page contentType="text/html"%>
<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
    </head>
    <body>
    <div id="pageBody">

		<div align="left" >		
				
				<g:message code="message.chruchPlanter.reference.mail.body.greeting" args="[modelName.referenceName]" />
				<br><br>																	
				<g:message code="message.chruchPlanter.reference.mail.body.part0"  args="[modelName.churchPlanterFirstName, modelName.churchPlanterLastName,modelName.churchPlanterFirstName]" /><br>
				<br><br>
				<g:message code="message.chruchPlanter.reference.mail.body.part1" />:
				<br>
				&nbsp;*<g:message code="message.chruchPlanter.reference.mail.body.part2" />
				<br>
				&nbsp;*<g:message code="message.chruchPlanter.reference.mail.body.part3" />
				<br>
				&nbsp;*<g:message code="message.chruchPlanter.reference.mail.body.part4" args="[modelName.churchPlanterFirstName,modelName.organizationName]" />
				<br><br>
				<g:message code="message.chruchPlanter.reference.mail.body.part5" args="[modelName.churchPlanterFirstName]"/>
				<br><br>
				<p>${modelName.whyReceiving}</p>
				<br><br>			
				<p><g:message code="message.chruchPlanter.reference.mail.body.part6" /></p><br>
				<a href="${modelName.url}">${modelName.url}</a>										
				<br><br>	
				<p><g:message code="message.chruchPlanter.reference.mail.body.part7" /></p><br>
				<br><br>
				<p><g:message code="message.chruchPlanter.reference.mail.body.part8" /></p><br>
				<br><br>				
																					
				<div align="left"  style="font-size: x-small; ;font-style: italic;">
				<g:message code="message.churchplanter.registration.mail.noreply"/>
				</div>
		</div>

</div>
</body>
</html>