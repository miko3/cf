<!DOCTYPE html>

<!---cfparmは変更しない変数--->
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login</title>
</head>
<body>

   

    <cflock  timeout="10" scope="application">
        <cfset dsn = application.dsn>
    </cflock>


    <cfif isDefined("form.username") and isDefined("form.password")>
        <cfparam  name="result" default="false">
    
        <cflock timeout="10" scope="session" type="exclusive">
            <!---排他的--->
            <cfset structDelete(session, "username" )>
                <!---とりあえずセッションは消す--->
        </cflock>
        <!---q1はuser名が一致したもの--->

        
        <cftransaction>

            <cfquery name="q1" datasource="dsn">
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
                        <cfquery name="q2" datasource="dsn">
                            update accounttable set
                            lastip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.remote_addr#" maxlength="20">,
                            lastlogin = <cfqueryparam cfsqltype="cf_sql_timestamp" value="#dateFormat(now(),"yyyy/mm/dd")# #timeFormat(now(),"HH:mm:ss")#">,
                            totallogins = <cfqueryparam cfsqltype="cf_sql_integer" value="#q1.totallogins+1#">,
                            lasstsessionid = <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.sessionid#" maxlength="100">,
                            lastfailedcount=0,
                            rememberme = #iIf(isDefined("form.rememberme"), 1, 0)#
                            where
                            username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.username#" maxlength="20">
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
                        <cfset result = true>


                        <cfelse>

                           

                            パスワードが不一致

                          

                            <!---ログインが失敗した時にセッション情報を書き換える--->
                            <cfquery name="q3" datasource="dsn">
                                update accounttable set
                                lastfailedcount = <cfqueryparam cfsqltype="cf_sql_integer" value="#q1.lastfailedcount+1#">,
                                lastfailedip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.remote_addr#" maxlength="20">,
                                lastfailedlogin = <cfqueryparam cfsqltype="cf_sql_timestamp"
                                value="#dateFormat(now()," yyyy/mm/dd")# #timeFormat(now(),"HH:mm:ss")#">
                                where
                                username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.username#" maxlength="20">
                            </cfquery>

                    </cfif>
            </cfif>
        </cftransaction>

        <cfif result and isDefined("session.prev_page")>
            <cfset page = session.prev_page>
            <cflock  timeout="10" scope="session" type="exclusive">
                <cfset structDelete(session, "prev_page")>
            </cflock>
            <cflocation  url="#page#" addtoken="no">
        </cfif>
    </cfif>

    <cfform action="#cgi.script_name#" method="post">
        ユーザ名：<cfinput  name="username" type="text" size="20" required="yes" message="ユーザ名を入れてください"><br>
        パスワード<cfinput  name="password" type="text" size="20"><br>
        ログイン情報を覚えておく<cfinput  name="rememberme" type="checkbox" ><br>
        <input type="submit" value="ログイン">
    </cfform>
        
    </body>
</html>