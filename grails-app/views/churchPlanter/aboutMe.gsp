<html>
<head>
<title><g:message code="message.churchPlanter.aboutme.title" /></title>
<meta name="layout" content="main" />
<g:javascript library="jquery" />
</head>
<body>
	<div id="pageBody">
		<div class="dialog">
			<h1>
				<g:message code="message.churchPlanter.aboutme.title" />
			</h1>
			<g:if test="${flash.message}">
				<div class="message">
					${flash.message}
				</div>
			</g:if>

			<g:hasErrors bean="${churchPlanterInstance}">
				<div class="errors">
					<g:renderErrors bean="${churchPlanterInstance}" as="list" />
				</div>
			</g:hasErrors>
			<g:if test="${flash.error}">
				<div class="errors">
					${flash.errorMessage}
				</div>
			</g:if>

			<g:form action="update" method="post">
			<h2>
					<g:message code="message.churchPlanter.aboutme.testimony" />
				</h2>
				<div class="note">
					<g:message code="message.churchPlanter.aboutme.testimonyNote" />
				</div>
				
				<g:textArea name="testimony" value="${churchPlanter?.testimony}" class="aboutMe"/>
				
				<h2>
					<g:message code="message.churchPlanter.aboutme.calling" />
				</h2>
				<div class="note">
					<g:message code="message.churchPlanter.aboutme.callingNote" />
				</div>
				<g:textArea name="calling" value="${churchPlanter?.calling}" class="aboutMe"/>
				
				<h2>
					<g:message code="message.churchPlanter.aboutme.doctrine" />
				</h2>
				<div class="note">
					<g:message code="message.churchPlanter.aboutme.doctrineNote" />
				</div>
				
				<g:textArea name="doctrine" value="${churchPlanter?.doctrine}" class="aboutMe"/>
				<g:hiddenField name="return" value="aboutMe" />
				<g:submitButton name="change" class="choose"
					value="${message(code: 'message.churchPlanter.changePassword.update', default: 'Update')}"
					style="float: none;" />
			</g:form>
		</div>
	</div>
</body>
</html>