import 'package:dio/dio.dart';
import 'package:flutternews/http/api.dart';
import 'package:flutternews/http/http.dart';

ApiService _apiService = new ApiService();

ApiService get apiService => _apiService;

class ApiService {
  /// 分享文章
  void shareArticle(Function callback, Function errorCallback, params) async {
    var result =
        HttpClient.getInstance().get(Api.URL_HOME_ONGOING_TASK, data: {});
  }
}
