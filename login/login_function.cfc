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

    <cfdump  var="#arguments.username#">
    
        <cfquery name="logintest" datasource="sample">
        select *
        from accounttable
        where username= '#arguments.username#'
        </cfquery>

        <cfset r = structNew()>
        <cfset r.result = false>
        <cfset r.message = "">
        <cfset r.note = "">

<!---       <cfif not logintest.recordcount gt 0>--->
        <cfif not logintest.recordcount>
            
            <cfset r.message = "失敗">
            <cfelse>
                <cfif compare(arguments.password, decrypt(logintest.password, "aaa")) is 0>
                    <cfset r.result = true>
                    <cfset r.message = "成功">
                    <cfset r.note = "">

                    <cfelse>

                    <cfset r.message = "失敗">
                    <cfset r.note = "">

                </cfif>
        </cfif>
        <cfreturn r>
    </cffunction>

    <cffunction  name="createuser" access="remote" returntype="string">
        <cfargument  name="username" type="string" required="true">
        <cfargument  name="password" type="string" required="true">
    
    <cfquery datasource="sample" name="adduserck">
    select *
    from accounttable
    where username = '#arguments.username#'
    </cfquery>

    <cfif adduserck.recordcount gt 0>
        <cfset message = "そのユーザは既に存在しているため登録できません">
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

</cfcomponent>