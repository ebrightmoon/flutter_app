import 'dart:convert';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutternews/http/api.dart';
import 'package:flutternews/http/interceptor.dart';
import 'package:flutternews/util/file_utils.dart';

class HttpClient {
  static const int ERROR_DIO = 101;
  static const int ERROR_PARSE = 102;

  static const String GET = "GET";
  static const String POST = "POST";
  Dio dio;
  PersistCookieJar persistCookieJar;

  /// 私有构造函数
  HttpClient._internal() {
    dio = new Dio();
    dio.options.baseUrl = Api.BASE_URL;
    dio.options.connectTimeout = 10 * 1000;
    dio.options.sendTimeout = 10 * 1000;
    dio.options.receiveTimeout = 10 * 1000;
    dio.interceptors.add(new HeaderInterceptor());
    dio.interceptors
        .add(new LogInterceptor(requestBody: true, responseBody: true));

    /// cookie
    getCookiePath().then((path) {
      persistCookieJar = new PersistCookieJar(dir: path);
      CookieManager cookieManager = new CookieManager(persistCookieJar);
      dio.interceptors.add(cookieManager);
    });
  }

  /// 保存单例对象
  static HttpClient _client = new HttpClient._internal();

  factory HttpClient() => _client;

  static HttpClient getInstance() {
    return _client;
  }

  ///  GET 请求
  get(String path, {Map<String, dynamic> data}) async {
    return _request(path, GET, data: data);
  }

  /// POST 请求
  post(String path, {Map<String, String> data}) async {
    return _request(path, POST, data: data);
  }

  /// 私有方法，只可本类访问
  _request(String path, String method, {Map<String, dynamic> data}) async {
    data = data ?? {};
    var tempData;
    method = method ?? GET;
    if (method == GET) {
      data.forEach((key, value) {
        if (path.indexOf(key) != -1) {
          path = path.replaceAll(":$key", value.toString());
        }
      });
    } else if (method == POST) {
      tempData = data;
    }
    try {
      Response response = await dio.request(path,
          data: tempData, options: Options(method: method));
      if (response?.statusCode != 200) {
        _handleError(response?.statusCode, response?.statusMessage);
        return;
      }
      var jsonString = json.encode(response.data);
      // map中的泛型为 dynamic
      Map<String, dynamic> dataMap = json.decode(jsonString);
      if (dataMap != null) {
        String code = dataMap['code'];
        int errorCode=int.parse(code);
        String errorMsg = dataMap['msg'];
        var data = dataMap['data'];
        // 请求失败
        if (errorCode != 0) {
          _handleError(errorCode, errorMsg);
          return;
        }
        if (data != null) {
          return data;
        }
      } else {
        _handleError(ERROR_PARSE, "数据解析失败");
        return null;
      }
    } on DioError catch (e) {
      // 请求错误
      _handleError(ERROR_DIO, "网络连接异常");
      return null;
    }
  }

  void _handleError(int errorCode, String errorMsg) {
    print("_handleError = $errorMsg");
    Fluttertoast.showToast(
        msg: errorMsg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM);
    // 未登录
    if (errorCode == -1001) {}
  }
}
