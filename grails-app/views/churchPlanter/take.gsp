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
				<g:message code="message.churchPlanter.survey.take.title" args="[surveyTitle]" />
			</h1>
			<div class="dotUnder" style="display: block"></div>
			<g:if test="${checkTranslation}">
				<g:if test="${flash.error}">
					<div class="errors">
						${flash.errorMessage}
					</div>

				</g:if>
				<div style="width: 550px">
					<g:if test="${surveyResponse.survey.getTranslationByLocale(locale)?.instructions}">
						${surveyResponse.survey.getTranslationByLocale(locale)?.instructions}
						<div style="clear: both;" class="tdSep"></div>
					</g:if>
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
                url: "${createLink(controller:'churchPlanter', action:'take',id:params.id)}",
                cache:false,
                success: function(data) {
               	$('#grid').html(data);
                }
         	 });

	    	
		    })
	    </script>
</body>
</html>