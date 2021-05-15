<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <cfscript>
        function double(x) {
            arguments.x = arguments.x * 2;
            return arguments.x;
        }
    </cfscript>

    <cfscript>
        function double2(y) {
            y = y * 2;
            return y;
        }
    </cfscript>

    <cfset x = 10>
    <cfoutput>#x#</cfoutput>
    <cfoutput>#double(x)#</cfoutput>
    <cfoutput>#x#</cfoutput>
<br>
    <cfset y = 10>
    <cfoutput>#y#</cfoutput>
    <cfoutput>#double(y)#</cfoutput>
    <cfoutput>#y#</cfoutput>
</body>
</html>