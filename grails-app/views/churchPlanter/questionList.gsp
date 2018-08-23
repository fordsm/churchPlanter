<html>
    <head>
        <title><g:message code="message.churchPlanter.survey.take.title" args="[surveyTitle]"/></title>
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
 
        <h2>Test Question List(${locale.description})</h2>
 
        <g:if test="${flash.message}">
          <div class="message">${flash.message}</div>
        </g:if>
 		<div id="grid">
           <g:render template="grid" model="model" />
        </div>
       
        
        <script>
        $(function() {
            $(".choose").click(function() {

         	   
            });
          });
       
       
        
       // $(document).ready(function() {
       //     setupGridAjax();
       // });
         
        // Turn all sorting and paging links into ajax requests for tables with the class ajax
        //function setupGridAjax() {
        //    $("table.ajax").find(".pagination a").live('click', function(event) {
        //        event.preventDefault();
        //        var url = $(this).attr('href');
        // 
        //        var grid = $(this).parents("table.ajax");
        //        $(grid).html($("#spinner").html());
        // 
        //        $.ajax({
        //            type: 'GET',
        //            url: url,
        //            success: function(data) {
        //                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('slow');});
        //           }
        //        })
        //    });
        //}
        </script>
 
   </div>
	    </div>
	</body>
</html>