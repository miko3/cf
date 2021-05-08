/**
 * アプリケーションcfc
 * @see [Application.CFC reference|https://helpx.adobe.com/coldfusion/cfml-reference/application-cfc-reference.html]
 */
component {

  this.name = "debug-learning-#Hash(GetDirectoryFromPath(GetBaseTemplatePath()))#";

/* hanndlers */

  /**
   * リクエストに関するすべてのページや CFC の処理が完了すると発生します。
   * @targetPage
   */
  public void function onRequestEnd(string targetPage="") {

    // リクエストの内容
	/*
    var requestBody = toString(getHttpRequestData().content);
    if (!len(requestBody)) {
      return;
    }

    var contents = deserializeJson(requestBody);
	*/

  }

}
