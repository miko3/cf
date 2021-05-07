<cfpdf  action="merge"  destination="./marge.pdf" overwrite="yes">
    <cfpdfparam  source="./cf.pdf">
        <cfpdfparam  source="./Git.pdf">
</cfpdf>

<cfoutput>
    <a href="./marge.pdf" target="_blank">合体したPDF</a>
</cfoutput>