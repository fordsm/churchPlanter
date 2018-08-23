<%@ page import="com.lifeway.cpDomain.Category" %>
<html>
    <head>
    
        <title><g:message code="message.churchPlanter.summaryReport.title" args="[surveyResponse.survey.getTranslationByLocale()?.name?:'',churchPlanter.firstName + ' ' + churchPlanter.lastName]"/></title>
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
		
		
		
<g:if test="${categories != false && categories?.size() > 0}">
		<div class="dialog">
		<h1><g:message code="message.churchPlanter.summaryReport.title" args="[surveyResponse.survey.getTranslationByLocale()?.name?:'',churchPlanter.firstName + ' ' + churchPlanter.lastName]"/></h1>
		<h2><g:message code="message.churchPlanter.summaryReport.prepared" args="[churchPlanter.organization.name]" /></h2>
		${surveyResponse.survey.getTranslationByLocale()?.surveyReportOverview?:message(code:"message.churchPlanter.general.noTranslation") }
		<div class="dotUnder"></div>
		<div class="legendBlock">
			<g:if test="${showBaseLegend}">
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.summaryReport.baseScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'upArrow.png',absolute:true)}" border="0"/></div></div>
			</g:if>
			<g:if test="${showIdealLegend}">
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.summaryReport.idealScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'redArrow.png',absolute:true)}" border="0"/></div></div>
			</g:if>
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.summaryReport.yourScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'reportScore.png',absolute:true)}" border="0"  height="20"/></div></div>
		</div>
		<div class="tdSep"></div>
		<table cellpadding="0" border="0" cellspacing="0" class="reportTable">
		<tr><td>&nbsp;</td><td class="${legendCss}">&nbsp;</td></tr>
		
		<g:each in="${categories}" var="category" status="i">
		<tr class="category <g:if test="${useRisk == true}"> riskBG</g:if><g:else>${ (i % 4) == 1||(i % 4) == 3 ? 'noBG' : 'colorBG'}${(i % 4) == 2 ? '2':''} extra${ surveyResponse.survey.id}_${(i % 4)}</g:else>">
			<td class="cat"><a name="${category.id}_score"></a>${category.getName()}
			<br><a href="#${category.id}" class="subLink"><g:message code="message.churchPlanter.summaryReport.description"/></a></td>
			<td class="scoreCol"><div class="reportBar" style="margin-left:${Math.round((450*((categoryPercentageMap[category.id]?categoryPercentageMap[category.id]:1)/100)) - 40)}px;"><div class="score">
			<g:if test="${useRisk == true}">
			<g:set var="surveyTotal" value="${0}" />
			<g:each in="${surveyResponse.answers}" var="answer">
				<g:if test="${category.getName() == 'Risk'}">
				<g:set var="surveyTotal" value="${Math.round(32*((categoryPercentageMap[category.id]?categoryPercentageMap[category.id]:1)/100))}" />
				</g:if>
			</g:each>
			${surveyTotal }
			</g:if>
			<g:else>			
				<g:if test="${surveyResponse.survey.dividend == 0}">
					${categoryPercentageMap[category.id]}%
				</g:if>
				<g:else>
					${surveyResponse.survey.dividend*(categoryPercentageMap[category.id]/100)}
				</g:else>
			</g:else>
			</div></div></td>
		</tr>
		<g:set var="categoryObj" value="${category}" />
		
		<g:if test="${categoryObj.idealThreshold || categoryObj.baseThreshold}">
		<tr>
			<td>&nbsp;</td>
			<td style="overflow:hidden;height:12px;">
				<g:if test="${categoryObj.idealThreshold}"><div><img src="${resource(dir:'images',file:'redArrow.png',absolute:true)}" border="0" style="margin-left:${((450*(categoryObj.idealThreshold/100)) - 6).setScale(0, BigDecimal.ROUND_HALF_UP)}px;"/></div></g:if>
				<g:if test="${categoryObj.baseThreshold}"><div style="margin-top:-12px"><img src="${resource(dir:'images',file:'upArrow.png',absolute:true)}" border="0" style="margin-left:${((450*(categoryObj.baseThreshold/100)) - 6).setScale(0, BigDecimal.ROUND_HALF_UP)}px;"/></div></g:if>
			</td>
		</tr>
		</g:if>
		<g:if test="${(i % 17) == 16}">
		<tr class="dotUnder"><td colspan="10">&nbsp;</td></tr>
		<tr><td colspan="10" style="height:25px;"> </td></tr>
		<tr><td>&nbsp;</td><td class="legendTD">&nbsp;</td></tr>
		</g:if>
		</g:each>
		<tr class="dotUnder"><td colspan="10">&nbsp;</td></tr>
		</table>
		
		<div class="tdSep">&nbsp;</div>
		<h1><g:message code="message.churchPlanter.summaryReport.descriptionTitle" args="[surveyResponse.survey.getTranslationByLocale()?.name?:'']"/></h1>
		
		<table cellpadding="0" border="0" cellspacing="0" class="reportTable">
		<g:each in="${categories}" var="category" status="i">
		<tr class="category ${ (i % 4) == 1||(i % 4) == 3 ? 'noBG' : 'colorBG'}${(i % 4) == 2 ? '2':''}  extra${ surveyResponse.survey.id}_${(i % 4)}">
			<td class="cat vertAlignTop"><a name="${category.id}"></a>${category.getName()}<br><a href="#${category.id}_score" class="subLink"><g:message code="message.churchPlanter.summaryReport.backToScore"/></a></td>
			<td class="overView">${category.getTranslationByLocale()?.categoryOverview?:''}</td>
		</tr>
		</g:each>
		</table>
		</div>
  
    </g:if><g:else>
    
  
    <div class="tdSep"></div>
    <h1>This assessment is not set up to be scored.</h1>
    <div class="tdSep"></div>
    <div class="dotUnder">&nbsp;</div>
    <div class="tdSep"></div>
    <g:link action="menu">Go Back</g:link>
    <div class="tdSep"></div>
   
    </g:else>
      </div>
</body>
</html>