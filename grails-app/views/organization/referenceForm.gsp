<html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
       
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
		<script type="text/javascript" src="${resource(dir:'js',file:'ckeditor/ckeditor.js')}"></script>	
		<script type="text/javascript" src="${resource(dir:'js',file:'ckeditor/ckhelper.js')}"></script>	
    </head>
    <body>
    	<div id="pageBody">
    	
		<h2><g:message code="message.churchPlanter.email.Reports" /></h2>
		<g:if test="${flash.errorMessages}">
   <div class="errors">
      <g:each in="${flash.errorMessages}" var="errorMessage">
            <ul><li>${errorMessage}</li></ul>				
      </g:each>
   </div>
</g:if>
		     <g:form method="post"  controller="organization" >
    		 <table>
                        <tbody>
                        
                            <tr>
                            	<td colspan="2" style="padding-bottom: 15px">
                            	   <g:message code="message.organization.controller.churchPlanter.surveyReport.pageInstructions" />
                            	</td>
                            </tr>                          
                            <tr>
                                <td valign="top" class="name width15">
                                </td>
                                <td valign="bottom"> 
                                  <i>( <g:message code="message.organization.controller.churchPlanter.surveyReport.emailAddressInstructions" />)</i>
                                </td>
                            </tr>                          
                            <tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="url">To</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: resourceURLInstance, field: 'url', 'errors')}"> 
                                   <g:textArea name="mailToList" value="" style="height:30px" />
                                </td>
                            </tr>
							<tr class="prop">
                                <td valign="top" class="name width15">
                                    <label for="url">Subject</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: resourceURLInstance, field: 'url', 'errors')}">
                                    <g:textField name="messageSubject" value="" style="width:87%"/>
                                </td>
                            </tr>
							                        
                              <tr>
                                <td valign="top" class="name" width="20%">
                                    <label for="resourceText">Content</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: resourceURLInstance, field: 'displayText', 'errors')}">                           
                               		 <g:textArea id="resourceText" style="display:none" name="resourceText" value="${resourceURLInstance?.displayText}"/>
                               	</td>
                            </tr>

                            <tr class="prop">
                             	<td valign="top" class="name width15">
                                    <label for="displayText">
                                    Attachment</label>
                                </td>
                            	<td colspan="1" align="left" style="text-align: left;">
                            	<img src="${resource(dir:'images',file:'attachment.jpg')}">
                            	<g:if test="${isSpouseReport}">
     								<a href="${createLink(controller:'organization', action:'referenceReport',params:[ChurchPlanterId: params.ChurchPlanterId,pdf:'true',spouse:"spouse"], id:params.id)}">
								</g:if>
								<g:else>
   									<a href="${createLink(controller:'organization', action:'referenceReport',params:[ChurchPlanterId: params.ChurchPlanterId,pdf:'true'], id:params.id)}">
								</g:else>
                            	<a href="${createLink(controller:'organization', action:'referenceReport',params:[ChurchPlanterId: params.ChurchPlanterId,pdf:'true'], id:params.id)}">
                            	<b style="color: green;">${attachment}</b></a>
                            	</td>
                            </tr>
                        	<tr class="prop">
                                <td valign="top" class="name" colspan="2">
                                <g:hiddenField name="id" value="${params.id}"></g:hiddenField>
                                <g:hiddenField name="ChurchPlanterId" value="${params.ChurchPlanterId}"></g:hiddenField>
                                <g:if test="${isSpouseReport}">
                                 <g:hiddenField name="spouse" value="true"></g:hiddenField>
                                 </g:if>
                                <g:if test="${params.tiered}"><g:hiddenField name="tiered" value="${params.tiered}"></g:hiddenField></g:if>
                             <g:actionSubmit class="choose"  action="sendReferenceReportEmail" value="${message(code: 'default.button.send.label', default: 'Send')}" />

                                </td>                               
                            </tr>
                        
                        </tbody>
                    </table></g:form>
    	</body>
    	</html>