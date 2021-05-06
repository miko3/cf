<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ログイン</title>
</head>
<body>
    <cfif isDefined("form.username") and isDefined("form.password")>
        <!---コンポーネントを使う--->
        <cfinvoke  method="login" component="login_function" returnVariable="r">
        <cfinvokeargument  name="username"  value="#form.username#">
        <cfinvokeargument  name="password"  value="#form.password#">
        <cfinvokeargument  name="rememberme"  value="#iIf(isDefined("form.rememberme"),1,0)#"/>
        </cfinvoke>

    <cfif r.result EQ true>
        <cflocation  url="./ok.cfm" addtoken="no">
    </cfif>
    <cfoutput>ログイン#r.message#です。</cfoutput>
    <cfoutput>#r.note#</cfoutput>
    </cfif>

    <h2>ログイン</h2>
    <cfform action="#cgi.script_name#" method="post">
        ユーザー名:<cfinput type="text" name="username" size="20"><br>
        パスワード:<cfinput type="password" name="password" size="20"><br>
        ログイン情報を覚えておく<cfinput type="checkbox" name="rememberme"><br>
        <input type="hidden" value="logintest">
        <input  type="submit">
    </cfform>

    
   
</body>
</html>