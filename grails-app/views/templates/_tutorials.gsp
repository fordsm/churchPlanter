<html>
<head>
<title><g:message code="message.churchPlanter.churchplanter.tutorials.title" /></title>
<meta name="layout" content="main" />
<g:javascript library="jquery" />
</head>
<body>

<a name="top"></a>
<div id="pageBody"><div class="dialog">
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<div class="dialog">
		
		<h1><g:message code="message.churchPlanter.churchplanter.tutorials.title"/></h1><div class="tdSep"></div>
		<g:message code="message.tutorials.directions"/>
		
		<div style="text-align:right; border-bottom:dotted 1px #51AB22;">&nbsp;</div>
		<a class="choose" href="#cpcaTutorials">${message(code: 'message.tutorial.menu.cpca')}</a><a class="choose" href="#assessment">${message(code: 'message.tutorial.menu.assessment')}</a><a class="choose" href="#cpResources">${message(code: 'message.tutorial.menu.cpResources')}</a>
<a name="cpcaTutorials"></a><h1><g:message code="message.tutorials.cpcatutorials" /></h1>

<g:if test="${cpcaTutorials.size() > 0 }">		

<g:each var="cpcaTutorial" in="${cpcaTutorials.sort{a,b-> a.sortOrder.compareTo(b.sortOrder)}}">
<div class="cpcaTutorial">
<g:if test="${cpcaTutorial.embedCode}">

<h2>${cpcaTutorial.label}</h2>
${cpcaTutorial.description }<br>
${cpcaTutorial.embedCode }
</g:if>
<g:else>
<h2><a href="<g:message code="${s3Url}" args="[environment,cpcaTutorial.fileName]" />" style="color:#28F;">${cpcaTutorial.label}</a></h2>
${cpcaTutorial.description }<br>
<a href="<g:message code="${s3Url}" args="[environment,cpcaTutorial.fileName]" />">Download</a>
</g:else>
</div>
</g:each>
<br><br>
</g:if>
<g:else>
${message(code: 'message.tutorial.checkSoon')}
</g:else>
<div style="text-align:right; border-bottom:dotted 1px #51AB22;"><a href="#top">top &uarr;</a></div>

<br><a name="assessment"></a>
<h1><g:message code="message.tutorials.assessmentresources" /></h1>
<g:if test="${assessmentResources.size() > 0 }">
<g:each var="assessmentResource" in="${assessmentResources.sort{a,b-> a.sortOrder.compareTo(b.sortOrder)}}">
<div class="assessmentResources">
<g:if test="${assessmentResource.embedCode}">
<h2>${assessmentResource.label}</h2>
${assessmentResource.description }<br>
${assessmentResource.embedCode }
</g:if>
<g:else>
<h2><a href="<g:message code="${s3Url}" args="[environment,assessmentResources.fileName]" />" style="color:#28F;">${assessmentResource.label}</a></h2>
${assessmentResources.description }<br>
<a href="<g:message code="${s3Url}" args="[environment,assessmentResources.fileName]" />">Download</a>
</g:else>
</div>
<br><br>
</g:each>
</g:if>
<g:else><br><br>
<g:message code="message.tutorial.checkSoon" />
</g:else>
<div style="text-align:right; border-bottom:dotted 1px #51AB22;"><a href="#top">top &uarr;</a></div><br>
<a name="cpResources"></a>
<h1><g:message code="message.tutorials.churchplantingresources" /></h1>
<g:if test="${churchplanterResources.size() > 0 }">
<g:each var="churchplanterResource" in="${churchplanterResources.sort{a,b-> a.sortOrder.compareTo(b.sortOrder)}}">
<div class="churchplanterResources">
<g:if test="${churchplanterResource.embedCode}">
<h2>${churchplanterResource.label}</h2>
${churchplanterResource.description }<br>
${churchplanterResource.embedCode }
</g:if>
<g:else>
<h2><a href="<g:message code="${s3Url}" args="[environment,churchplanterResource.fileName]" />" style="color:#28F;">${churchplanterResource.label}</a></h2>
${churchplanterResource.description }<br>
<a href="<g:message code="${s3Url}" args="[environment,churchplanterResource.fileName]" />">Download</a>
</g:else>
</div><br><br>
</g:each>
</g:if>
<g:else>
${message(code: 'message.tutorial.checkSoon')}
</g:else><br>
<div style="text-align:right; border-bottom:dotted 1px #51AB22;"><a href="#top">top &uarr;</a></div>
<div style="clear:both"></div>
</div></div>

</body></html>