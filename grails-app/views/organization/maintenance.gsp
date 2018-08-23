<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
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
<h1>${organization} - <g:message code="message.churchPlanter.maintenance.heading"/></h1>
<div class="dialog">

				<div class="choose" align="center" style="text-align: center;">
				<a href="${createLink(controller:'organization', action:'orgUserList',id:params.id)}">
				 <g:message code="message.churchPlanter.maintenance.users"/>
				</a></div>
			
					<div class="choose" align="center" style="text-align: center;">									
					<a href="${createLink(controller:'organization', action:'resourceView',id:params.id)}">
					<g:message code="message.churchPlanter.maintenance.resources"/>
					</a>		
					</div>				
				</div>

</div>
</body>
</html>