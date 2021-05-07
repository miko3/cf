<!DOCTYPE html>
<html lang="ja">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

</head>

<body>
    <h2>交通費申請</h2>

    <cfif Form.action_flg>
        <!---
        <cfpdfform  action="populate"  source="cf.pdf" destination="./add_shinsei.pdf" overwrite="yes">
            <cfpdfsubform  name="form1">
                <cfpdfformparam  name="ArrivalField"  value="#form.DateField#">
            </cfpdfsubform>
        </cfpdfform>
    --->
    </cfif>

    <cfform action="pdfform.cfm" method="post">
        利用日：<input type="text" name="DateField" size="30" value="#Form.DateField#"><br>
        出発駅:<input type="text" name="DepartureField" size="30"><br>
        到着駅:<input type="text" name="ArribalField" size="30"><br>
        利用目的:<input type="text" name="PurposeField" size="30"><br>
        金額：<input type="text" name="PriceField" size="30"><br>
        氏名：<input type="text" name="NameField" size="30"><br>
        部署：<input type="text" name="PostField" size="30"><br>
        <input type="submit" value="pdf作成">
        <input type="hidden" name="action_flg" value="true">
    </cfform>

</body>

</html>