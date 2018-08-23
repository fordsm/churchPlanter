<div class="portalBox">
				<g:if test="${orgResourceInstance.logoURL}">
				 <img src="${fieldValue(bean: orgResourceInstance, field: "logoURL")}"  border="0"/>	
				</g:if>
<g:if test="${orgResourceInstance.resourceURLs}">
	<div class="orgUrls">
        <h2><g:message code="message.churchPlanter.previewResource.resourceUrls"/>:</h2>
        <ul>
		<g:each	in="${orgResourceInstance.resourceURLs.sort{a,b-> a.displayText.compareTo(b.displayText)}}" status="i" var="resourceURLInstance">
			<li>
			<a target="_blank" href="${fieldValue(bean: resourceURLInstance, field: "url")}">${fieldValue(bean: resourceURLInstance, field: "displayText")}</a>	
			</li>
		</g:each>
		</ul>
	</div>
</g:if>
</div>


<div style="height:400px;">

<h1><g:message code="message.churchPlanter.menu.resources" /></h1>
<h2 style="font-size:24px;">${orgResourceInstance.organization.name}</h2>
<g:message code="message.churchPlanter.previewResource.website" />:	<a href="${orgResourceInstance.organization.webPage}" target="_blank">${orgResourceInstance.organization.webPage}</a><br/>
		<br><div class='resourceText'>
			${orgResourceInstance.resourceText}
		</div>
</div>			

