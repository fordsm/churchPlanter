<%@ page import="com.lifeway.cpDomain.Survey"%>
<%@ page import="com.lifeway.cpDomain.SurveyResponse"%>
<html>
<head>
<title><g:message code="message.churchPlanter.title" /></title>
<meta name="layout" content="main" />
</head>
<body>
<div id="pageBody">
<h1><g:message code="message.churchPlanter.showChurchPlanter"
	args="[churchPlanter.firstName, churchPlanter.lastName]" /></h1>
<g:if test="${flash.message}">
	<div class="message">
	${flash.message}
	</div>
</g:if>
<g:if test="${flash.errorMessages}">
   <div class="errors">
      <g:each in="${flash.errorMessages}" var="errorMessage">
            <ul><li>${errorMessage}</li></ul>				
      </g:each>
   </div>
</g:if>
<div class="listTop"></div>
<table width="100%" class="list" cellspacing="5">
	<tr>
		<td class="listContainer">
		<h2><g:message code="message.churchPlanter.summary" /></h2>

	
		<table width="100%" class="data" cellspacing="3">
			<tr class="mainList alignLeft">
				<td valign="top" class="name"><b><g:message
					code="message.churchPlanter.id.organization" /></b></td>
				<td valign="top" class="value" colspan="10"><g:link
					controller="home" action="menu"
					id="${churchPlanter.organization.id}">
					${churchPlanter.organization}
				</g:link></td>
			</tr>
			<tr class="subList alignLeft">
				<td valign="top" class="name"><b><g:message
					code="message.churchPlanter.id.name" /></b></td>
				<td valign="top" class="value" colspan="10">
				${churchPlanter.lastName}, ${churchPlanter.firstName}
				</td>

			</tr>
			<tr class="prop2 dotUnder alignLeft">
				<td valign="top" class="name"><b><g:message
					code="message.churchPlanter.id.email" /></b></td>
				<td valign="top" class="value" colspan="10">
				${churchPlanter.email}
				</td>
			</tr>
			<tr class="mainList alignLeft">
				<td valign="top" class="name"><b> <g:message
					code="message.churchPlanter.id.state" /></b></td>
				<td valign="top" class="value" colspan="10">
				${churchPlanter.state}
				</td>
			</tr>


			<tr class="subList alignLeft">
				<td valign="top" class="name"><b><g:message
					code="message.churchPlanter.id.ministryServiceYears" /></b></td>
				<td valign="top" class="value" colspan="10">
				${churchPlanter.ministryServiceYears}
				</td>
			</tr>
			
			<tr class="subList alignLeft">
				<td valign="top" class="name"><b><g:message
					code="message.orgUser.churchPlanter.list.column.isPlanting" /></b></td>
				<td valign="top" class="value" colspan="10">
				<g:if test="${churchPlanter.isPlanting}"><img src="${resource(dir:'images',file:'leaf.png')}"></g:if><g:else>${message(code: 'message.orgUser.churchPlanter.list.column.notYet')}</g:else>
				</td>
			</tr>
		
			<tr class="prop2 dotUnder alignLeft">
				<td valign="top" class="name"><b><g:message
					code="message.churchPlanter.id.passcode" /></b></td>
				<td valign="top" class="value" colspan="10">
				${churchPlanter.passcode.code}
				</td>
			</tr>
		</table>
<hr style="margin-bottom:25px;"/>
		<h2><g:message code="message.churchPlanter.menu.completeSurveys" /></h2>
		<table width="100%" cellspacing="0" cellpadding="0"
			style="margin-bottom: 25px;">

			<g:each in="${surveys.sort{a,b-> a.sequenceNumber.compareTo(b.sequenceNumber)}}"
				status="i" var="survey">
<g:if test="${survey.isForReferences == false}">
				<tr class="alignLeft dotUnder">
					<td style="width: 30%">
					<h3 style="text-transform: capitalize">
					${survey.getTranslationByLocale()?.name?:message(code:"message.churchPlanter.general.noTranslation")}
					</h3>
					</td>
					<g:if test="${!SurveyResponse.findByChurchPlanterAndSurvey(churchPlanter,survey)}">
					<td style="text-align: right;" valign="bottom" colspan="3" >
						<img src="${resource(dir:'images',file:'false.png')}">
					</td>
					</g:if> <g:else>

						<g:if test="${SurveyResponse.findByChurchPlanterAndSurvey(churchPlanter,survey)?.completionDate && survey?.isSummaryReportActive}">
						<td style="text-align: right;" >
							<a class="report" href="${createLink(controller:'organization', action:'summaryReport',params:[ChurchPlanterId: churchPlanter.id], id:survey.id)}">
								${message(code: 'message.churchPlanter.menu.summary')}								
							</a>
						</td>
						<td  style="text-align: right;" >
							<a class="email" href="${createLink(controller:"organization",action:'emailForm' ,params:[ChurchPlanterId: churchPlanter.id], id:survey.id)}">
							<g:message code="message.churchPlanter.email" /></a>
						</td>
						<td  style="text-align: right;" >
							<a class="pdfLink" style="margin-top: 0px;" href="${createLink(controller:'organization', action:'summaryReport',params:[ChurchPlanterId: churchPlanter.id,pdf:"pdf"], id:survey.id)}">&nbsp;</a>
						</td>	
						</g:if>
						<g:else>
						<td style="text-align: right;" valign="bottom" colspan="3"> 
						In Progress
						</3td>
						</g:else>
					</g:else>
				</tr>
				<g:if test="${SurveyResponse.findByChurchPlanterAndSurvey(churchPlanter,survey)?.completionDate && survey?.isTieredReportActive}"><tr>
				<td><h3 style="text-transform: capitalize">Tiered ${survey.getTranslationByLocale()?.name?:message(code:"message.churchPlanter.general.noTranslation")}</h3></td>
				<td style="text-align: right;" >
							<a class="tiered" href="${createLink(controller:'organization', action:'tieredReport',params:[ChurchPlanterId: churchPlanter.id], id:survey.id)}">
								&nbsp;								
							</a>
						</td>
						<td  style="text-align: right;" >
							<a class="email" href="${createLink(controller:"organization",action:'emailForm' ,params:[ChurchPlanterId: churchPlanter.id, tiered:true], id:survey.id)}">
							<g:message code="message.churchPlanter.email" /></a>
						</td>
						<td  style="text-align: right;" >
							<a class="pdfLink" style="margin-top: 0px;" href="${createLink(controller:'organization', action:'tieredReport',params:[ChurchPlanterId: churchPlanter.id,pdf:"pdf"], id:survey.id)}">&nbsp;</a>
						</td>	
				</tr>
				</g:if>
				<g:if test="${SurveyResponse.findByChurchPlanterAndSurvey(churchPlanter,survey)?.completionDate && survey?.isUmbrellaReportActive}">
				<td><h3 style="text-transform: capitalize">Umbrella ${survey.getTranslationByLocale()?.name?:message(code:"message.churchPlanter.general.noTranslation")}</h3></td>
				<td style="text-align: right;" >
							<a class="umbrella" href="${createLink(controller:'organization', action:'umbrellaReport',params:[ChurchPlanterId: churchPlanter.id], id:survey.id)}">
								&nbsp;								
							</a>
						</td>
						<td  style="text-align: right;" >
							
						</td>
						<td  style="text-align: right;" >
							<!--  <a class="pdfLink" style="margin-top: 0px;" href="${createLink(controller:'organization', action:'umbrellaReport',params:[ChurchPlanterId: churchPlanter.id,pdf:"pdf"], id:survey.id)}">&nbsp;</a>-->
						</td>	
					</g:if>
				</tr></g:if>
			</g:each>
		</table>

