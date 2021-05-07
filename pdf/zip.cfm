
<cfparam  name="form.img_king" default="" type="string">
<cfparam  name="form.img_type" default="" type="string">
<cfparam  name="form.download_flg" default="false" type="boolean">


<!---ボタンを押した後の処理--->


<cfif form.download_flg>

    <cfdump  var="#form#">

<cfif form.img_king neq "" and form.img_type neq "">
   
    <cfzip file="C:\ColdFusion2021\cfusion\wwwroot\cf\pdf\temp\download.zip" overwrite="yes">
        <cfzipparam source="C:\ColdFusion2021\cfusion\wwwroot\cf\pdf\img/#form.img_king#.#form.img_type#">
    </cfzip>

    <cfelseif form.img_king neq "">
        <cfzip file="C:\ColdFusion2021\cfusion\wwwroot\cf\pdf\temp\download.zip" overwrite="yes" source="C:\ColdFusion2021\cfusion\wwwroot\cf\pdf\img" filter="#form.img_kind#.*"/>
    
    <cfelseif form.img_type neq "">
        <cfzip file="C:\ColdFusion2021\cfusion\wwwroot\cf\pdf\temp\download.zip" overwrite="yes" source="C:\ColdFusion2021\cfusion\wwwroot\cf\pdf\img" filter="*.#form.img_type#."/>
    
    <cfelse>
        <cfzip file="C:\ColdFusion2021\cfusion\wwwroot\cf\pdf\temp\download.zip" overwrite="yes" source="C:\ColdFusion2021\cfusion\wwwroot\cf\pdf\img" filter="*.bmp,*.jpg,*.png"/>

</cfif>



<!---form--->
<cfoutput>
    <form action="zip.cfm" method="post">
        ダウンロードしたいものを選んでください
        <br>
        <select name="img_king">
            <option value="">全て</option>
            <option value="cf8">ColdFusion8</option>
            <option value="adobe">Adobe</option>
            <option value="sier">sier</option>
        </select>
        <br><br>
        画像形式を選んでください<br>
        <select name="img_type">
            <option value="">全て</option>
            <option value="bmp">BMP</option>
            <option value="jpg">jpg</option>
            <option value="png">png</option>
        </select><br><br>

        <input type="hidden" name="download_flg" value="true">
        <input type="submit" value="選んだ画像をダウンロードする">
    </form>
</cfoutput>

</cfif>