<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

    <h2>構造体</h2>

    <cfscript>
        //argの中にkeyがある間、arg配列に大文字を入れます
        function create(arg) {
            for(key in arg) {
                arg[key] = uCase(arg[key]);
            }
            //return 0;
        }
    </cfscript>

    <cfscript>
        //構造体
        mystr = structNew();
        mystr.fname = "iwai";
        mystr.lname = "sumire";
    </cfscript>

    <cfdump var="#mystr#">

    <cfscript>create(mystr)</cfscript>

    <cfdump var = "#mystr#">

    <cfset arg="create(mystr)">


</body>
</html>