<hr style="margin-bottom:25px;"/>
<h2><g:message code="massage.access.organization.header" /></h2>
<g:if test="${spouseReference && churchPlanter.cpcaCompletionDate}">
	<table width="100%" cellspacing="0" cellpadding="0" border="0"
			style="margin-bottom: 0px;">
		<tr>
				<td style="width: 30%">
					<h3 style="text-transform: capitalize"><g:message code="message.access.spouse.reference.report"/></h3></td>
				<td style="text-align: right;" >
							<a class="report" href="${createLink(controller:'organization', action:'referenceReport',params:[ChurchPlanterId: churchPlanter.id,spouse:"spouse"], id:referencesSurvey.id)}">
								${message(code: 'message.churchPlanter.menu.summary')}								
							</a>
						</td>
						<td  style="text-align: right;" >
							<a class="email" href="${createLink(controller:"organization",action:'referenceEmailForm' ,params:[ChurchPlanterId: churchPlanter.id,spouse:"spouse"], id:referencesSurvey.id)}">
							<g:message code="message.churchPlanter.email" /></a>
						</td>
						<td  style="text-align: right;" >
							<a class="pdfLink" style="margin-top: 0px;" href="${createLink(controller:'organization', action:'referenceReport',params:[ChurchPlanterId: churchPlanter.id,pdf:"pdf",spouse:"spouse"], id:referencesSurvey.id)}">&nbsp;</a>
						</td>	
				</tr>	
	</table>		
</g:if>
<g:if test="${completedCount == 6 && churchPlanter.cpcaCompletionDate}">
		<table width="100%" cellspacing="0" cellpadding="0" border="0"
			style="margin-bottom: 25px;">
			<tr class="alignLeft dotUnder">
					<td style="width: 30%">
					<h3 style="text-transform: capitalize">
					${referencesSurvey.getTranslationByLocale()?.name?:message(code:"message.churchPlanter.general.noTranslation")}
					</h3>
					</td>

						<td style="text-align: right;" >
							<a class="report" href="${createLink(controller:'organization', action:'referenceReport',params:[ChurchPlanterId: churchPlanter.id], id:referencesSurvey.id)}">
								${message(code: 'message.churchPlanter.menu.summary')}								
							</a>
						</td>
						<td  style="text-align: right;" >
							<a class="email" href="${createLink(controller:"organization",action:'referenceEmailForm' ,params:[ChurchPlanterId: churchPlanter.id], id:referencesSurvey.id)}">
							<g:message code="message.churchPlanter.email" /></a>
						</td>
						<td  style="text-align: right;" >
							<a class="pdfLink" style="margin-top: 0px;" href="${createLink(controller:'organization', action:'referenceReport',params:[ChurchPlanterId: churchPlanter.id,pdf:"pdf"], id:referencesSurvey.id)}">&nbsp;</a>
						</td>	
			

				</tr>
			
			</table>
</g:if><g:else>
<div style="text-align:center;"><g:message code="message.access.report.noSurvey" default="Not Available"/></div>
</g:else>
<div class="tdSep"></div>
<hr style="margin-bottom:25px;"/>

		<h2><g:message code="message.churchPlanter.aboutme.calling" /></h2>
		<div class="about">
		${churchPlanter.calling?:'N/A'}
		</div>
		<h2><g:message code="message.churchPlanter.aboutme.testimony" /></h2>
		<div class="about">
		${churchPlanter.testimony?:'N/A'}
		</div>
		<h2><g:message code="message.churchPlanter.aboutme.doctrine" /></h2>
		<div class="about">
		${churchPlanter.doctrine?:'N/A'}
		</div>

		</td>
	</tr>
</table>
<div class="listBottom"></div>
</div>
</body>
</html>
