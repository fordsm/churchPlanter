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
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.referenceReport.cpScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'purpleArrow.png',absolute:true)}" border="0"/></div></div>
			
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.referenceReport.referenceScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'reportScore.png',absolute:true)}" border="0"  height="20"/></div></div>
		</div>
		<div class="tdSep"></div>
		<table cellpadding="0" border="0" cellspacing="0" class="reportTable">
		<tr><td>&nbsp;</td><td class="${legendCss}">&nbsp;</td></tr>
		<g:each in="${categories}" var="category" status="i">
		
		<tr class="category <g:if test="${useRisk == true}"> riskBG</g:if><g:else>${ (i % 4) == 1||(i % 4) == 3 ? 'noBG' : 'colorBG'}${(i % 4) == 2 ? '2':''}</g:else>">
			<td class="cat"><a name="${category.id}_score"></a>${category.getName()}<br><a href="#${category.id}" class="subLink"><g:message code="message.churchPlanter.summaryReport.description"/></a></td>
			<td class="scoreCol"><div class="reportBar" style="margin-left:${((450*(categoryPercentageMap[category.id]/100)) - 40)}px;"><div class="score">
			<g:if test="${useRisk == true}">
			<g:set var="surveyTotal" value="${0}" />
			<g:each in="${surveyResponse.answers}" var="answer">
				<g:if test="${category.getName() == 'Risk'}">
				<g:set var="surveyTotal" value="${surveyTotal + answer.value.toInteger()}" />
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
		
		
		<tr>
			<td>&nbsp;</td>
			<td style="overflow:hidden;height:12px;">
				<div>
					<img src="${resource(dir:'images',file:'purpleArrow.png',absolute:true)}" border="0" style="position:relative;left:${cpPercentageMap[category.id]?((450*(cpPercentageMap[category.id]/100)) - 6).setScale(0, BigDecimal.ROUND_HALF_UP):0}px;"/>
				</div>
			
		<g:if test="${categoryObj.idealThreshold || categoryObj.baseThreshold}">
		
				<g:if test="${categoryObj.idealThreshold}"><div><img src="${resource(dir:'images',file:'redArrow.png',absolute:true)}" border="0" style="position:relative;top:-12px; left:${((450*(categoryObj.idealThreshold/100)) - 6).setScale(0, BigDecimal.ROUND_HALF_UP)}px;"/></div></g:if>
				<g:if test="${categoryObj.baseThreshold}"><div style="margin-top:-12px"><img src="${resource(dir:'images',file:'upArrow.png',absolute:true)}" border="0" style="margin-left:${((450*(categoryObj.baseThreshold/100)) - 6).setScale(0, BigDecimal.ROUND_HALF_UP)}px;"/></div></g:if>
			
		</g:if>
		</td>
		</tr>
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
		<tr class="category ${ (i % 4) == 1||(i % 4) == 3 ? 'noBG' : 'colorBG'}${(i % 4) == 2 ? '2':''}">
			<td class="cat vertAlignTop"><a name="${category.id}"></a>${category.getName()}<br><a href="#${category.id}_score" class="subLink"><g:message code="message.churchPlanter.summaryReport.backToScore"/></a></td>
			<td class="overView">${category.getTranslationByLocale()?.categoryOverview?:''}</td>
		</tr>
		</g:each>
		</table>
		
		
		<div class="tdSep">&nbsp;</div>
		<h1><g:message code="message.churchPlanter.reference.references.title" args="[surveyResponse.survey.getTranslationByLocale()?.name?:'']"/></h1>
		
		<table border="0" cellpadding="4" width="100%" style="border: dashed 1px #CCC;">
                                               <tbody>
                         <tr class="alignLeft incomplete headerBG dotUnder">
                          	<td align="center">Name</td>
                          	<td align="center">Title</td>
                          	<td align="center">Email</td>
                          	<td align="center">Phone</td>
                          	<td align="center">Category</td>
                          	<td align="center">Language</td>
                          </tr>
                        <g:each in="${churchPlanter.references}" var="reference" status="i" >
                        <g:if test="${reference.beIdentified}">
                        	 <g:if test="${reference.spouse == false}">		             	
			             		<tr class="category colorCol${(i % 2) == 0?'':'2'} dotUnder alignLeft">
			              			<td><font>${reference?.name}</font></td>
			              			<td><font>${reference?.title}</font></td>
			              			<td><font>${reference?.email}</font></td>
			              			<td><font>${reference?.phoneNumber}</font></td>
			              			<td><font>${reference?.category}</font> </td>
			              			<td><font>${reference?.locale?.description}</font> </td>			              	
			              	</tr>   
			               </g:if>    
				     </g:if>                        
				</g:each>                      
            
		                </tbody>

                    </table>         
		</div>
    </div>
</body>
</html>