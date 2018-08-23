<%@ page import="org.springframework.context.i18n.LocaleContextHolder" %>

<html>
<head>
<title><g:message code="message.churchPlanter.survey.take.title" args="[surveyTitle]" /></title>
<meta name="layout" content="main" />
<g:javascript library="jquery" />
</head>
<body>
	<div id="pageBody">
		<g:if test="${flash.message}">
			<div class="message">
				${flash.message}
			</div>
		</g:if>
		<div class="dialog">
			<h1>
			${message(code: 'message.churchPlanter.survey.take.title',args:[surveyTitle])}
			</h1>
			<div class="dotUnder" style="display: block"></div>
			<g:if test="${checkTranslation}">
				<g:if test="${flash.error}">
					<div class="errors">
						${flash.errorMessage}
					</div>

				</g:if>
				<div style="width: 550px">
				<!-- Figure out how to get instructions without column -->
					<div id="grid"></div>
				</div>
			</g:if>
			<g:else>
				<div style="margin-top: 25px">
					<g:message code="message.churchPlanter.survey.take.noTranslation" />
				</div>
			</g:else>
		</div>
	</div>
	<script>
	    $(document).ready(function(){

	    	$.ajax({
                type: "POST",
                url: "${createLink(controller:'reference', action:'take',params:[churchPlanterId:params.churchPlanterId,organizationId:params.organizationId,referenceId:params.referenceId])}",
                cache:false,
                success: function(data) {
               	$('#grid').html(data);
                }
         	 });

	    	
		    })
	    </script>
</body>
</html>