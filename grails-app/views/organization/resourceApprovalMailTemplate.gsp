<%@ page contentType="text/html"%>
<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
    </head>
    <body>
    <div id="pageBody">

		<div align="left" >		
				<g:message code="message.resource.approval.mail.body.greeting" />
				<br>
				<p><g:message code="message.resource.approval.mail.body.message.part1" args="[modelName.orgUser,modelName.orgUser.organization.name]" />
				<a href="${modelName.url}">${modelName.url}</a></p>
				<br>
				<g:message code="message.resource.approval.mail.body.message.goodbye" />
				<br><br><br><br>																		
				<div align="left"  style="font-size: x-small; ;font-style: italic;">
				<g:message code="message.churchplanter.registration.mail.noreply" />
				</div>
		</div>

</div>
</body>
</html>