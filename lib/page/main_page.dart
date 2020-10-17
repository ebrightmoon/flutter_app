import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/page/task/task_page.dart';
import 'package:flutternews/page/user/user_page.dart';
import 'package:flutternews/res/colors.dart';

import 'home/home_page.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  //initialPage 初始化第一次默认在第几个。
  //viewportFraction 占屏幕多少，1为占满整个屏幕
  //keepPage
  //是否保存当前 Page 的状态，如果保存，下次回复对应保存的 page，initialPage被忽略，如果为 false 。下次总是从 initialPage 开始。
  PageController _pageController =
      PageController(initialPage: 0, viewportFraction: 1, keepPage: true);

  // 记录当前 tab 选择位置
  int tabIndex = 0;
  var tabImages;
  var tabPages;

  final tabTextStyleNormal =
      TextStyle(color: Colours.appMinorColor, fontSize: 12);
  final tabTextStyleSelected =
      TextStyle(color: Colours.appPrimaryColor, fontSize: 12);
  final tabTitles = <String>['首页', '任务', '我的'];

  var body;

  @override
  void initState() {
    super.initState();
    tabImages ??= [
      [
        getTabImage('images/tab_home_normal.png'),
        getTabImage('images/tab_home_select.png')
      ],
      [
        getTabImage('images/tab_task_normal.png'),
        getTabImage('images/tab_task_select.png')
      ],
      [
        getTabImage('images/tab_user_normal.png'),
        getTabImage('images/tab_user_select.png')
      ],
    ];
    tabPages ??= [HomePage(), TaskPage(), MinePage()];
  }

  Image getTabImage(imagePath) => Image.asset(imagePath, width: 22, height: 22);

  Image getTabIcon(int index) {
    if (tabIndex == index) {
      return tabImages[index][1];
    }
    return tabImages[index][0];
  }

  TextStyle getTabTextStyle(int index) {
    if (tabIndex == index) {
      return tabTextStyleSelected;
    }
    return tabTextStyleNormal;
  }

  Text getTabTitle(index) => Text(
        tabTitles[index],
        style: getTabTextStyle(index),
      );

  @override
  Widget build(BuildContext context) {
//    body = IndexedStack(
//      children: tabPages,
//      index: tabIndex,
//    );
    body = PageView.builder(
      scrollDirection: Axis.horizontal,
      //滚动方向
      itemBuilder: (context, index) => tabPages[index],
      itemCount: tabPages.length,
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      // 是否可以滚动
      onPageChanged: (index) {
        setState(() {
          tabIndex = index;
        });
      },
    );

    return CupertinoApp(
      home: Scaffold(
        body: this.body,
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Color(0xFFFFFFFF),
          items: [
            BottomNavigationBarItem(icon: getTabIcon(0), title: getTabTitle(0)),
            BottomNavigationBarItem(icon: getTabIcon(1), title: getTabTitle(1)),
            BottomNavigationBarItem(icon: getTabIcon(2), title: getTabTitle(2)),
          ],

          currentIndex: tabIndex,
          //使用IndexStack
//          onTap: (index) => {
//            setState(() {
//              tabIndex = index;
//            })
//          },
          //使用PageView
          onTap: (index) => {_onItemTapped(index)},
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }
}
