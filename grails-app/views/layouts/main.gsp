<%@ page import="com.lifeway.cpDomain.OrgUser" %>
<html>
    <head>
        <title><g:layoutTitle default="Grails" /></title>
         <g:javascript library='jquery' />
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css',absolute:true)}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico?',absolute:true)}" type="image/x-icon" />
        <meta http-equiv="expires" content="0">
        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="Content-Type" content="text/html;charset=utf-8">
        <meta charset="utf-8">
        <meta name="viewport" content="text/html; charset=utf-8;">
      
   
        
                <!-- #statistics_header# Begin-->
<script language="JavaScript" type="text/javascript">
<g:if env="development">
var arl="http://";
var sarl="https://";
var account="cpcadev";	
var tcenvironment="dev";
</g:if>
<g:elseif env="test">
var arl="http://";
var sarl="https://";
var account="cpcadev";	
var tcenvironment="test";
</g:elseif><g:else>
var account="cpcaprod";
var tcenvironment="com";
var arl="http://";
var sarl="https://";
</g:else>
var pageName = "<g:layoutTitle default="Grails" />";
var host=window.location.hostname;
	document.write('<sc'+'rip'+'t lan'+'guage="java'+'scr'+'ipt" type="te'+'xt/ja'+'vascri'+'pt" src="'+((location.protocol == 'http:')?arl:sarl)+'stats.lifeway.'+tcenvironment+'/header/?'+account+'"></scr'+'ipt>');
</script>
<!-- #statistics_header# End-->
<!-- #statistics_variables# Begin -->
<script type="text/javascript">
	objOmni.setVar('pageName', '${ layoutTitle(default:'CPCA page').toString().trim() }');
	objOmni.setVar("prop5", "churchPlanter page view");
	objOmni.setVar("channel", "churchPlanter");
</script>
<!-- #statistics_variables# End -->
        <g:layoutHead />
         <r:layoutResources/>
    </head>
    <body>
  
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif',absolute:true)}" alt="Spinner" />
        </div>
		<div id="grailsLogo" class="logo">
		<g:if test="${session.UserId}">
		<a href="${createLink(controller:"home",action:"menu",absolute:true)}">
		</g:if>
		<g:else>
		<a href="${createLink(controller:"churchPlanter",action:"menu",absolute:true)}">		
		</g:else>
		<img id="mainLogo" src="${resource(dir:'images',file:'logoHead.png',absolute:true)}"	alt="Church Planter Candidate Assessment" border="0" />
		</a>
		</div>
		<div id="mainBody">
	       <div id="nav">
				<div class="homePagePanel" >
				    <div class="panelBody">
					    <ul>
							<g:if test="${request.getSession(false)?.UserId}">
								<li><a href="${createLink(controller:"home",action:'menu')}"><g:message code="message.orgUser.menu.item.home"/></a></li>
								<li><a href="${createLink(controller:'organization', action:'churchPlanterList')}"><g:message code="message.orgUser.menu.item.churchPlanters"/></a></li>
								
								<g:if test="${request.getSession(false)?.hasAdminPrivileges}">
									<li><a href="${createLink(controller:'organization', action:'maintenance')}"><g:message code="message.orgUser.menu.item.maintenance"/></a></li>
								</g:if> 
								<g:if test="${OrgUser.get(request.getSession(false)?.UserId).organization.childOrganizations.size()>0 }">
									<li><a href="${createLink(controller:"organization",action:'subOrgList')}"><g:message code="message.orgUser.menu.item.subOrganizations"/></a></li>
								</g:if>
								<li><a href="${createLink(controller:"organization",action:'viewOrgUser',id:request.getSession(false)?.UserId)}"><g:message code="message.churchPlanter.menu.item.profile"/></a></li>
								<li><a href="${createLink(controller:'organization', action:'tutorials')}">${message(code: 'message.organization.menu.tutorials')}</a></li>
								
								<li><a href="${createLink(controller:"home",action:'logout')}"><g:message code="message.menu.item.logout"/></a></li>
	
							</g:if>
							<g:elseif test="${request.getSession(false)?.ChurchPlanterId}">
								<li><a href="${createLink(controller:"churchPlanter",action:'menu')}"><g:message code="message.churchPlanter.menu.item.menu"/></a></li>
								<li><a href="${createLink(controller:'churchPlanter', action:'myAccount')}"><g:message code="message.churchPlanter.menu.item.myAccount"/></a></li>
								<li><a href="${createLink(controller:'churchPlanter', action:'tutorials')}">${message(code: 'message.churchPlanter.menu.tutorials')}</a></li>
								<li><a href="${createLink(controller:'churchPlanter', action:'cpPreviewResource')}">${message(code: 'message.churchPlanter.menu.item.resources')}</a></li>
								<li><a href="${createLink(controller:"home",action:'logout')}"><g:message code="message.menu.item.logout"/></a></li>
							</g:elseif>
							<g:else>
								<li><a href="http://churchplanter.lifeway.com/"><g:message code="message.orgUser.menu.item.home"/></a></li>
							
								<!-- menu -->
							</g:else>	
						</ul>
				    </div>
				</div>
	       </div>
	
			
    <div id="pageContent">
	<div class="bodyTop"></div>
	<div class="mainBodyBG">
	    <g:layoutBody />
	</div>
	<div class="bodyBottom"></div>
    </div>
	    </div>
	    <div style="clear:both;"></div>
	    
    	<div id="footer"><g:message code="message.churchPlanter.template.footer" args="[new Date().format('yyyy'),grailsApplication.config.grails.marketingUrl]"/></div>
    
	    <div id="research"></div>
	    <div id="langBar">
	    	<div id="lang">
  				<g:if test="${params.token != null }">
  					<g:link controller="${controllerName}" action="${actionName}" params="[lang:'en_US',token:token]" id="${params.id}">english</g:link> | <g:link controller="${controllerName}" action="${actionName}" params="[lang:'es',token:token]" id="${params.id}">espa&ntilde;ol</g:link>
  				</g:if>
  				<g:else>
  					<g:link controller="${controllerName}" action="${actionName}" params="[lang:'en_US']" id="${params.id}">english</g:link> | <g:link controller="${controllerName}" action="${actionName}" params="[lang:'es']" id="${params.id}">espa&ntilde;ol</g:link>
  				</g:else>
	  			
  			</div>
  		 </div>

	    <div id="vines"><img src="${resource(dir:'images',file:'bannerVines.png',absolute:true)}" alt="Church Planter Candidate Assessment" border="0" /></div>
    <!-- #statistics_footer# Begin-->
<script language="JavaScript" type="text/javascript">
    document.write('<sc'+'rip'+'t lan'+'guage="java'+'scr'+'ipt" type="te'+'xt/ja'+'vascri'+'pt" src="'+((location.protocol == 'http:')?arl:sarl)+'stats.lifeway.'+tcenvironment+'/footer/"></scr'+'ipt>');
</script>

<!-- #statistics_footer# End-->
    <r:layoutResources/>
     
    </body>
</html>