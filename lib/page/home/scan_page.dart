import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/res/colors.dart';
import 'package:flutternews/res/styles.dart';

/// 运单列表
class WaybillPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WaybillPageState();
}

class WaybillPageState extends State<WaybillPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "车辆上报异常",
          style: TextStyle(fontSize: 16, color: Colours.appText),
        ),
      ),
      body: Container(
        child: Text("上报异常"),
      ),
    );
  }
}
