<h2>ログイン成功</h2>

<cfinvoke component="login_function" method="list" returnVariable="userlist">

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



    <!---ユーザ追加のデータ渡す--->
    <cfif isDefined("form.action") and form.action is "add">
        <cfinvoke  method="createuser" component="login_function" returnvariable="adduser">
            <cfinvokeargument  name="username"  value="#form.username#">
            <cfinvokeargument  name="password"  value="#form.password#">  
        </cfinvoke>
        <cfoutput></cfoutput>     
    </cfif>

    <h2>ユーザの追加</h2>

    <form action="<cfoutput>#cgi.script_name#</cfoutput>" method="post">
        <input type="hidden" name="action" value="add">
        <div class="heading">ユーザー名の追加</div><br>
        ユーザー名：<input type="text" name="username" size="20"><br>
        パスワード：<input type="password" name="password" size="20"><br>
        <input type="submit" value="追加">
    </form>