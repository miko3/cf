<cfoutput>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="content-style-type" content="text/css">
  <meta http-equiv="content-script-type" content="text/javascript">
  <meta name="robots" content="noindex,nofollow,noarchive">
  <title>debug learning</title>
</head>

<body>

  <h1>debug learning</h1>

  <a href="index.cfm">もどる</a>

  <h2>post/get results</h2>

  <h3>form</h3>
  <cfdump var="#form#">

  <h3>url</h3>
  <cfdump var="#url#">

  <h3>request</h3>
  <cfdump var="#request#">

</body>
</html>
</cfoutput>
