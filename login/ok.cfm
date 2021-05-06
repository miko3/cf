<h2>ログイン成功</h2>

<cfinvoke component="login_function" method="list" returnVariable="userlist">

    <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">
    <input type="hidden" name="action" value="delete">

    <table border="1">
        <tr>
            <th>
                <input type="checkbox" name="allcheck">
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
        <cfoutput query="userlist">
            <td>
                <input type="checkbox" name="selection" value="#username#">
            </td>
            <td>
                #username#
            </td>
            <td>
                #lastlogin#
            </td>
            <td>
                #totallogins#
            </td>
            <td>
                #lastip#
            </td>
            </tr>

        </cfoutput>
    </table>

    <br>


    <!---ユーザ消去--->
    <input type="submit" value="チェックしたユーザの消去">
    </form>

    <cfif isDefined("form.action") and form.action is "delete">
        <cfinvoke  method="delete" component="login_function" returnvariable="message">
            <cfinvokeargument  name="selection"  value="#form.selection#">
        </cfinvoke>
        <cfoutput>#message#</cfoutput>     
    </cfif>
    


    <!---ユーザ追加のデータ渡す--->
    <cfif isDefined("form.action") and form.action is "add">
        <cfinvoke  method="createuser" component="login_function" returnvariable="message">
            <cfinvokeargument  name="username"  value="#form.username#">
            <cfinvokeargument  name="password"  value="#form.password#">  
        </cfinvoke>
        <cfoutput>#message#</cfoutput>     
    </cfif>

    <h2>ユーザの追加</h2>

    <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">
        <input type="hidden" name="action" value="add">
        ユーザー名：<input type="text" name="username" size="20"><br>
        パスワード：<input type="password" name="password" size="20"><br>
        <input type="submit" value="追加">
    </form>




    
    <!---ログアウト--->
    <cfif isDefined("form.action") and form.action is "logout">
        <cfinvoke  method="logout" component="login_function">
        </cfinvoke>
    </cfif>

    <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">
        <input type="hidden" name="action" value="logout">
        <input type="submit" value="ログアウト">
    </form>

