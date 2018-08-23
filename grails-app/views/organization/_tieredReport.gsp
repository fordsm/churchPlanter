<%@ page import="com.lifeway.cpDomain.Category" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
 <html>
    <head>
      <title><g:message code="message.churchPlanter.summaryReport.title" args="[surveyResponse.survey.getTranslationByLocale()?.name?:'',churchPlanter.firstName + ' ' + churchPlanter.lastName]"/></title>
		<link rel="stylesheet" href="${resource(dir:'css',file:'report.css',absolute:true)}" />
		
	</head>
    <body>
    <div id="pageBody">
		 <div id="grailsLogo" class="logo">
		<img id="mainLogo" src="${resource(dir:'images',file:'logoHeadPDF.png',absolute:true)}"	alt="Church Planter Candidate Assessment" border="0" />
	</div>
    
    <div id="pageContent" style="margin-right:25px">
	<div class="mainBodyBG">
	<div id="pageBody" style="text-align:left">
		<div class="dialog" style="text-align:left">
		<h1><g:message code="message.churchPlanter.tieredReport.title" args="[surveyResponse.survey.getTranslationByLocale()?.name?:'',churchPlanter.firstName + ' ' + churchPlanter.lastName]"/></h1>
		<h2><g:message code="message.churchPlanter.summaryReport.prepared" args="[churchPlanter.organization.name]" /></h2>
		${surveyResponse.survey.getTranslationByLocale()?.tierOverview?:message(code:"message.churchPlanter.general.noTranslation") }
		<div style="clear:both;"></div>
		<div class="tdSep"></div>
		<g:set var="color" value="green" />
		<g:set var="greenTotal" value="${0}"/>
		<g:set var="yellowTotal" value="${0}" />
		<g:set var="redTotal" value="${0}" />
		<table cellpadding="0" border="0" cellspacing="0">
		<tr>
		<g:each in="${tiers}" var="tier" status="i">
		<td valign="top" style="padding-top:${i*35}px; width: 20%">
		<div class="tierBox header"><h2>Tier ${i+1}</h2></div>
		<g:each in="${tier}" var="category" >
		<g:if test="${surveyResponse.survey.dividend == 0}">
			<g:if test="${category?.redThreshold >= categoryPercentageMap[category.id]}">
				<g:set var="color" value="red" />
				<g:set var="redTotal" value="${redTotal + 1}" />
				${followUps.add(category.id)?"":""}
			</g:if>
			<g:elseif test="${category.yellowThreshold >= categoryPercentageMap[category.id]}">
				<g:set var="color" value="yellow" />
				<g:set var="yellowTotal" value="${yellowTotal + 1}"/>
				${followUps.add(category.id)?"":""}
			</g:elseif>
			<g:else>
				<g:set var="color" value="green" />
				<g:set var="greenTotal" value="${greenTotal + 1}" />
			</g:else>
		</g:if>
		<g:else>
			<g:if test="${category?.redThreshold >= surveyResponse.survey.dividend*(categoryPercentageMap[category.id]/100)}">
				<g:set var="color" value="red" />
				<g:set var="redTotal" value="${redTotal + 1}" />
				${followUps.add(category.id)?"":""}
			</g:if>
			<g:elseif test="${category.yellowThreshold >= surveyResponse.survey.dividend*(categoryPercentageMap[category.id]/100)}">
			<g:set var="color" value="yellow" />
			<g:set var="yellowTotal" value="${yellowTotal + 1}" />
			${followUps.add(category.id)?"":""}
			</g:elseif>
			<g:else>
				<g:set var="color" value="green" />
				<g:set var="greenTotal" value="${greenTotal + 1}" />
			</g:else>
		</g:else>
		
		<div class="tierBox ${color}">${category.getTranslationByLocale().displayText}
			</div>
			
		</g:each>
		
		</td>
		</g:each>
		<td style="width: 20%;"></td>
		</tr>
		</table>
		
		<div style="float:right; width:100px;">
			<div class="tieredBG tieredBGgreen"><div style="padding-top: 28px">${greenTotal}</div></div>
			<div class="tieredBG tieredBGyellow"><div style="padding-top: 28px">${yellowTotal}</div></div>
			<div class="tieredBG tieredBGred"><div style="padding-top: 28px">${redTotal}</div></div>
		</div>
		
				<div style="page-break-after: always;"></div>
		
		 
		
		<table cellpadding="0" border="0" cellspacing="0">
		<tr><th colspan="10" class="tierBox header"><h2>Follow Up Questions:</h2></th></tr>
		<g:each in="${categories}" var="category" status="i">
		<g:if test="${followUps.contains(category.id)}">
		<tr>
			<td style="padding-top:15px;"><a name="${category.id}"></a><h2>${category.getTranslationByLocale().displayText}</h2></td>
			</tr>
			<tr>
			<td>${category.getTranslationByLocale()?.categoryFollowup?:''}</td>
		</tr>
		</g:if>
		</g:each>
		</table>
        </div>
        </div>
        </div>
		</div>
    </div>
</body>
</html>