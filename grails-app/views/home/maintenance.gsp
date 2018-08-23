
<html>
<head>
<title>Maintenance</title>
<meta name="layout" content="main" />
<link rel="stylesheet" href="${resource(dir:'css',file:'styles.css')}" />

</head>
<body>

<div class="nav">
	<span class="menuButton">
	<a class="home" href="${createLink(uri: '/home/choose')}">Home</a>	
	<a class="logout" href="${createLink(uri: '/home/logout')}">Logout</a>
	</span>
</div>

<center>
<div style="width: 60%;">
<h1></h1>
<g:if test="${flash.message}">
	<div class="message">
	${flash.message}
	</div>
</g:if>
<div class="dialog">
<table>
	<tbody>
		<tr>
			<g:if test="${orguser.hasAdminPrivileges}">
				<td width="33%" align="center">
				<div class="choose" align="center" style="text-align: center;">
					<a href="${createLink(controller:'orgUser', action:'list')}">
						Users
					</a></div>
				</td>
				<td width="33%"  align="center">
				<div class="choose" align="center" style="text-align: center;">
					<a href="${createLink(controller:'resource', action:'list')}">
						Resources
					</a>
				</div>
				</td>							
			</g:if>
		</tr>
	</tbody>
</table>
</div>

</div>
</center>
</body>
</html>