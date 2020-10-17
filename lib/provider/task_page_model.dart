import 'package:flutternews/provider/refresh_loadmore_model.dart';
import 'package:flutternews/util/logger_util.dart';

class TaskPageModel<TaskInfo> extends RefreshLoadMoreModel {
  @override
  Future<List> loadData() async {
    LoggerUtil.instance().v("verboseLog");
    return null;
  }

  @override
  Future<List> onLoadMore() {
    isRefresh = false;
    return loadRemoteData();
  }

  @override
  Future<List> onRefresh() {
    isRefresh = true;
    return loadRemoteData();
  }
}
