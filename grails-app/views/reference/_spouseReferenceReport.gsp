<%@ page import="com.lifeway.cpDomain.Category" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html>
    <head>
      <title><g:message code="message.spouse.churchPlanter.report.title" args="[churchPlanter.firstName + ' ' + churchPlanter.lastName]"/></title>
		<link rel="stylesheet" href="${resource(dir:'css',file:'report.css',absolute:true)}" />
		
	</head>
    <body>
    <div id="grailsLogo" class="logo">
		<img id="mainLogo" src="${resource(dir:'images',file:'logoHeadPDF.png',absolute:true)}"	alt="Church Planter Candidate Assessment" border="0" />
	</div>
	<div id="mainBody">
	
	
	<div id="pageContent">
	<div class="bodyTop"></div>
	<div class="mainBodyBG">
	
	
    <div id="pageBody">
		<div class="dialog">
		<div style="width:650px;display:block;text-align:left">
		<h1><g:message code="message.spouse.churchPlanter.report.title" args="[churchPlanter.firstName + ' ' + churchPlanter.lastName]"/></h1>
		${surveyResponse.survey.getTranslationByLocale()?.spouseSurveyReportOverview?:"" }
		
		
		</div>
			</div>
		</div>
	</div>
	</div>
	</div>
		<div style="page-break-before: always;"></div>
		 <div id="grailsLogo" class="logo">
		<img id="mainLogo" src="${resource(dir:'images',file:'logoHeadPDF.png',absolute:true)}"	alt="Church Planter Candidate Assessment" border="0" />
	</div>
	<div id="mainBody">
	
	
	<div id="pageContent">
	<div class="bodyTop"></div>
	<div class="mainBodyBG">
		<div id="pageBody">
			<div class="dialog">
				<div style="width:650px;display:block;text-align:left">	
					<h1><g:message code="message.spouse.churchPlanter.report.title" args="[churchPlanter.firstName + ' ' + churchPlanter.lastName]"/></h1>	
		<div class="dotUnder"></div>
		<div class="legendBlock">
			<g:if test="${showBaseLegend}">
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.summaryReport.baseScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'upArrow.png',absolute:true)}" border="0"/></div></div>
			</g:if>
			<g:if test="${showIdealLegend}">
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.summaryReport.idealScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'redArrow.png',absolute:true)}" border="0"/></div></div>
			</g:if>
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.referenceReport.cpScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'purpleArrow.png',absolute:true)}" border="0"/></div></div>
			
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.spouseReferenceReport.referenceScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'reportScore.png',absolute:true)}" border="0"  height="20"/></div></div>
			
				
		</div>
		<div class="tdSep" style="clear:both; height:10px;">&nbsp;</div>
		</div>
		<table cellpadding="0" border="0" cellspacing="0" class="reportTable">
		<tr><td>&nbsp;</td><td class="${legendCss}">&nbsp;</td></tr>
		<g:set var="i" value="${0}"></g:set>
		<g:each in="${categories}" var="category" status="counter">
		<tr class="category <g:if test="${useRisk == true}"> riskBG</g:if><g:else>${ (i % 4) == 1||(i % 4) == 3 ? 'noBG' : 'colorBG'}${(i % 4) == 2 ? '2':''}</g:else>">
			<td class="cat">${category.getName()}</td>
			<td class="scoreCol"><div class="reportBar" style="margin-left:${((450*(categoryPercentageMap[category.id]/100)) - 41)}px;"><div class="score">
			
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
				<g:if test="${(surveyResponse.survey.dividend == null || surveyResponse.survey?.dividend == 0)}">
					${categoryPercentageMap[category.id]}%
				</g:if><g:else>
					${surveyResponse.survey.dividend*(categoryPercentageMap[category.id]/100)}
				</g:else>
			</g:else>
			
			</div></div></td>
		</tr>
		<g:if test="${cpPercentageMap}">
		<tr>
			<td>&nbsp;</td>
			<td style="overflow:hidden;height:12px;">
				<div style="text-align:left"><img src="${resource(dir:'images',file:'purpleArrow.png',absolute:true)}" border="0" style="margin-left:${cpPercentageMap[category.id]?((450*(cpPercentageMap[category.id]/100)) - 6).setScale(0, BigDecimal.ROUND_HALF_UP):0}px;"/></div>
				
			</td>
		</tr>
		</g:if>
		<g:set var="categoryObj" value="${category}" />
		<g:if test="${categoryObj.idealThreshold || categoryObj.baseThreshold}">
		<tr>
			<td>&nbsp;</td>
			<td style="overflow:hidden;height:12px;">
				<g:if test="${categoryObj.idealThreshold}"><div style='text-align:left;'><img src="${resource(dir:'images',file:'redArrow.png',absolute:true)}" border="0" style="position:relative;top:-12px; left:${((450*(categoryObj.idealThreshold/100)) - 6).setScale(0, BigDecimal.ROUND_HALF_UP)}px;"/></div></g:if>
				<g:if test="${categoryObj.baseThreshold}"><div style="margin-top:-12px"><img src="${resource(dir:'images',file:'upArrow.png',absolute:true)}" border="0" style="margin-left:${((450*(categoryObj.baseThreshold/100)) - 6).setScale(0, BigDecimal.ROUND_HALF_UP)}px;"/></div></g:if>
			</td>
		</tr>
		</g:if>
		
		<g:if test="${((i % 10) == 9) && categoryPercentageMap.size() > (counter + 1)}">
		<tr class="dotUnder"><td colspan="10">&nbsp;</td></tr>
		</table>
		<h2><g:message code="message.spouse.churchPlanter.summaryReport.prepared" args="[churchPlanter.organization.name]" /></h2>
		<div style="page-break-before: always;"></div>
		
		
		 </div>
					</div>
				</div>
				<div class="bodyBottom"></div>
			</div>
		</div>
		<div style="page-break-before: always;"></div>
		<g:set var="i" value="${-1}" />
		<div id="grailsLogo" class="logo">
		<img id="mainLogo" src="${resource(dir:'images',file:'logoHeadPDF.png',absolute:true)}"	alt="Church Planter Candidate Assessment" border="0" />
	</div>
		<div id="mainBody">
			<div id="pageContent">
				<div class="bodyTop"></div>
				<div class="mainBodyBG">
					<div id="pageBody">
						<div class="dialog">
		
		<div style="width:650px;display:block;text-align:left">	
			<h1><g:message code="message.spouse.churchPlanter.report.title" args="[churchPlanter.firstName + ' ' + churchPlanter.lastName]"/></h1>	
		</div>
		
	
		<div class="legendBlock">
			<g:if test="${showBaseLegend}">
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.summaryReport.baseScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'upArrow.png',absolute:true)}" border="0"/></div></div>
			</g:if>
			<g:if test="${showIdealLegend}">
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.summaryReport.idealScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'redArrow.png',absolute:true)}" border="0"/></div></div>
			</g:if>
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.referenceReport.cpScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'purpleArrow.png',absolute:true)}" border="0"/></div></div>
			
				<div class="scoreBlock"><div class="scoreBlockText"><g:message code="message.churchPlanter.spouseReferenceReport.referenceScore"/>:</div> <div class="scoreBlockColor"><img src="${resource(dir:'images',file:'reportScore.png',absolute:true)}" border="0"  height="20"/></div></div>

		</div>
		<div class="tdSep" style="clear:both;"></div>
		<table cellpadding="0" border="0" cellspacing="0" class="reportTable">
		<tr><td>&nbsp;</td><td class="${legendCss}">&nbsp;</td></tr>
		</g:if>
		<g:set var="i" value="${i + 1}" />
		</g:each>
		<tr class="dotUnder"><td colspan="10">&nbsp;</td></tr>
		</table>
		<h2><g:message code="message.spouse.churchPlanter.summaryReport.prepared" args="[churchPlanter.organization.name]" /></h2>
		
	
		
		 </div>
					</div>
				</div>
				<div class="bodyBottom"></div>
			</div>
		</div>
		<div style="page-break-before: always;"></div>
		<g:set var="i" value="${-1}" />
		<div id="grailsLogo" class="logo">
		<img id="mainLogo" src="${resource(dir:'images',file:'logoHeadPDF.png',absolute:true)}"	alt="Church Planter Candidate Assessment" border="0" />
	</div>
		<div id="mainBody">
			<div id="pageContent">
				<div class="bodyTop"></div>
				<div class="mainBodyBG">
					<div id="pageBody">
						<div class="dialog">
						
						
						 <h1><g:message code="message.access.report.references"/></h1>     
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
                        	 		<g:if test="${reference.spouse}">	
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
    			</div>
				<div class="bodyBottom"></div>
    		</div>
    	</div>
</body>
</html>