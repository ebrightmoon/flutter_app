/// 字符串扩展
extension StringExt on String{

  /// 字符串转 double
  double toDouble() {
    return double.parse(this);
  }

  /// 字符串转 int
  int toInt() {
    return int.parse(this);
  }

  /// 是否手机号
  bool isMobile(){
    return RegExp(r'^((13[0-9])|(14[5,7,9])|(15[^4])|(18[0-9])|(17[0,1,3,5,6,7,8])|(19)[0-9])\d{8}$').hasMatch(this);
  }

  /// 首字母大写
  String toUpperCasForFirst(){
    return "${this[0].toUpperCase()}${this.substring(1)}" ;
  }
}

/// Object扩展
extension ObjectExt on Object {

  /// 是否为空，
  bool isNullOrEmpty() {
    if (this is String) return (this as String).isEmpty;
    if (this is List) return (this as List).isEmpty;
    if (this is Map) return (this as Map).isEmpty;
    if (this is Iterable) return (this as Iterable).isEmpty;
    return this == null;
  }

  /// 是否不为空
  bool isNotNullOrEmpty() {
    return !this.isNullOrEmpty();
  }

  /// 打印数据
  log() {
    print('log类型：[${this.runtimeType}]--------------${this.toString()}');
  }
}