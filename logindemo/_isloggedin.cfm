<cflock  timeout="10" scope="application">
    <cfset dsn = application.dsn><!---アプリケーションスコープ--->
</cflock>

<cfif isDefined("session.username") is false and (isDefined("cookie.un") and isDefined("cookie.si"))>
    <cfquery datasource="sample" name="co">
    select lasstsessionid 
    from accounttable
    where
    (rememberme = 1 and username = <cfqueryparam value="#urldecode(cookie.un,"UTF-8")#">)
    </cfquery>

    <cfif co.revordcount gt 0>
        <!---大文字と小文字を区別しないで比較--->
        <cfif compareNoCase(co.lasstsessionid, cookie.si) is 0>
            <cfset session.username = #urldecode(cookie.un,"UTF-8")#>
        </cfif>
    </cfif>
</cfif>

<cfif isDefined("session.username") is false>
    <cflock  timeout="10" scope="session" type="exclusive">
        <cfset session.prev_page = #cgi.script_name#>
    </cflock>
    <cflocation  url="./login.cfm">
</cfif>
