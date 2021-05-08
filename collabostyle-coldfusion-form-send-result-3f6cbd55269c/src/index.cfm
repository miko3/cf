<cfoutput>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="content-style-type" content="text/css">
  <meta http-equiv="content-script-type" content="text/javascript">
  <meta name="robots" content="noindex,nofollow,noarchive">
  <script>
    function sendForm(method) {
      const f = document.getElementById('testForm');
      f.method = method;
      f.submit();
    }
  </script>
  <title>debug learning</title>
</head>

<body>
  <h1>debug learning</h1>

  <h2>send</h2>
  <form id="testForm" action="result.cfm">

      <input type="button" value="get" onclick="sendForm('get')">
      <br />
      <input type="button" value="post" onclick="sendForm('post')">
      <br />
      <br />
      <input type="text" name="id" value="id"/>
      <br />
      <div>
        <input type="password" name="password" size="30" maxlength="30">
      </div>

      <div>
        <input type="tel" name="te1" size="15" maxlength="15">
      </div>

      <div>
        <input type="url" name="url" size="40" placeholder="http://www.example.com/">
      </div>

      <div>
        <input type="email" name="email" size="30" maxlength="50">
      </div>

      <div>
        <input type="search" name="search" size="30" maxlength="30" autofocus>
      </div>

      <div>
        <input type="date" name="date" value="2012-02-16">
      </div>

      <div>
        <input type="month" name="month" value="2012-02">
      </div>

      <div>
        <input type="time" name="time" value="20:40">
      </div>

      <div>
        <input type="datetime-local" name="dateTimeLocal" value="2012-02-16T20:40">
      </div>

      <div>
        <input type="number" name="number" value="7">
      </div>

      <div>
        <input type="range" name="range" value="0">
      </div>

      <div>
        <input type="color" name="color" value="##ff0000">
      </div>

      <div>
        <input type="hidden" name="hidden" value="on">
      </div>

      <p>
        <input type="checkbox" name="status" value="1" checked="checked">good
        <input type="checkbox" name="status" value="2">soso
        <input type="checkbox" name="status" value="3">bad
      </p>

      <div>
        <input type="radio" id="huey" name="drone" value="huey" checked>
        <label for="huey">Huey</label>
      </div>

      <div>
        <input type="radio" id="dewey" name="drone" value="dewey">
        <label for="dewey">Dewey</label>
      </div>

      <div>
        <input type="radio" id="louie" name="drone" value="louie">
        <label for="louie">Louie</label>
      </div>

      <div>
        <input type="file" name="file1">
      </div>
  </form>

</body>
</html>
</cfoutput>
