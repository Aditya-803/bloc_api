import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  final url;
  WebViewPage({this.url});

  @override
  createState() => _WebViewPageState(this.url);
}

class _WebViewPageState extends State<WebViewPage> {
  var _url;
  final _key = UniqueKey();
  _WebViewPageState(this._url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("News View"),),
      body: WebView(
        key: _key,
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
