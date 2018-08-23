<html>
    <head>
        <title>Church Planter Resources</title>
		<meta name="layout" content="main" />
		<link rel="stylesheet" href="${resource(dir:'css',file:'styles.css')}" />
   
    </head>
    <body>
       <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/home/choose')}">Home</a></span>
         </div>
       <div class="body">
            <h1>Resources</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
       	  		 <table>
                    <tbody>
            
                    
			            <g:if test="${orgResources}"> 
			       	  		<g:each in="${orgResources.resourceURLs}" var="resourceURL">
			       	  		  	<tr class="prop">
									<td>
										<a href="${resourceURL.url}">${resourceURL.displayText }</a>
									</td>	
								</tr> 			
			       	  		</g:each>
			       	  	</g:if>
       		</div>  	       
        </div>
</body></html>