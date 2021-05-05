<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="./css/style.css">
    <script src="./script/form.js"></script>
</head>

<body>

    <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">
        <input type="hidden" name="action" value="">
        <input type="submit" value="再投影">
    </form>
    <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">
        <input type="hidden" name="action" value="test"><br>
        <div>ログイン確認</div>
        ユーザー名：<input type="text" name="username" size="20"><br>
        パスワード：<input type="password" name="password" size="20"><br>
        ログイン保持<input type="checkbox" name="rememberme"><br>
        <input type="submit" value="テスト">
    </form>

    <!---ここから認証コード--->

    <cfif isDefined("form.action") and form.action is "test">



        <cflock timeout="10" scope="session" type="exclusive">
            <!---排他的--->
            <cfset structDelete(session, "username" )>
                <!---とりあえずセッションは消す--->
        </cflock>
        <!---q1はuser名が一致したもの--->


        <cftransaction>

            <cfquery name="q1" datasource="sample">
                select *
                from accounttable
                where
                username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.username#" maxlength="20">
            </cfquery>



            <cfif not q1.recordcount gt 0>
                <!---ログインuser名がなかった時--->
                そのユーザ名は登録がありません＜ログイン失敗＞


                <cfelse>
                    <!---ユーザ名があったとき--->
                    <!---1と2が等しい場合0--->
                    <cfif form.password eq decrypt(q1.password, "aaa" )>

                        <cfoutput>#form.password#
                            #decrypt(q1.password, "aaa" )#
                        </cfoutput>

                        <p>
                            <cfif lsIsDate(q1.lastlogin)>
                                前回のログインは <cfoutput>#lsDateTimeFormat(q1.lastlogin,"LONG")#でした</cfoutput>
                            </cfif>
                        </p>

                        <!---失敗したことが１回以上あるなら--->
                        <cfif q1.lastfailedcount gt 0>
                            <div class="meaage">
                                <cfoutput>
                                    以前のログインから#q1.lastfailedcount#回ログインに失敗しています。<br>
                                    最後にログインを失敗したときのIPアドレスは#q1.lastfailedip#。<br>
                                    <cfif lsIsDate(q1.lastfailedlogin)>
                                        日時は#lsDateTimeFormat(q1.lastfailedlogin,"LONG")#でした。
                                    </cfif>
                                </cfoutput>
                        </cfif>

                        <!---ユーザ名が一致した人のログインチャレンジの上書き--->
                        <!---lasttip = ipアドレス--->
                        <!---iIf 式に一致したら、1、違えば0を返す--->
                        <cfquery name="q2" datasource="sample">
                            update accounttable set
                            lastip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.remote_addr#" maxlength="20">,
                                lastlogin = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateFormat(now(),"
                                    yyyy/mm/dd")# #timeFormat(now(),"HH:mm:ss")#">,
                                    totallogins = <cfqueryparam cfsqltype="cf_sql_integer" value="#q1.totallogins+1#">,
                                        lasstsessionid = <cfqueryparam cfsqltype="cf_sql_varchar"
                                            value="#session.sessionid#" maxlength="100">,
                                            lastfailedcount=0,
                                            rememberme = #iIf(isDefined("form.rememberme"), 1, 0)#
                                            where
                                            username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.username#"
                                                maxlength="20">
                        </cfquery>

                        </div>


                        <cflock timeout="10" scope="session" type="exclusive">
                            <cfset session.username="#form.username#">
                        </cflock>
                        <!---ログイン保持情報を持っていたら--->
                        <cfif isDefined(1)>
                            <cfcookie name="un" value="#form.username#" expires="90">
                                <cfcookie name="si" value="#session.sessionid#" expires="90">
                                    <cfelse>
                                        <cfcookie name="un" value="" expires="now">
                                            <cfcookie name="si" value="" expires="now">
                        </cfif>


                        <cfelse>

                            <div class="message">

                                パスワードが不一致

                            </div>

                            <!---ログインが失敗した時にセッション情報を書き換える--->
                            <cfquery name="q3" datasource="sample">
                                update accounttable set
                                lastfailedcount = <cfqueryparam cfsqltype="cf_sql_integer"
                                    value="#q1.lastfailedcount+1#">,
                                    lastfailedip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.remote_addr#"
                                        maxlength="20">,
                                        lastfailedlogin = <cfqueryparam cfsqltype="cf_sql_timestamp"
                                            value="#dateFormat(now()," yyyy/mm/dd")# #timeFormat(now(),"HH:mm:ss")#">
                                            where
                                            username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.username#"
                                                maxlength="20">
                            </cfquery>

                    </cfif>
            </cfif>
        </cftransaction>
    </cfif>

    <cfquery datasource="sample" name="q">
        select *
        from accounttable
    </cfquery>

    <form name="frm" action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">
        <input type="hidden" name="action2" value="delete">
        <table border="1">
            <tr>
                <th>
                    <input type="checkbox" name="allcheck" onClick="checkAll()" onCange="checkAll()">
                </th>
                <th>
                    ユーザ名
                </th>
                <th>
                    最後のログイン時間
                </th>
                <th>
                    ログイン回数
                </th>
                <th>
                    アクセス元IP
                </th>
            </tr>
            <cfoutput query="q">
                <cfif lsIsDate(lastlogin)>
                    <td>
                        <input type="checkbox" name="selection" value="#username#">
                    </td>
                    <td>
                        #username#
                    </td>
                    <td>
                        #lsDateFormat(lastlogin)#
                    </td>
                    <td>
                        #totallogins#
                    </td>
                    <td>
                        #lastip#
                    </td>
                    </tr>
                </cfif>
            </cfoutput>
        </table>
        <br>
        <input type="submit" value="選択したユーザの消去">
    </form>



    <!---消去する作業--->
    <!---actionがあるformが送信されて、それがdeleteで、チャックボックスにチェックがあったとき--->
    <cfif isDefined("form.action2") and form.action2 is "delete" and isDefined("form.selection")>

        <cfquery datasource="sample" name="delete">
            delete from accounttable
            where username =

            <cfloop index="v" list="#form.selection#">
                <cfqueryparam value="#v#" cfsqltype="cf_sql_varchar">
                    <cfif #listLast("form.selection")# is not #v#>,

                    </cfif>
            </cfloop>

        </cfquery>
    </cfif>
    <br>
    <cfdump var="#session#">
        <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">
            <input type="hidden" name="action" value="logout">
            <input type="submit" value="ログアウト">
        </form>

        <cfif isDefined("form.action") and form.action is "logout">
            <cflock timeout="10" scope="session" type="exclusive">
                <cfset structDelete(session, "username" )>
                    <!---正常に消去されたらture--->
            </cflock>
        </cfif>

        <br>
        <br>

        <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">
            <input type="hidden" name="action" value="forget">
            <input type="submit" value="remembermeを外す">
        </form>

        <cfif isDefined("form.action") and form.action is "forget" and isDefined("session.username")>
            <cfquery datasource="sample">
                update accounttable set
                rememberme = 0
                where
                username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.username#">
            </cfquery>

            <cfcookie name="un" expires="now">
                <cfcookie name="si" expires="now">
        </cfif>
</body>

</html>