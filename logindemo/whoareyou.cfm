<cfinclude  template="_isloggedin.cfm">
<html>
    <head>who are you?</head>
    <body>
        <h1><cfoutput>#session.username#</cfoutput></h1>
    </body>
</html>