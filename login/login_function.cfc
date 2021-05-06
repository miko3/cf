<cfcomponent>
    <!---ユーザ一覧--->
    <cffunction name="list" access="remote" returntype="query">     
		<cfquery name="userlist" datasource="sample" result="tmpResult"> 
		    SELECT *
		    FROM accounttable 
		</cfquery>
        <cfreturn userlist>    
    </cffunction>


    <!---ログイン機能--->
    <cffunction  name="login" access="remote" returntype="struct">

    <cfargument  name="username" type="string" required="true">
    <cfargument  name="password" type="string" required="true">
    <cfargument  name="rememberme" type="numeric" required="false">

    <cflock  timeout="10" scope="session" type="exclusive">
        <cfset structDelete(session, "username")>
    </cflock>

        <cfquery name="logintest" datasource="sample">
        select *
        from accounttable
        where username= '#arguments.username#'
        </cfquery>

        <cfset r = structNew()>
        <cfset r.result = false>
        <cfset r.message = "">
        <cfset r.note = "">

        <cfif not logintest.recordcount gt 0>
            
            <cfset r.message = "失敗">

            <cfelse>

                <cfif compare(arguments.password, decrypt(logintest.password, "aaa")) is 0>
                    <!---パスワードもユーザ名も一致したとき--->
                    <cfset r.result = true>
                    <cfset r.message = "成功">
                    <cfset r.note = "">

                    <cfif lsIsDate(logintest.lastlogin)><!---1回でもログインしたことがあれば--->
                        <cfset r.note = "前回のログインは#lsDateTimeFormat(logintest.lastlogin,"YYYY/mm/dd HH:SS:MM")#でした。">
                    </cfif>
                    <cfif logintest.lastfailedcount gt 0><!---1回でもログインに失敗したことがあれば--->
                        <cfset r.note = 
                        "以前のログインから#logintest.lastfailedcount#回ログインに失敗しています。
                        最後にログインを失敗したときのIPアドレスは#logintest.lastfailedip#。
                        前回のログインは#lsDateTimeFormat(logintest.lastlogin,"YYYY/mm/dd HH:SS:MM")#でした。"> 
                    </cfif>

                    <cfquery datasource="sample" name="okupdate">
                    update accounttable set
                        lastip = '#cgi.remote_addr#',
                        lastlogin = '#dateFormat(now(),"yyyy/mm/dd HH:mm:ss")#',
                        totallogins = #logintest.totallogins+1#,
                        lasstsessionid = '#session.sessionid#',
                        lastfailedcount = 0,
                        rememberme = #arguments.rememberme#
                        where
                        username = '#arguments.username#'
                    </cfquery>

                    <cflock  timeout="10" scope="session" type="exclusive">
                        <cfset session.username = arguments.username>
                    </cflock>

                    <cfif arguments.rememberme is 1><!---情報を覚えておくにチェック--->
                        <cfcookie  name="un" value="#arguments.username#" expires="90">
                        <cfcookie  name="si" value="#session.sessionid#" expires="90">
                        <cfelse>
                            <!---nowはcookieをブラウザから消去する--->
                        <cfcookie  name="un" value="" expires="now">
                        <cfcookie  name="si" value="" expires="now">

                    </cfif>

                <cfelse>

                    <cfset r.message = "失敗">
                    <cfset r.note = "ログイン失敗の情報を更新。">

                    <cfquery datasource="sample" name="ngupdate">
                        update accounttable set
                                lastfailedcount = <cfqueryparam cfsqltype="cf_sql_integer" value="#logintest.lastfailedcount+1#">,
                                lastfailedip = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cgi.remote_addr#" maxlength="20">,
                                lastfailedlogin = <cfqueryparam cfsqltype="cf_sql_timestamp"
                                value="#dateFormat(now(),"yyyy/mm/dd HH:mm:ss")#">
                                where
                                username = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.username#" maxlength="20">
                    </cfquery>

                </cfif>
        </cfif>
        <cfreturn r>
    </cffunction>



    <!---ユーザの追加--->
    <cffunction  name="createuser" access="remote" returntype="string">
        <cfargument  name="username" type="string" required="true">
        <cfargument  name="password" type="string" required="true">
    
    <cfquery datasource="sample" name="adduserck">
    select *
    from accounttable
    where username = '#arguments.username#'
    </cfquery>

    <cfif adduserck.recordcount gt 0>
        <cfset message = "#arguments.username#様は既に存在しているため登録できません">
        <cfelse>

        <cfquery datasource="sample" name="useradd">
        insert into accounttable values (
            '#arguments.username#', '#encrypt(arguments.password, "aaa")#',null,null,null,0,0,null,0,null
        )
        </cfquery>
        <cfset message = "#arguments.username#様を追加しました">
    </cfif>
    <cfreturn message>
</cffunction>


<!---ユーザの消去機能--->
<cffunction  name="delete" access="public" output="no">
    <cfargument  name="selection" type="string" required="true">
    <cfquery datasource="sample" name="userdelete">
    delete from accounttable
    where username in ('#arguments.selection#')
    </cfquery>
    <cfset message = "#arguments.selection#を消去しました">
    <cfreturn message>
</cffunction>


<!---自動ログイン--->
<cffunction  name="autologin" access="public" returntype="boolean" output="yes">
    <cfset ret = false>

    <!---rememberme1にしていたときcookieを入れた--->
    <cfif isDefined("cookie.un") and isDefined("cookie.si")>
        <cfquery datasource="sample" name="ck">
        select lasstsessionid from accounttable
        where (
            rememberme = 1 and username = '#cookie.un#'
        )
        </cfquery>
        <cfif ck.recordcount gt 0>
            <cfif compareNoCase(ck.lasstsessionid, cookie.si) is 0>
                <cfset ret = true>
                <cflock  timeout="10" scope="session" type="exclusive">
                    <cfset session.username = #cookie.un#>
                </cflock>
            </cfif>
        </cfif>
    </cfif>
    <cfreturn ret>
</cffunction>


<!---ログアウト機能--->
<cffunction  name="logout" access="public" output="no">
    <cflogout>
    <cflocation  url="./login.cfm">
</cffunction>



<!---cookieの消去機能--->
<cffunction  name="forget" access="public" output="no" returntype="string">
    <cfif isDefined("session.username")>
        <cfquery datasource="sample" name="forget">
        update accounttable set
        rememberme = 0
        where username = '#session.username#'
        </cfquery>
        <cfcookie  name="un" value="" expires="now">
        <cfcookie  name="un" value="" expires="now">
    </cfif>
    <cfset message = "remembermeを0にしました">
    <cfreturn message>
</cffunction>

</cfcomponent>