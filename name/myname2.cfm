<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <cfprocessingdirective pageencoding="UTF-8">

    <cfscript>
       
        function myname(lname,fname) {
            retval = lname & fname;
            return retval;
        }
    </cfscript>

    <cfoutput>#myname("岩井","菫")#</cfoutput>
    
</body>
</html>