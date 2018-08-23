
<%@ page import="com.lifeway.cpDomain.ResourceURL" %>

        <div>
       
            <g:if test="${orgResourceInstance.resourceURLs}">
            <div class="list">
                <table style="width:92%">
                    <thead>
                        <tr align="left">
                        
                            
                            <g:sortableColumn property="url" title="${message(code: 'message.churchPlanter.maintenance.resources.list.column.url')}" />
                        
                            <g:sortableColumn property="displayText" title="${message(code: 'message.churchPlanter.maintenance.resources.list.column.displayText')}" />
                        	<th class="sortable">&nbsp;</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${orgResourceInstance?.resourceURLs}" status="i" var="resourceURLInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                    
                            <td>${fieldValue(bean: resourceURLInstance, field: "url")}</td>                        
                            <td style="width: 30em; word-wrap: break-word">${fieldValue(bean: resourceURLInstance, field: "displayText")}</td>
                            <td><g:link action="viewResourceURL" id="${resourceURLInstance?.id}">view</g:link></td>
                        
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            </g:if>
            
            <g:if test="${!orgResourceInstance.resourceURLs}">
            	<div><b><g:message code="message.churchPlanter.maintenance.urlresource.notFound"/></b></div>
            </g:if>
                       <bR> 
         
           
        </div>
  