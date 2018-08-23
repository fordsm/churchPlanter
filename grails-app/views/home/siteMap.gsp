<html>
<head>
<title><g:message code="message.user.titles.siteMap"/></title>
<meta name="layout" content="main" />
</head>
<body>
    <div id="pageBody">

<div class="dialog"><g:if test="${flash.message}">
	<div class="message">
	${flash.message}
	</div>
</g:if> <g:if test="${flash.errorMessage}">
	<div class="errors">
	${flash.errorMessage}
	</div>
</g:if>
<h1>
	<g:message code="message.user.titles.siteMap" />
</h1>
</br>
<g:sitemap/>


<div style="clear: both;"></div>

</div>
</div>


</body>
</html>