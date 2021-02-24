import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/route_util.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

/// WebView 加载网页页面
class WebViewScreen extends StatefulWidget {
  /// 标题
  String title;

  /// 链接
  String url;

  WebViewScreen({Key key, @required this.title, @required this.url})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new WebViewScreenState();
  }
}

class WebViewScreenState extends State<WebViewScreen> {
  bool isLoad = true;

  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.onStateChanged.listen((state) {
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

//  void _onPopSelected(String value) {
//    String _title = widget.title;
//    switch (value) {
//      case "browser":
//        RouteUtil.launchInBrowser(widget.url, title: _title);
//        break;
//      case "share":
//        String _url = widget.url;
//        Share.share('$_title : $_url');
//        break;
//      default:
//        break;
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        elevation: 0.4,
        title: new Text(widget.title),
        bottom: new PreferredSize(
          child: SizedBox(
            height: 2,
            child: isLoad ? new LinearProgressIndicator() : Container(),
          ),
          preferredSize: Size.fromHeight(2),
        ),
        actions: <Widget>[
          IconButton(
            // tooltip: '用浏览器打开',
            icon: Icon(Icons.language, size: 20.0),
            onPressed: () {
              RouteUtil.launchInBrowser(widget.url, title: widget.title);
            },
          ),
          IconButton(
            // tooltip: '分享',
            icon: Icon(Icons.share, size: 20.0),
            onPressed: () {
              Share.share('${widget.title} : ${widget.url}');
            },
          ),
        ],
      ),
      withZoom: false,
      withLocalStorage: true,
      withJavascript: true,
      hidden: true,
    );
  }

  @override
  void dispose() {
    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}
