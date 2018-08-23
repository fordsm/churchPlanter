<%@ page import="com.lifeway.cpDomain.EducationLevel" %>
<%@ page import="com.lifeway.cpDomain.Ethnicity" %>
<%@ page import="com.lifeway.cpDomain.Country" %>
<html>
    <head>
        <title><g:message code="message.churchPlanter.reference.360.title" /></title>
		<meta name="layout" content="main" />
		<g:javascript library="jquery"/>
    </head>
    <body>
    <div id="pageBody">

<div class="dialog">
  <h1><g:message code="message.churchPlanter.reference.360.title" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
             <g:hasErrors bean="${churchPlanterInstance}">
             	<div class="errors">
					<g:renderErrors bean="${churchPlanterInstance}" as="list" />
				</div>
            </g:hasErrors>
            <g:hasErrors bean="${reference}">
             	<div class="errors">
					<g:renderErrors bean="${reference}" as="list" />
				</div>
            </g:hasErrors>
            <g:if test="${flash.error}">
	            <div class="errors">
	            	${flash.errorMessage}
	            </div>
            </g:if>
            
            <div style="width: 550px">
					<i>${survey?.getTranslationByLocale()?.instructions}</i>
					<div style="clear: both;" class="tdSep"></div>
				<div id="grid"></div>
			</div>
				
            <g:form action="add" method="post" >
                <div class="dialog">                
                 <table border="0">
                        <tbody>
                                 
                           
                        
                           <tr>
                                <td valign="middle" >
                                    <label for="name"><g:message code="message.churchPlanter.reference.name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reference, field: 'name', ' errors')}">
                                     <g:textField name="name" value="${reference?.name}" />
                                </td>
                           </tr>  
               
                            <tr>
                                <td valign="middle" >
                                    <label for="title"><g:message code="message.churchPlanter.reference.title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reference, field: 'title', ' errors')}">
                                     <g:textField name="title" value="${reference?.title}" />
                                </td>
                            </tr>                            
                           <tr>
                                <td valign="middle" >
                                    <label for="email"><g:message code="message.churchPlanter.reference.email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reference, field: 'email', ' errors')}">
                                     <g:textField name="email" value="${reference?.email}" />
                                </td>
                           </tr>  
               
                            <tr>
                            
                                <td valign="top"  style="padding-top: 5px;">
                                    <label for="category"><g:message code="message.churchPlanter.reference.category" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reference, field: 'category', 'errors')}">
                                     <g:select name="category" from="${(isSpouseExist)?['POM', 'PIM', 'PNF']:['POM', 'PIM', 'PNF','SP']}" valueMessagePrefix="message.churchPlanter.reference.dropdown.category" />
                                </td>                                
                            </tr>
                            <tr>                         
                                <td valign="top"  style="padding-top: 5px;">
                                    <label for="phoneNumber"><g:message code="message.churchPlanter.reference.phoneNumber" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reference, field: 'phoneNumber', ' errors')}">
                                    <g:textField name="phoneNumber" value="${reference?.phoneNumber}"/>
                                </td> 
                            </tr>  
               
                            <tr>                      
     							<td valign="top"  style="padding-top: 5px;">
                                    <label for="yearsKnown"><g:message code="message.churchPlanter.reference.yearsKnown" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: reference, field: 'yearsKnown', ' errors')}">
                                 
                                    <select name="yearsKnown" id="yearsKnown" >
                                    <option value="Less1">${message(code: 'message.churchPlanter.reference.dropdown.yearsKnown.Less1', default: 'Submit Invitations').decodeHTML()}</option>
                                     <option value="1To3">${message(code: 'message.churchPlanter.reference.dropdown.yearsKnown.1To3', default: 'Submit Invitations').decodeHTML()}</option>
                                      <option value="4Plus">${message(code: 'message.churchPlanter.reference.dropdown.yearsKnown.4Plus', default: 'Submit Invitations').decodeHTML()}</option>
                                    </select> 
                                     
                                </td>   
                            </tr>  
               
                            <tr>
                                <td valign="top" >
                                    <label for="whyReceiving"><g:message code="message.churchPlanter.reference.whyReceiving" /></label>
                                </td>
                                <td  valign="top" class="value ${hasErrors(bean: reference, field: 'whyReceiving', 'errors')}">
                                    <g:textArea name="whyReceiving" value="${reference?.whyReceiving}"  style="width:200px;height:50px" />
                                </td>
                           </tr>  
               
                            <tr class="dotUnder">
                                <td valign="top"  style="padding-top: 5px;">
                            		<label for=""><g:message code="message.churchPlanter.reference.surveyLanguage" /></label>
                            	</td>
                            	<td valign="top" class="value ${hasErrors(bean: reference, field: 'locale', ' errors')}">
                            		<g:locale name="locale.id" selectedValue="${reference?.locale?.id}"  />
                            		</br>
                            		    <g:submitButton name="create" class="choose" value="${message(code: 'message.churchPlanter.reference.submitInvitations', default: 'Submit Invitations')}"  />
                            	</td>
                           
                            </tr>
                            
                            
                            <tr><td colspan="3" class="tdSep"> </td></tr>
                        </tbody>
                    </table>
                    
                    
                  </div>
            </g:form>
               
               
            <g:form action="delete" method="post" >
                <div class="dialog"> 
                <h1><g:message code="message.churchPlanter.references"/></h1>     
                    <table border="0" cellpadding="4" width="100%" style="border: dashed 1px #CCC;">
                        <tbody>
                         <tr class="alignLeft incomplete headerBG dotUnder">
                          	<td align="center">Name</td>
                          	<td align="center">Title</td>
                          	<td align="center">Email</td>
                          	<td align="center">Category</td>
                          	<td align="center">Language</td>
                          	<td align="center">Status</td>
                          	<td></td>
                          </tr>
                        <g:each in="${references}" var="reference" status="i" >
			             <tr class="category colorCol${(i % 2) == 0?'':'2'} dotUnder alignLeft">
			              	<td><font>${reference?.name}</font></td>
			              	<td><font>${reference?.title}</font></td>
			              	<td><font>${reference?.email}</font></td>
			              	<td><font>${reference?.category}</font> </td>
			              	<td><font>${reference?.locale?.description}</font> </td>			              	
			              	<td>
			                   <g:if test="${reference.hasCompleted }"><font>Completed</font></g:if>
			                   <g:else><font>Not Completed</font></g:else>
			                </td>
			                <td>
			                   <g:if test="${!reference.hasCompleted }">			                   
			                      <g:link controller="reference" action="delete" id="${reference.id}">Delete</g:link>
                               </g:if>
			                </td>
			                
			              </tr>                            
						</g:each>                      
            
                	
		                </tbody>
                    </table>         
 
                </div>
            </g:form>
                        
        </div><!--end most most outer dialog div-->
        
</div><!-- end page body div-->
<g:javascript src="planterHelper.js" />
</body>
</html>