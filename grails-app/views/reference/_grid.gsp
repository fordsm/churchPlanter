<%@ page import="com.lifeway.cpDomain.Translation" %>
<g:if test="${translations}"><form id="assessment" name="assessment">
<table class="ajax">
    <g:each in="${translations.sort{a,b-> a.question.sequenceNumber.compareTo(b.question.sequenceNumber)}}" status="i" var="translation">
        <tr class="questionHead">
            <td><h2 class="sequenceNumber">${translation.question.sequenceNumber}.</h2></td>
            <td><h2>${translation.displayText?:''}</h2></td>
         </tr>
         <tr class="dotUnder">
         	<td> </td>
         	<td style="text-align:left; padding:7px;">
	         	<g:if test="${translation.question.questionType.toString() == 'radio' }">
	         		<g:each in="${translation.question.possibleAnswers.sort{a,b-> a.sequenceNumber.compareTo(b.sequenceNumber)}}" status="k" var="answer">
		         	<div class="answer">
		         	<g:radio type="radio" name="question.${translation.question.id}" value="${answer.value}"/>	${Translation.findByPossibleAnswerAndLocale(answer,locale)?.displayText?:''}<br></div>
		         	</g:each>
	         	</g:if>
	         
         	</td>
         </tr>
         <tr><td colspan="10" class="tdSep"> </td></tr>
    </g:each>
    <tr>
    	<td colspan="10">
    		<a class="choose" style="cursor:pointer;" >${message(code: 'message.churchPlanter.survey.take.next')}</a>
    				<td>
    </tr>
</table> 

</form>           


<script>
        $(function() {
        	
            $(".choose").click(function() {
                var i = 0
                var dataString = 'offset=' + ${((params.offset?:0).toInteger()+params.max.toInteger())} + '&max=' + ${params.max} + '&sort=sequenceNumber&order=asc';
            	<g:each in="${translations}" status="i" var="translation">
            		dataString += '&question.${translation.question.id}=' + $('input[name="question.${translation.question.id}"]:checked', '#assessment').val();
            	</g:each>
            	if($("input:checked").length == ${translations.size()}){
            		$(grid).html($("#spinner").html());
            	 	$.ajax({
	                     type: "POST",
	                     url: "${createLink(controller:'reference', action:'take',params:[churchPlanterId:params.churchPlanterId,organizationId:params.organizationId,referenceId:params.referenceId])}",
	                     data: dataString,
	                     cache:false,
	                     success: function(data) {
	                    	$('#grid').fadeOut('slow', function() {$(this).html(data).fadeIn('slow');});
	                     },
	                     error: function(data) {
		                    	$('#grid').html('${message(code: 'message.churchPlanter.survey.take.error')}' + data);
		     
		                     }
                  	 });
            	 	$( 'html, body' ).animate( { scrollTop: 0 }, 'slow');
            } else{
				alert('<g:message code="message.churchPlanter.survey.take.unansweredQuestions"/>');
                }

                 
            });
          });
</script>
</g:if><g:else>
							<div class="surveyComplete">
								<h2>
								${message(code: 'message.churchPlanter.survey.take.completeStatus')}</h2>
							</div>
						</g:else>