import 'package:flutternews/http/api.dart';
import 'package:flutternews/http/http.dart';
import 'package:flutternews/provider/refresh_model.dart';
import 'package:flutternews/util/print_long.dart';

class HomePageModel<TaskInfo> extends RefreshModel {
  /// 加载数据
  @override
  loadData({String url}) async {
    try {
      /// 发起并发请求
      var taskBean = HttpClient.getInstance()
          .post(Api.URL_HOME_ONGOING_TASK, data: {"driverId": '98'});
      return taskBean;
    } catch (e, s) {
      print(e.toString());
    }
  }

  @override
  Future<List> onRefresh() {
    return loadRemoteData();
  }
}
