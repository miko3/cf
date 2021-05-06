<cfinvoke component="login_function" method="autologin" returnVariable="ret">
</cfinvoke>

<!---ログインが成功したときにsession.usernameにusernameを入れている--->
<cfif isDefined("session.username") is false>
    <cflock  timeout="10" scope="session" type="exclusive">
        <cfset session.prev_page = #cgi.script_name#>
    </cflock>
    <cflocation  url="./login.cfm" addtoken="no">
</cfif>