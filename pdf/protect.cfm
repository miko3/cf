<cfparam  name="Form.pw" default="" type="string">
<cfparam  name="Form.action_flg" default="false" type="boolean">


<cfif Form.action_flg and trim(Form.pw) neq "">

    <cfpdf  action="protect"  source="cf.pdf" newUserPassword="#Form.pw#" destination="./protect.pdf" encrypt="RC4_128" overwrite="yes">

        <cfoutput>
            <a href="./protect.pdf" target="_blank">パスワード保護したPDF</a>
        </cfoutput>

        <cfelse>

            <form action="protect.cfm" method="post">
                <input type="password" name="pw" size="30" maxlength="30">
                <input type="hidden" name="action_flg" value="true">
                <input type="submit" value="パスワードを設定">

            </form>
</cfif>