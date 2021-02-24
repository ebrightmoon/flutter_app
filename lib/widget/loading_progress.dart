import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:xfsfsyuncai/xfs_support/xfs_define/xfs_header.dart';
import 'package:xfsfsyuncai/xfs_support/xfs_extension/xfs_extension.dart';

/// 加载提示框
class XFSProgress{

  static bool _isShowing = false;

  static void show(BuildContext context, {String title}) {
    if (!_isShowing) {
      _isShowing = true;
      Navigator.of(context)
          .push(DialogRouter(LoadingDialog(text: title??'正在加载...',)));
    }
  }

  static void hide(BuildContext context) {
    if (_isShowing) {
      _isShowing = false;
      Navigator.of(context).pop();
    }
  }

  /// 展示
  static void showLoading(context, {
    String title = '正在加载...'
  }) {
    if(!_isShowing) {
      _isShowing = true;

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return LoadingDialog(
              text: title,
            );
          }
      );
    }
  }

  /// 隐藏
  static void dismiss(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
      _isShowing = false;
    }
  }
}

class XFSLoadingView extends StatelessWidget {

  /// 宽
  final double width;
  final String title;

  const XFSLoadingView({
    Key key,
    this.width = 60,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: width,
        child: Container(
          decoration: ShapeDecoration(
            color: Color(0xFF333333,),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _loadingWidget(),
              title.isNullOrEmpty()
                  ? SizedBox(width: 0,)
                  : Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        title,
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget(){
    return SizedBox(
        width: width*0.3,
        height: width*0.3,
        child: Theme(
          data: ThemeData(
            cupertinoOverrideTheme: CupertinoThemeData(
              brightness: Brightness.dark,
            ),
          ),
          child: CupertinoActivityIndicator(
            radius: 15,
          ),
        ),
    );
  }

}


class LoadingDialog extends Dialog {
  final Function onTap;
  final String text;
  const LoadingDialog({
    Key key,
    this.text,
    this.onTap,
    this.width = 60,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.canvas,
      color: Colors.transparent,
      child: InkWell(
        onTap: this.onTap,
        child: XFSLoadingView(width: width, title: text,),
      ),
    );
  }


}


class DialogRouter extends PageRouteBuilder{

  final Widget page;

  DialogRouter(this.page)
      : super(
    opaque: false,
    barrierColor: Color(0x00000011),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
  );
}