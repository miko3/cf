/*
<cfcomponent>

    <!---application名以外はデフォルト--->
    <cfset This.name = "MyApp">

  

    <!---cfmページが呼ばれたときに最初に必ず--->
    <cffunction name="onRequestStart">

        <cfset request.mySt = "hoge">
     
 

    </cffunction>

</cfcomponent>
*/



component {

    this.name = "MyApp";
  
    public void function onRequestStart() {
  

        var request.mySt = "hoge";
  
    }
  
  }