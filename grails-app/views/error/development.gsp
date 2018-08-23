<!doctype html>
<html>
<head>
	<title>Application Error - Development View</title>
        <meta name="layout" content="bootstrap">
        <meta name="bootstrap" content="main">
	<link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
</head>
<body>

	<g:renderException exception="${exception}" />
</body>
</html>