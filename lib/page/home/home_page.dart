import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutternews/model/home_banner.dart';
import 'package:flutternews/provider/home_page_model.dart';
import 'package:flutternews/provider/provider_widget.dart';
import 'package:flutternews/res/colors.dart';
import 'package:flutternews/util/loading_widget.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 首页
class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  //是否保存状态 使用IndexStack
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ProviderWidget<HomePageModel>(
      model: HomePageModel(),
      onModelInitial: (model) {
        model.init();
      },
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            child: RefreshConfiguration(
              enableLoadingWhenNoData: true,
              child: SmartRefresher(
                enablePullUp: false,
                enablePullDown: true,
                header: WaterDropHeader(),
                footer: ClassicFooter(
                  loadStyle: LoadStyle.ShowAlways,
                ),
                controller: model.refreshController,
                onRefresh: model.onRefresh,
                child: Container(
                  child: _HomePageListWidget(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class _HomePageListWidget extends StatelessWidget {
  List<HomeBanner> banners = new List();

  @override
  Widget build(BuildContext context) {
    HomePageModel model = Provider.of(context);
    if (model.isInit) {
      return LoadingWidget();
    }
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: _itemView,
        physics: BouncingScrollPhysics(),
        separatorBuilder: (context, index) {
          return Divider(
            indent: 0,
            endIndent: 0,
            color: Colors.transparent,
            height: 16,
          );
        },
        itemCount: 4);
  }

  Widget _itemView(BuildContext context, int index) {
    if (index == 0) {
      return Image.asset(
        'images/banner.png',
        fit: BoxFit.cover,
      );
//      return Container(
//        height: 200,
//        color: Colors.transparent,
//        child: _buildBannerWidget(),
//      );
    } else if (index == 1) {
      return _buildScanWidget();
    } else if (index == 2) {
      return _buildTaskWidget();
    } else if (index == 3) {
      return Container(
        child: Center(
          child: Text(
            "下拉刷新",
            style: TextStyle(color: Colours.appSubText),
          ),
        ),
      );
    } else {
      return null;
    }
  }

  /// 任务模块
  Widget _buildTaskWidget() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      margin: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 52,
                  decoration: new BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "images/bg_current_task.png",
                          ),
                          fit: BoxFit.fill)),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  height: 32,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 8),
                  padding: EdgeInsets.only(left: 16),
                  decoration: new ShapeDecoration(
                      color: const Color(0xffe6f0ff),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              bottomLeft: Radius.circular(16))
//                        borderRadius: BorderRadius.circular(16),
                          )),
                  child: Text(
                    "家数：3  未开始",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colours.appPrimaryColor,
                    ),
                  ),
                ),
                flex: 1,
              )
            ],
          ),
          Container(
            height: 51,
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "派车单号：",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12, color: Colours.appText),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    "PC00221",
                    style: TextStyle(fontSize: 14, color: Colours.appSubText),
                    textAlign: TextAlign.right,
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Image.asset("images/ic_divide_line.png"),
          ),
          Container(
            height: 51,
            margin: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "取货地：",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12, color: Colours.appText),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    "京南物流中心",
                    style: TextStyle(fontSize: 14, color: Colours.appSubText),
                    textAlign: TextAlign.right,
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Image.asset(
              "images/ic_divide_line.png",
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "最远点地址：",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 12, color: Colours.appText),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    "云南省思茅市镇沅彝族哈尼族拉祜族自治县阳光街309号",
                    style: TextStyle(fontSize: 14, color: Colours.appSubText),
                    textAlign: TextAlign.right,
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 扫描控件
  Widget _buildScanWidget() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 60,
            margin: EdgeInsets.only(left: 16, right: 4),
            padding: EdgeInsets.only(left: 10),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
                image: DecorationImage(
                    image: AssetImage(
                      "images/bg_car_exception.png",
                    ),
                    fit: BoxFit.cover)),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Image.asset(
                    "images/ic_car_exception.png",
                    width: 24,
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  '上报异常',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )
              ],
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            height: 60,
            margin: EdgeInsets.only(right: 16, left: 4),
            padding: EdgeInsets.only(left: 10),
            decoration: new BoxDecoration(
                borderRadius: new BorderRadius.all(new Radius.circular(4.0)),
                image: DecorationImage(
                    image: AssetImage(
                      "images/bg_home_scan.png",
                    ),
                    fit: BoxFit.cover)),
            child: new Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Image.asset("images/ic_white_scan.png",
                      width: 24, height: 24, fit: BoxFit.cover),
                ),
                Text(
                  '扫一扫',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )
              ],
            ),
          ),
          flex: 1,
        ),
      ],
    );
  }

  /// banner
  Widget _buildBannerWidget() {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          banners[index].imagePath,
          fit: BoxFit.cover,
        );
      },
      itemCount: banners.length,
      autoplay: true,
      pagination: SwiperPagination(),
    );
  }
}
