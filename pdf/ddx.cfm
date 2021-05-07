<cfprocessingdirective pageencoding="utf-8">

<cfif isDDX("book.ddx")>
    <cfset inputStruct = structNew()>
    <cfset inputStruct.Doc1 = "cf.pdf">

    <cfset outputStruct = structNew()>
    <cfset outputStruct.Out1 = "ddx_cf.pdf">

    <cfpdf  action="processddx"  ddxfile="book.ddx" inputfiles="#inputStruct#" outputFiles="#outputStruct#" name="ddxVar">
    <cfoutput>#ddxVar.Out1#</cfoutput>
    
<cfelse>

    <cfoutput>無効なDDxです
    </cfoutput>

</cfif>