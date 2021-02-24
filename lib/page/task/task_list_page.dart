import 'package:flutter/cupertino.dart';

class TabListPage extends StatefulWidget {
  final int tabType;

  TabListPage({
    Key key,
    this.tabType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TabListState();
}

class TabListState extends State<TabListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("1222"),
    );
  }
}
