<cfparam  name="dsn" default="sample">
<!---cfparmは変更しない変数--->

<cfquery datasource="#dsn#" name="q">
    select *
    from accounttable
</cfquery>

<cfdump  var="#q#" label="全件">

<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>

<form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">
    <input type="hidden" name="action" value="add">
    <div class="heading">ユーザー名の追加</div><br>
    ユーザー名：<input type="text" name="username" size="20"><br>
    パスワード：<input type="password" name="password" size="20"><br>
    <input type="submit" value="追加">
</form>




<!---追加する処理--->
<cfif isDefined("form.action") and form.action is "add"><!---追加すると受け取ったら--->
    <cfdump  var="#form#" label="formの中身">
    <cftrace var="form.action">
        <cftransaction><!---1つにまとめる--->
            <cfquery name="q2" datasource="#dsn#">
            select username
            from accounttable
            where username = <cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
            </cfquery>

            <cfdump  var="#q2.username#" label="一致したものがあったときの中身">

            <cftrace var="q2.recordcount">

                <cfif q2.recordcount gt 0>
                    そのユーザは既に存在します
                    <cfelse>
                        <cfquery datasource="#dsn#" name="q3">
                        insert into accounttable
                        values
                        (
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.username#">,
                            <cfqueryparam cfsqltype="cf_sql_varchar" value="#encrypt(form.password,"aaa")#">,
                            null,null,null,0,0,null,0,null

                        )
                        </cfquery>

                
                </cfif>
        </cftransaction>
        
</cfif>

</body>
</html>