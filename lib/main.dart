import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutternews/config/router_config.dart';
import 'package:flutternews/page/splash_page.dart';
import 'package:flutternews/provider/app_theme.dart';
import 'package:flutternews/provider/dark_mode.dart';
import 'package:flutternews/provider/login_state.dart';
import 'package:flutternews/res/colors.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'config/app_config.dart';

/// 在拿不到context的地方通过navigatorKey进行路由跳转：
/// https://stackoverflow.com/questions/52962112/how-to-navigate-without-context-in-flutter-app
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() {
  final appTheme = new AppTheme();
  final darkMode = new DarkMode();
  final loginState = new LoginState();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appTheme),
        ChangeNotifierProvider.value(value: darkMode),
        ChangeNotifierProvider.value(value: loginState),
      ],
      child: MyApp(),
    ),
  );

  // 设置状态栏和 appbar 颜色一致
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appTheme = Provider.of<AppTheme>(context);
    var darkMode = Provider.of<DarkMode>(context);
    return MaterialApp(
      localizationsDelegates: [
        // 这行是关键
        RefreshLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [
        const Locale(('en')),
        const Locale('zh'),
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        return locale;
      },
      title: AppConfig.appName,
      // 标题
      debugShowCheckedModeBanner: AppConfig.isDebug,
      //去掉debug图标
      routes: Router.generateRoute(),
      navigatorKey: navigatorKey,
      // 存放路由的配置
      theme: getTheme(appTheme.themeColor, isDarkMode: darkMode.isDark),
      // 启动页
      home: SplashPage(),
    );
  }

  getTheme(Color themeColor, {bool isDarkMode = false}) {
    return ThemeData(
      // 页面背景颜色
      scaffoldBackgroundColor:
          isDarkMode ? Colours.darkAppBackground : Colours.appBackground,
      accentColor: isDarkMode ? Colours.darkAppSubText : Colours.appSubText,
      // tab 指示器颜色
      indicatorColor: Colors.white,
      backgroundColor:
          isDarkMode ? Colours.darkAppForeground : Colours.appForeground,
      // 底部菜单背景颜色
      bottomAppBarColor:
          isDarkMode ? Colours.darkAppForeground : Colours.appForeground,
      primaryColor: Colours.appThemeColor,
      primaryColorDark: Colours.appBackground,
//      brightness: isDarkMode ? Brightness.light : Brightness.dark,
      ///  appBar theme
      appBarTheme: AppBarTheme(
        color: Colors.yellow,
        // 状态栏字体颜色
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        actionsIconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        // 一级文本
        body1: isDarkMode
            ? TextStyle(
                color: Colours.darkAppText,
              )
            : TextStyle(
                color: Colours.appText,
              ),
//        subtitle: isDarkMode
//            ? TextStyle(color: Colors.amber)
//            : TextStyle(color: Colors.cyan),
        // 二级文本
        body2: isDarkMode
            ? TextStyle(
                color: Colours.darkAppSubText,
                fontSize: 14,
              )
            : TextStyle(
                color: Colours.appSubText,
                fontSize: 14,
              ),
        display1: isDarkMode
            ? TextStyle(color: Colours.darkAppActionClip)
            : TextStyle(color: Colours.appActionClip),
        button: TextStyle(color: isDarkMode ? Colors.white30 : Colors.black54),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode ? Colours.darkAppDivider : Colours.appDivider,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode ? Colours.darkAppDivider : Colours.appDivider,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode ? Colours.darkAppDivider : Colours.appDivider,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor:
            isDarkMode ? Colours.darkDialogBackground : Colors.white,
        titleTextStyle: TextStyle(
          color: isDarkMode ? Colours.darkAppText : Colours.appText,
          fontSize: 20,
        ),
        contentTextStyle: TextStyle(
          color: Colors.yellow,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor:
            isDarkMode ? Colours.darkAppBackground : Colours.appBackground,
      ),
      dividerColor: isDarkMode ? Colours.darkAppDivider : Colours.appDivider,
      cursorColor: Colours.appThemeColor,
      bottomAppBarTheme: BottomAppBarTheme(
        color: isDarkMode ? Colours.darkAppForeground : Colours.appForeground,
      ),
      toggleButtonsTheme: ToggleButtonsThemeData(color: Colors.yellow),
    );
  }
}
