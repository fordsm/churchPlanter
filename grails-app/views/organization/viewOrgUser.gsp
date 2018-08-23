
<%@ page import="com.lifeway.cpDomain.OrgUser" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'orgUser.label', default: 'OrgUser')}" />
        <title><g:message code="message.user.show.title" args="[orgUserInstance.firstName,orgUserInstance.lastName]" /></title>
    </head>
    <body>
        <div id="pageBody">
        <div>
       <h1><g:message code="message.user.show.title" args="[orgUserInstance.firstName,orgUserInstance.lastName]" /></h1>
         </div>   
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
           <g:if test="${flash.error}">
			<div class="errors">				
				${flash.error}
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
            <tr><td class="listContainer">
             <tr><td class="listContainer">
           <h2><g:message code="message.churchPlanter.summary"/></h2>
           
            <table width="100%" class="data">
            	<tr>
						<th><g:message code="message.orgUser.churchPlanter.list.column.name"/></th>
						<th><g:message code="message.user.id.organization" /></th>
						<th><g:message code="message.user.id.phone" /></th>
						<th><g:message code="message.user.id.email"/></th>					
				</tr> 
            	<tr class='main'>
							<td>${orgUserInstance.firstName} ${ orgUserInstance.lastName}</a> </td>	
							<td> ${fieldValue(bean: orgUserInstance, field: "organization")}</td>
							<td>${fieldValue(bean: orgUserInstance, field: "phone")}</td>
							<td>${fieldValue(bean: orgUserInstance, field: "email")}</td>
							</tr>
		   </table>
		   
		    <h2><g:message code="message.churchPlanter.info"/></h2>
		    <table width="100%" border="0" class="data">
                  
                        <tr class="subList alignLeft">
                             <td valign="top" class="name"><b><g:message code="message.user.id.name" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: orgUserInstance, field: "firstName")} ${fieldValue(bean: orgUserInstance, field: "lastName")}</td>
                            
                        </tr>
                    
                        
                    
                    	<tr class="prop2 dotUnder alignLeft">
                    	
                                <td valign="top" class="name">
                                   <b> 
                                   <label for="address.line1">
                                   <g:message code="message.user.id.addressLine1" />
                                   </b></label>
                                </td>
                                <td valign="top" class="value">${fieldValue(bean: orgUserInstance, field: "address.line1")}</td>
                            </tr>
                        	<tr class="mainList alignLeft">
                                <td valign="top" class="name">
                                    <label for="address.line2">
                                    <b><g:message code="message.user.id.addressLine2" /></b></label>
                                </td>
                                <td valign="top" class="value">${fieldValue(bean: orgUserInstance, field: "address.line2")}</td>
                            </tr>
                        	<tr class="subList alignLeft">
                                <td valign="top" class="name">
                                    <label for="address.city">
                                    <b><g:message code="message.user.id.city" /></b></label>
                                </td>
                                <td valign="top" class="value">${fieldValue(bean: orgUserInstance, field: "address.city")}</td>
                            </tr>
                        	<tr class="prop2 dotUnder alignLeft">
                                <td valign="top" class="name">
                                    <label for="address.state">
                                    <b><g:message code="message.user.id.state" /></b></label>
                                </td>
                                <td valign="top" class="value">${fieldValue(bean: orgUserInstance, field: "address.state")}</td>
                            </tr>
                        	<tr class="mainList alignLeft">
                                <td valign="top" class="name">
                                    <b><label for="address.zipCode"><g:message code="message.user.id.zipcode" /></label></b>
                                </td>
                                <td valign="top" class="value">${fieldValue(bean: orgUserInstance, field: "address.zipCode")}</td>
                            </tr>
                                   
                    
                        <tr class="subList alignLeft">
                            <td valign="top" class="name">
                            <b><g:message code="message.user.id.email" /></b>
                            </td>
                            
                            <td valign="top" class="value">${fieldValue(bean: orgUserInstance, field: "email")}</td>
                            
                        </tr>
                    
                        
                    
                        <tr class="mainList alignLeft">
                            <td valign="top" class="name">
                            <b><g:message code="message.user.id.role" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: orgUserInstance, field: "role")}</td>
                            
                        </tr>
                    
                        <tr class="subList alignLeft">
                            <td valign="top" class="name">
                            <b><g:message code="message.user.id.positionScope" /></b></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: orgUserInstance, field: "positionScope")}</td>
                            
                        </tr>
                    
                    
                        <tr class="prop2 alignLeft">
                            <td valign="top" class="name">
                            <b><g:message code="message.user.id.adminPrivileges" /></b>
                            </td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${orgUserInstance?.hasAdminPrivileges}" /></td>
                            
                        </tr>
                    
                       
                </table>
                 </td>
		    </tr>
	 </table>
               <div class="listBottom"> 
               </div>
             <div class="noFloatOrMargin" style="height: 100px">
				<g:if test="${modificationPrivileges}">
           			<a class="choose " href="${createLink(controller:"organization",action:'editOrgUser',id:orgUserInstance?.id)}">${message(code: 'default.button.edit.label', default: 'Edit')}</a>
           			<g:if test="${(request.getSession(false)?.UserId == orgUserInstance.id)}">
               			<a class="choose" href="${createLink(controller:"home",action:'changePassword',id:orgUserInstance?.id)}">${message(code: 'message.churchPlanter.changePassword.title', default: 'Change Password')}</a>
               		</g:if>	
            	</g:if>
            </div>	
        </div>
    </body>
</html>
