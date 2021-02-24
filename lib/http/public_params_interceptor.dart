import 'dart:collection';
import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:xfsfsyuncai/xfs_support/xfs_define/channleKey.dart';
import 'package:crypto/crypto.dart' as crypto;

class PublicParamsInterceptor extends Interceptor {
  String keys = "xfs7Alc74oCVpHXg97etTs";

  @override
  Future onRequest(RequestOptions options) async {
//    var response = await XFSMethodManager.getPublicParams();
//    response.forEach((key, value) {
//      if (value != null || "" != value) {
//        options.queryParameters[key] = value;
//      }
//    });
//    Map map = new Map<String, dynamic>();
//    map = options.queryParameters;
//    var sign = await XFSMethodManager.getSign(map: map);
//    options.queryParameters['sign'] = sign;
    return super.onRequest(options);
  }

  String signUtil({HashMap<String, dynamic> parameters, String keys}) {
    /// 存储所有key
    List<dynamic> allKeys = [];
    parameters.forEach((key, value) {
      if (null != value && "" != value) {
        allKeys.add("$key=$value&");
      }
    });

    /// key排序
    allKeys.sort((obj1, obj2) {
      return obj1.compareTo(obj2);
    });

    /// 数组转string
    String pairsString = allKeys.join("");
    String pa2 = pairsString;
    pairsString = pairsString + "secret=$keys";

    /// hash
    String signString = generateMd5(pairsString.toUpperCase());
    return pa2 + "sign=" + signString;
  }

// md5 加密  7bb99bf192aa1a88970fa872d0597055
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md6 = crypto.md5;
    var digest = md6.convert(content);
    return hex.encode(digest.bytes);
  }
}
