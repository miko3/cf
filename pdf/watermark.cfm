<!---
<cfpdf  action="getinfo"  name="setpdf" source="./cf.pdf">

    <cfdump  var="#setpdf#">

    <cfscript>
        setpdf = structNew();
        setpdf.title = "私の履歴書";
        setpdf.author = "岩井菫";
        setpdf.keywords = "履歴書.PDF,岩井菫"
        setpdf.subject = "履歴書PDFバージョン"
    </cfscript>

    <cfpdf  action="setinfo"  info="#setpdf#"  source="./cf.pdf" destination="./cfnew.pdf" overwrite="yes">

        <cfpdf  action="getinfo"  name="setpdfnew" source="./cfnew.pdf">
            <br>
            <cfdump  var="#setpdfnew#">
        --->

<cfpdf  action="thumbnail"  source="./cf.pdf" destination="./temp" format="png" imagePrefix="image"
overwrite="yes" resolution="high" scale="25" transparent="yes">

<cfdirectory  action="list" directory="C:\ColdFusion2021\cfusion\wwwroot\cf\pdf\temp\" name="ImgQry" filter="*.png">


<cfoutput query="ImgQry">
    <img src="temp/#imgQry.name#" border="1"><br><br>
</cfoutput>
