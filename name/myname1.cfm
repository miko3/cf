<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <cffunction name="myname">
        <cfargument name="fName">
        <cfargument name="lName">
        <cfset retval = fName & lName & "です">
        <cfreturn retval>
    </cffunction>

    <cfoutput>#myname("岩井","すみれ")#</cfoutput>
    
</body>
</html>