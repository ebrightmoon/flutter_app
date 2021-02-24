import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

/// Created by liuwei
/// on 2020-09-21
/// page xfs_endecode_util
/// 加密

class XFSEnDecodeUtil {

  /// md5 加密
  static String encodeMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  /// Base64加密
  static String encodeBase64(String data) {
    var content = utf8.encode(data);
    var digest = base64Encode(content);
    return digest;
  }

  /// Base64解密
  static String decodeBase64(String data) {
    return String.fromCharCodes(base64Decode(data));
  }
}