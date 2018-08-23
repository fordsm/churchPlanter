<g:set var="currentYear"
	value="${Calendar.instance.get(Calendar.YEAR) }" /><html>
    <head>
        <title><g:message code="message.churchPlanter.title"/></title>
		<meta name="layout" content="main" />
		<g:javascript library="prototype"/>
    </head>
    <body>
    	<div id="pageBody">
            <h1><g:message code="message.orgUser.churchPlanter.list.heading" args="${[organization.name]}" /></h1>
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
            
           
                <g:form action="searchList">
			<table style="width: 500px;">
				<tr>
					<td style="vertical-align: middle;">First Name: </td>
					<td>
						<g:textField name="firstName" value="${params.firstName }" />
					</td>
				</tr>
				<tr>
					<td style="vertical-align: middle;">Last Name:</td>
					<td>
						<g:textField name="lastName" value="${params.lastName }" />
					</td>
				</tr>
				<tr>
					<td style="vertical-align: middle;">Email:</td>
					<td>
						<g:textField name="email" value="${params.email }" />
					</td>
				</tr>
				
				<tr>
					<td style="vertical-align: middle;">Regional Organization:</td>
					<td>
						<g:select name="childOrgs" multiple="multiple" value="${params?.childOrgId }"
							from="${organization.childOrganizations.sort{it.name} }" optionKey="id"
							optionValue="name" noSelection="['':'-Choose One-']" />
					</td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td colspan="2"><h4>Registration Date</h4></td></tr>
				<tr>
					<td style="vertical-align: middle;">Starting</td>
					<td>
						<g:datePicker name="regDate1"
							value="${params.regDate1 }"
							default="none" precision="day" years="${2011..currentYear}"
							noSelection="['':'-Choose-']" />
					</td>
				</tr>
				<tr>
					<td style="vertical-align: middle;">Ending</td>
					<td>
						<g:datePicker name="regDate2"
							value="${params.regDate2 }"
							default="none" precision="day" years="${2011..currentYear}"
							noSelection="['':'-Choose-']" />
					</td>
				</tr>
				<tr><td colspan="2">&nbsp;</td></tr>
				<tr><td colspan="2"><h4>Church Planter Assessment Completion Date</h4></td></tr>
				
				<tr>
					<td style="vertical-align: middle;">Starting</td>
					
					<td>
						<g:datePicker name="cpcaDate1"
							value="${params.regDate1 }"
							default="none" precision="day" years="${2011..currentYear}"
							noSelection="['':'-Choose-']" />
					</td>
				</tr>
				<tr>
					<td style="vertical-align: middle;">Ending</td>
					<td>
						<g:datePicker name="cpcaDate2"
							value="${params.regDate2 }"
							default="none" precision="day" years="${2011..currentYear}"
							noSelection="['':'-Choose-']" />
					</td>
				</tr>
			<tr><td colspan="2">&nbsp;</tr>
				<tr>
					<td style="vertical-align: middle;">Currently Planting</td>
					<td>
						<g:select name="isPlanting" value="" from="${['true','false']}" optionValue="${value }" optionKey="${key}"
							noSelection="['':'-Choose-']"  value ="${params.isPlanting }" />
					</td>
				</tr>
				<tr>
					<td style="vertical-align: middle;">Passcode:</td>
					<td>
						<g:textField name="passcode" value="${params.passcode }" />
					</td>
				</tr>
				<tr>
					<td colspan="100%"><span style="color: #808080;">**
							blank fields act as wildcard</span></td>
				</tr>
				<tr>
					<td colspan="100%" style="vertical-align: middle;"><g:submitButton
							name="submit" value="Search" /></td>
				</tr>
			</table>
		</g:form>
		<br />
		<br />
		<br />
		<br />
		
	   
	    
		    <table width="650" border="0" class="cpList">
                    <g:if test="${churchPlanterList}">                    								
						<tr>
							<g:sortableColumn colspan="2" property="firstName" title="${message(code: 'message.orgUser.churchPlanter.list.column.firstName')}" />
							<g:sortableColumn property="lastName" title="${message(code: 'message.orgUser.churchPlanter.list.column.lastName')}" />
							<g:sortableColumn property="state" title="${message(code: 'message.orgUser.churchPlanter.list.column.state')}" />
							<g:sortableColumn property="isPlanting" title="${message(code: 'message.orgUser.churchPlanter.list.column.isPlanting')}" />
							<g:sortableColumn property="cpcaCompletionDate" title="${message(code: 'message.orgUser.churchPlanter.list.column.status')}" />
							<g:sortableColumn property="registrationDate" title="${message(code: 'message.orgUser.churchPlanter.list.column.dateOfRegistration')}" />
							<g:sortableColumn property="organization" title="${message(code: 'message.orgUser.churchPlanter.list.column.organization')}" />			
						</tr> 
                    <g:each in="${churchPlanterList}" var="churchPlanter" status="counter">
	       	  		  	<tr class="category colorCol${(counter % 2) == 0?'':'2'}">
	       	  		  		<td><a href="${createLink(action:'showChurchPlanter',params:[id:churchPlanter.id])}"
							title="${churchPlanter.firstName} ${churchPlanter.lastName}"><img
							src="${resource(dir:'images',file:'view.png')}" border="0"
							alt="${churchPlanter.firstName} ${churchPlanter.lastName}"></a></td>
							<td>${churchPlanter.firstName}</td>
							<td>${churchPlanter.lastName}</td>	
							<td> ${churchPlanter.state}</td>
							<td><g:if test="${churchPlanter.isPlanting}"><img src="${resource(dir:'images',file:'leaf.png')}"></g:if><g:else>${message(code: 'message.orgUser.churchPlanter.list.column.notYet')}</g:else></td>
							<td><g:if test="${churchPlanter.cpcaCompletionDate}">${churchPlanter.cpcaCompletionDate.format('MM/dd/yy')}</g:if><g:else><img src="${resource(dir:'images',file:'false.png')}"></g:else></td>
							<td><g:if test="${churchPlanter.registrationDate}">${churchPlanter.registrationDate.format('MM/dd/yy')}</g:if><g:else>N/A</g:else></td>
						
							<td><a href="${createLink(controller:"home",action:'menu',id:churchPlanter.organization.id)}">${churchPlanter.organization.name}</a></td>
						</tr>
		   				</g:each>
					</g:if>
					<g:else><tr><td><i><g:message code="message.orgUser.churchPlanter.list.noplanters"/></i></td></tr></g:else>
	       		</table>
		 	 	<div class="paginate">
		 	 	<g:paginate next="Next " prev="Previous" max="10"	controller="organization" params="[id:params?.id]" action="churchPlanterList" total="${churchPlanterListSize}" /></div>
	    <div class="tdSep" style="clear:both;"></div>
        </div>
</body></html>