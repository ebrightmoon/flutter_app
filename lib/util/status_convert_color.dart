class StatusConverStr {
  ///单据状态:0:其他 1:已删除 2:待派车 3:已派车 4:装车中 5:装车完毕 6:配送中 7:返程中 8:已回司  9:已完成	是
  static String disBillStatusConvertStr(
      int status, int hasSales, int isSigned) {
    String str = "";
    if (status == 6 || status == 7) {
      str = "在途中";
    } else if (status == 8 && hasSales == 1 && isSigned == 0) {
      str = "未交账";
    } else if (status == 8 && hasSales == 1 && isSigned == 1) {
      str = "已交账";
    } else if (status == 8) {
      str = "已回司";
    } else if (status == 9) {
      str = "已完成";
    } else {
      str = "未开始";
    }
    return str;
  }
}
