<html>
    <head>
        <title><g:message code="message.churchPlanter.myAccount.title"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
    </head>
    <body>
    <div id="pageBody">
<g:if test="${flash.message}">
	<div class="message">
	${flash.message}
	</div>
</g:if>
<H1>${organization}</H1>
<div class="dialog">
<h1><g:message code="message.churchPlanter.myAccount.title"/></h1>
		<g:form controller='churchPlanter'>
			<a class="choose" href="${createLink(controller:'churchPlanter', action:'myInfo')}">${message(code: 'message.churchPlanter.menu.info')}</a>
			<a class="choose" href="${createLink(controller:'churchPlanter', action:'aboutMe')}">${message(code: 'message.churchPlanter.menu.aboutMe')}</a>
			<a class="choose" href="${createLink(controller:'churchPlanter', action:'changePassword')}">${message(code: 'message.churchPlanter.menu.changePassword')}</a>
				
		</g:form>			
</div>
    
</div>
</body>
</html>