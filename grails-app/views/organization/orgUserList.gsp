<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
    </head>
    <body>
    	<div id="pageBody">
            <h1>${organization.name} - <g:message code="message.churchPlanter.maintenance.users.heading"/></h1>          
           

			<g:if test="${flash.message}">
				<div class="message">${flash.message}</div>
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
                    <tr><td class="listContainer">
		    <table width="100%" border="0">        
		       <g:if test="${!orgUserList}">
		       <g:message code="message.user.list.empty"/>
		       </g:if>
                    <g:if test="${orgUserList}">
                    <tr align="left">
                    	<th><g:message code="message.churchPlanter.maintenance.users.list.column.userName"/></th>
			<th><g:message code="message.churchPlanter.maintenance.users.list.column.email"/></th>
			<th><g:message code="message.churchPlanter.id.organization"/></th>
			<th>&nbsp;</th>
                    </tr>
                    </g:if>      
					<g:each in="${orgUserList.sort{a,b-> a.firstName.compareTo(b.firstName)}}" var="user" status="counter">
					
	       	  		  	<tr class='<g:if test="${counter % 2 == 0}">mainList</g:if><g:else>subList</g:else> alignLeft'>
						 <td>							
							${user.firstName} ${user.lastName }
						 </td>	
						 <td>
							${user.email}
						 </td>
						  <td>
							${user.organization.name}
						 </td>
						 <td>
						    <a href="${createLink(action:'viewOrgUser',params:[id:user.id])}"><g:message code="message.churchPlanter.view"/></a> <g:if test="${modificationPrivileges}"> | <a href="${createLink(action:'editOrgUser',params:[id:user.id])}"><g:message code="message.churchPlanter.edit"/></a> </g:if>
						 </td>
					</tr> 	
	       	  		</g:each>
	       	  		
		    </table>
		   
		    </td></tr>
		    <tr align="center"><td>		    
		     <g:paginate next="Next" prev="Previous" max="10"
          		  		 controller="organization" params="[id:params?.id]"
           		  		 action="orgUserList" total="${orgUserListSize}" />
		    </td></tr>
		    
	       		</table>
	       		
		  <div class="listBottom">
		  
		  </div>
		   <g:if test="${modificationPrivileges}">
         	<a class="choose" href="${createLink(action:'createOrgUser')}">Create</a>
         	</g:if> <div style="clear:both"></div>
        </div>
</body></html>