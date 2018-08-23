<html>
    <head>
        <title><g:message code="message.churchPlanter.menu.item.menu"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="jquery"/>
    </head>
    <body>
    <div id="pageBody">
	<g:if test="${flash.message}">
		<div class="message">
		${flash.message}
		</div>
	</g:if>
	
<div class="dialog">
	<h1><g:message code="message.churchPlanter.menu.item.menu"/></h1>
	<table class="mainTable" cellspacing="0" cellpadding="0" >
		<tr class="dotUnder alignLeft incomplete headerBG">
			<th colspan="10">
				<h2><g:message code="message.churchPlanter.menu.incompleteSurveys"/></h2>
			</th>
		</tr>
		<g:set var="counter" value="${0}"/>	
		<g:each in="${incompleteSurveys.sort{a,b -> a.sequenceNumber.compareTo((b.sequenceNumber))}}" status="i" var="survey">	
		<g:if test="${!completeSurveyResponses[survey.id]}">
		<tr class="dotUnder alignLeft">
			<td style="width:40px;"><a id="show${survey.id}in" class="showHide"><img src="${resource(dir:'images',file:'openUp.png')}" id="openUp${survey.id}in" border="0"><img src="${resource(dir:'images',file:'openDown.png')}" id="openDown${survey.id}in" border="0" style="display:none"></a></td>
			<td><h3 style="text-transform: capitalize">${survey.getTranslationByLocale(locale)?.name?:message(code:"message.churchPlanter.general.noTranslation")}</h3></td><td style="text-align:right;"><a class="choose" href="${createLink(controller:'churchPlanter', action:'take', id:survey.id)}" style="float:right;">${message(code:"message.churchplanter.menu.start.here") }</a></td>
		</tr>
		<tr class="menuOverview" id="overview${survey.id}in">
		  <td colspan="10">
			<div class="listTop"></div>
			<table width="100%" class="list" cellspacing="5">
			<tr>
				<td class="listContainer pad10LR"><div class="floatUp">
				<h2><g:message code="message.churchPlanter.menu.survey.overview"/></h2>
				${survey.getTranslationByLocale(locale)?.overview?:message(code:"message.churchPlanter.general.noTranslation")}
				</div>
				</td>
			</tr>
			</table>
			<div class="listBottom"></div>
		  </td>
		</tr>
		<g:set var="counter" value="${counter + 1}" />
		</g:if>
		</g:each>
		<g:if test="${incompleteSurveys.size() == 0}">
		<tr class="dotUnder alignLeft">
			<td class="noResults alignCenter"><g:message code="message.churchPlanter.menu.noIncompleteSurveys"/></td>
		</tr>
		</g:if>
	</table>

	<div style="clear:both; height:25px;"></div>
	
	<table class="mainTable" cellspacing="0" cellpadding="0">
		<tr class="dotUnder alignLeft headerBG">
			<th colspan="10">
				<h2><g:message code="message.churchPlanter.menu.completeSurveys"/></h2>
			</th>
		</tr>
		<g:set var="counter" value="${0}"/>
		<g:each in="${completeSurveys.sort{a,b -> a.sequenceNumber.compareTo((b.sequenceNumber))}}" status="i" var="survey">
		<g:if test="${completeSurveyResponses[survey.id]?.completionDate && !survey.isForReferences}">
		<g:if test="${survey.totalCpResponsesAllowed>1 && churchPlanter.surveyResponses.size()>1}">
		<tr class="alignLeft">
			<td style="width:40px; padding-top:10px;" valign="top">
				<a id="show${survey.id}c" class="showHide"><img src="${resource(dir:'images',file:'openUp.png')}" id="openUp${survey.id}c" border="0"><img src="${resource(dir:'images',file:'openDown.png')}" id="openDown${survey.id}c" border="0" style="display:none"></a>
			</td>
			<td style="width:40px; padding-top:10px;" valign="top"><h3 style="text-transform: capitalize">${survey.getTranslationByLocale(locale)?.name?:message(code:"message.churchPlanter.general.noTranslation")}</h3>
				<g:if test="${survey.totalCpResponsesAllowed>1 && (currentDate-completeSurveyResponses[survey.id]?.completionDate)<survey.responseInterval}"><strong>${survey.responseInterval-(currentDate-completeSurveyResponses[survey.id]?.completionDate)}</strong> days until you can re-take this survey.</g:if>
				<g:if test="${survey.totalCpResponsesAllowed>1 && (currentDate-completeSurveyResponses[survey.id]?.completionDate)>=survey.responseInterval && responseSurveyMap[survey.id].size()<survey.totalCpResponsesAllowed}">
					This survey is eligible for you to re-take.
				</g:if>	
			
			
			</td>
			
			
			<td style="text-align:right;width:40px; padding-top:10px;" valign="top">
				<g:if test="${survey.totalCpResponsesAllowed>1 && (currentDate-completeSurveyResponses[survey.id]?.completionDate)>=survey.responseInterval && responseSurveyMap[survey.id].size()<survey.totalCpResponsesAllowed}">
			
				
					<a class="choose" style="float:right; height:35px;margin:0px 5px;" href="${createLink(controller:'churchPlanter', action:'take', id:survey.id)}">${message(code:"message.churchplanter.menu.retake") }</a>
					
			
		</g:if>	
		</td>	
		</tr>
		<tr class="dotUnder">
		<td style="width:40px; padding-top:10px;">
			</td>
		<td colspan="3" style="padding-top:10px;">
		<g:if test="${survey.totalCpResponsesAllowed>1 && churchPlanter.surveyResponses.size()>1}">
					<strong>Past Responses:</strong><br/><select id="cpResonse${survey.id}" name="cpResponse${survey.id}" onChange='$("a#report${survey.id }").attr("href", "${createLink(controller:'churchPlanter', action:'summaryReport', id:survey.id)}?surveyResponse=" + $(this).val());$("a#pdf${survey.id }").attr("href", "${createLink(controller:'churchPlanter', action:'summaryReport', id:survey.id)}?pdf=true&surveyResponse=" + $(this).val());'>
						<g:each in="${responseSurveyMap[survey.id].sort{a,b->(b.completionDate?b.completionDate:currentDate).compareTo((a.completionDate?a.completionDate:currentDate))}}" var="cpResponse">
							<g:if test="${cpResponse.survey.id == survey.id && cpResponse.completionDate}">
								<option value="${cpResponse.id}">${cpResponse.completionDate.format('MM/dd/yy hh:mm aaa')}</option>
							</g:if>
						</g:each>
					</select>
					
				</g:if>
		<a class="report" id="report${survey.id}" href="${createLink(controller:'churchPlanter', action:'summaryReport', id:survey.id,params:[surveyResponse:completeSurveyResponses[survey.id]?.id])}">&nbsp;</a>
		<a class="pdfLink" id="pdf${survey.id}" href="${createLink(controller:'churchPlanter', action:'summaryReport', id:survey.id, params:[pdf:true,surveyResponse:completeSurveyResponses[survey.id]?.id])}">&nbsp;</a>
				
				
			
				
			</td>	
		</tr>
		</g:if><g:else>
		<tr class=" dotUnder alignLeft">
			<td style="width:40px; padding-top:10px;">
				<a id="show${survey.id}c" class="showHide"><img src="${resource(dir:'images',file:'openUp.png')}" id="openUp${survey.id}c" border="0"><img src="${resource(dir:'images',file:'openDown.png')}" id="openDown${survey.id}c" border="0" style="display:none"></a>
			</td>
			<td style="padding-top:10px;" ><h3 style="text-transform: capitalize">${survey.getTranslationByLocale(locale)?.name?:message(code:"message.churchPlanter.general.noTranslation")}</h3>
				<g:if test="${survey.totalCpResponsesAllowed>1 && (currentDate-completeSurveyResponses[survey.id]?.completionDate)<survey.responseInterval}"><strong>${survey.responseInterval-(currentDate-completeSurveyResponses[survey.id]?.completionDate)}</strong> days until you can re-take this survey.</g:if>
				<g:if test="${survey.totalCpResponsesAllowed>1 && (currentDate-completeSurveyResponses[survey.id]?.completionDate)>=survey.responseInterval && responseSurveyMap[survey.id].size()<survey.totalCpResponsesAllowed}">
					This survey is eligible for you to re-take.
				</g:if>	
			
			
			</td>
			
			
			<td style="text-align:right;width:40px; padding-top:10px;"  colspan="10">
			<a class="report" id="report${survey.id}" href="${createLink(controller:'churchPlanter', action:'summaryReport', id:survey.id,params:[surveyResponse:completeSurveyResponses[survey.id]?.id])}">&nbsp;</a>
		<a class="pdfLink" id="pdf${survey.id}" href="${createLink(controller:'churchPlanter', action:'summaryReport', id:survey.id, params:[pdf:true,surveyResponse:completeSurveyResponses[survey.id]?.id])}">&nbsp;</a>
			
				<g:if test="${survey.totalCpResponsesAllowed>1 && (currentDate-completeSurveyResponses[survey.id]?.completionDate)>=survey.responseInterval && responseSurveyMap[survey.id].size()<survey.totalCpResponsesAllowed}">
			
				
					<a class="choose" style="float:right; height:35px;margin:0px 5px;" href="${createLink(controller:'churchPlanter', action:'take', id:survey.id)}">${message(code:"message.churchplanter.menu.retake") }</a>
					
			
		</g:if>	
		</td>	
		</tr>
		</g:else>
		<tr class="menuOverview" id="overview${survey.id}c">
		  <td colspan="3">
			<div class="listTop"></div>
			<table width="100%" class="list" cellspacing="5">
				<tr>
					<td class="listContainer pad10LR"><div class="floatUp">
					<h2><g:message code="message.churchPlanter.menu.survey.overview"/></h2>
					${survey.getTranslationByLocale(locale)?.overview?:message(code:"message.churchPlanter.general.noTranslation")}
					</div>
					</td>
				</tr>
			</table>
			<div class="listBottom"></div>
		  </td>
		</tr>
		<g:set var="counter" value="${counter + 1}" />
		</g:if>
		</g:each>

	<g:if test="${counter == 0}">
	<tr class="dotUnder alignLeft ">
		<td class="noResults alignCenter" colspan="2"><g:message code="message.churchPlanter.menu.noCompleteSurveys"/></td>
	</tr>
	</g:if>
	
	<tr><td><br><br></td></tr>
	
	<!--Reference will not point to the "take" action. We are not taking the survey for this flow. We are sending CP's to a page to allow them to 
	register references, and for the references to later access the "take" action for taking the reference survey-->
		<table class="mainTable" cellspacing="0" cellpadding="0" >
		<tr class="dotUnder alignLeft complete headerBG">
			<th colspan="10">
				<h2><g:message code="message.churchPlanter.reference.360.title"/></h2>
			</th>
		</tr>
		<g:if test="${churchPlanter.cpcaCompletionDate}">
		<g:set var="counter" value="${0}"/>	
		<g:each in="${isForReferenceSurveys}" status="i" var="isFRSurvey">	
		
		 	
		<tr class="dotUnder alignLeft">	
			<td style="width:40px;"><a id="show${isFRSurvey.id}in" class="showHide"><img src="${resource(dir:'images',file:'openUp.png')}" id="openUp${isFRSurvey.id}in" border="0"><img src="${resource(dir:'images',file:'openDown.png')}" id="openDown${isFRSurvey.id}in" border="0" style="display:none"></a></td>
			<td><h3 style="text-transform: capitalize">${isFRSurvey.getTranslationByLocale(locale)?.name?:message(code:"message.churchPlanter.general.noTranslation")}</h3></td><td><a class="choose" style="float:right;" href="${createLink(controller:'reference', action:'show')}">${message(code:"message.churchplanter.menu.manage") }</a></td>
		</tr>
		<tr class="menuOverview" id="overview${isFRSurvey.id}in">
		  <td colspan="10">
			<div class="listTop"></div>
			<table width="100%" class="list" cellspacing="5">
			<tr>
				<td class="listContainer pad10LR"><div class="floatUp">
				<h2><g:message code="message.churchPlanter.menu.survey.overview"/></h2>
				${isFRSurvey.getTranslationByLocale(locale)?.overview?:message(code:"message.churchPlanter.general.noTranslation")}
				
				</div>
				</td>
			</tr>
			</table>
			<div class="listBottom"></div>
		  </td>
		</tr>
		<g:set var="counter" value="${counter + 1}" />
		</g:each>
		</g:if><g:else>
		
		<tr class="dotUnder alignLeft">
			<td class="noResults alignCenter"><g:message code="message.access.report.notComplete"/></td>
		</tr>
		
		</g:else>
		<g:if test="${isForReferenceSurveys.size() == 0}">
		<tr class="dotUnder alignLeft">
			<td class="noResults alignCenter"><g:message code="message.churchPlanter.menu.reference.no360"/></td>
		</tr>
		</g:if>
	</table>
		
</table>		
</div>
    
</div>
	<script>
		var surveys = [];
		var isForReferenceSurveys = [];
		<g:set var="j" value="${0}" />
		<g:set var="i" value="${0}" />
	<g:each in="${churchPlanter.passcode.surveys}" var="survey">
		surveys[${i}] = '${survey.id}in';
		<g:set var="i" value="${i+1}" />
		surveys[${i}] = '${survey.id}c';
		<g:set var="i" value="${i+1}" />
	</g:each>

	<g:each in="${isForReferenceSurveys}" var="isFRSurvey">
		surveys[${i}] = '${isFRSurvey.id}in';
		<g:set var="i" value="${i+1}" />
		surveys[${i}] = '${isFRSurvey.id}c';
		<g:set var="i" value="${i+1}" />
	</g:each>
	$.each(surveys,function( intIndex, objValue ){
		$("#show" + objValue).click(function() {
			
				$("#overview" + objValue).toggle("slow");
				$("#openUp" + objValue).toggle();
				$("#openDown" + objValue).toggle();
		
		});
		
	});
	</script>
</body>
</html>