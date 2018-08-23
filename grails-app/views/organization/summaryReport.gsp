<html>
    <head>
        <title><g:message code="message.churchPlanter.summaryReport.title" args="[surveyResponse.survey.name,churchPlanter.firstName + ' ' + churchPlanter.lastName]"/></title>
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
		<div class="dialog">
		<h1><g:message code="message.churchPlanter.summaryReport.title" args="[surveyResponse.survey.name,churchPlanter.firstName + ' ' + churchPlanter.lastName]"/></h1>
		<table cellpadding="0" border="0" cellspacing="0" class="reportTable">
		<g:each in="${categoryPercentageMap}" var="category" status="i">
		<g:if test="${(i % 15) == 0}">
		<tr><td style="color:#666;text-align:right; height:0px;padding:0px; border-right:solid 1px #CCC;">0%</td><td style="padding:0px;">
		<table cellspacing="0" class="legendBar">
			<tr>
			<g:each var="k" in="${(1..<6)}">
			<td>${k*2}0%</td>
			</g:each>
			</tr>
		</table>
		</td></tr>
	</g:if>
		<tr class="category ${ (i % 4) == 1||(i % 4) == 3 ? 'noBG' : 'colorBG'}${(i % 4) == 2 ? '2':''}">
			<td class="cat">${category.key}</td>
			<td class="scoreCol"><div class="reportBar" style="width:${category.value}%;"><div class="score">${category.value}%</div></div></td>
		</tr>
		</g:each>
		</table>
		</div>
    </div>
</body>
</html>