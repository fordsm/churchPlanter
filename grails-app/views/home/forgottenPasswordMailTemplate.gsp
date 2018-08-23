<%@ page contentType="text/html"%>
<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
    </head>
    <body>
    <div id="pageBody">

		<div align="left" >		
				
				<g:message code="message.orgUser.password.recovery.mail.body.greeting" args="[modelName.orgUser]" />
				<br><br>
				<g:message code="message.orgUser.password.recovery.mail.body.part0" /><br>
				<a href="${modelName.url}">${modelName.url}</a>
				<br><br>
				<g:message code="message.orgUser.password.recovery.mail.body.part1" />
				
				<br><br>
				<p><g:message code="message.orgUser.password.recovery.mail.body.part2" /></p><br>
				<p><g:message code="message.churchplanter.registration.welcome.mail.body.partFour" /></p>
				
				<p><g:message code="message.churchplanter.registration.welcome.mail.body.partFive" /></p>				
				<br><br><br><br>																		
				<div align="left"  style="font-size: x-small; ;font-style: italic;">
				<g:message code="message.churchplanter.registration.mail.noreply"/>
				</div>
		</div>

</div>
</body>
</html>