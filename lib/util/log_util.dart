import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:xfsfsyuncai/xfs_support/xfs_define/defines.dart';
import 'package:xfsfsyuncai/xfs_support/xfs_utils/xfs_object_utils.dart';

/// Created by liuwei
/// on 2020/10/14
/// page xfs_log_util
/// 打印工具

class XFSLogUtil{

  static XFSLogUtil _instance;
  static String _projectName;
  static int maxLeng = 300;
  static String _fileName;
  static String _lineNumber;

  XFSLogUtil._();

  static XFSLogUtil instance({String projectName,}){
    if(_instance == null){
      _instance = XFSLogUtil._();
      _projectName = projectName;

      if(inRelease){
        debugPrint = (String printText, {int wrapWidth}){};///生产环境使用这个，解除打印log
      }else{
        debugPrint = (String printText, {int wrapWidth})=>debugPrintSynchronously(printText, wrapWidth: wrapWidth);///开发环境使用，调试打印log信息
      }
    }
  }

  static warning(Object printObj, {StackTrace stackTrace, String funcName}){
    _print(printObj, title: "⚠️", stackTrace: stackTrace, funcName: funcName);
  }

  static error(Object printObj, {StackTrace stackTrace, String funcName}){
    _print(printObj, title: "❌", stackTrace: stackTrace, funcName: funcName);
  }

  static success(Object printObj, {StackTrace stackTrace, String funcName}){
    _print(printObj, title: "✅️", stackTrace: stackTrace, funcName: funcName);
  }

  static info(Object printObj, {StackTrace stackTrace, String funcName}){
    _print(printObj, title: "🌟", stackTrace: stackTrace, funcName: funcName);
  }

  static _print(Object printObj, {StackTrace stackTrace, String title, String funcName}){
    if(!inRelease){
      _parseTrace(stackTrace);
      debugPrint("${_projectName??"「方盛云采」"} $title 「${DateTime.now()}」${_fileName==null?"":" $title 文件：「$_fileName」"}${funcName==null?"":" $title 函数：「$funcName」"}${_lineNumber == null?"":" $title 行数：$_lineNumber"} : ");
      String objStr = printObj.toString();
      if(objStr.length > maxLeng){
        while(objStr.length > maxLeng){
          debugPrint(objStr.substring(0, maxLeng));
          objStr = objStr.substring(maxLeng);
        }
      }
      debugPrint(objStr);
    }
  }

  static _parseTrace(StackTrace trace){
    if(trace != null){
      List<String> traceList = trace.toString().split("\n");
      if(XFSObjectUtil.isNotEmpty(trace)){
        var traceString = traceList[0];
        var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z]+.dart'));
        var fileInfo = traceString.substring(indexOfFileName);
        var listOfInfos = fileInfo.split(":");
        if(listOfInfos.length >= 2){
          _fileName = listOfInfos[0];
          _lineNumber = listOfInfos[1];
        }else if(listOfInfos.length == 1){
          _fileName = listOfInfos[0];
        }
      }
    }
  }

}