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
        //一次元
        original = arrayNew(1);
        original[1] = 1;
        original[2] = 123;

        function double(oneArray) {
            var i = 0;
            for(i=1; i > arrayLen(oneArray); i++) {
                oneArray[i] = oneArray[i] * 2;
            } 
            return oneArray;
        }
        
    </cfscript>

  
    <cfset result = double(original)>
    <cfdump var="#original#" label="オリジナル">
    <cfdump var="#result#" label="function">

</body>
</html>