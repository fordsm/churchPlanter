<html>
    <head>
        <title>${page}</title>
		<meta name="layout" content="main" />
		<g:javascript library="jquery"/>
    </head>
    <body>
    <div id="pageBody">

		<div class="dialog">
			<g:if test="${session.UserId }">
				<g:include controller="user" action="nav"/>
			</g:if>

  			<h1>
  			 	 ${page.title}            
  			</h1>
  			<p>
  			     ${page?.content}
  			</p>
  			
        </div>
      </div>
</body>
</html>