import 'package:flutternews/util/logger_util.dart';
import 'package:flutternews/util/print_long.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_model.dart';

/// 带下拉刷新、上拉加载页的 model 基本封装
abstract class RefreshModel<T> extends BaseModel {
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
    initialLoadStatus: LoadStatus.noMore,
  );

  T data;

  init() async {
    initPage(isInit: true);
    await loadRemoteData();
  }

  Future<T> loadRemoteData() async {
    try {
      var response = await loadData();
      if (isInit) {
        initPage(isInit: false);
      }
      data = response;
      refreshController.refreshCompleted();
      notifyListeners();
      return data;
    } catch (e, s) {
      printLong(e.toString());
      refreshController.loadFailed();
      return null;
    }
  }

  Future<T> loadData();

  /// 下拉刷新
  Future<T> onRefresh();
}
