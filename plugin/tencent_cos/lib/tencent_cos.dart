import 'dart:async';

import 'package:flutter/services.dart';

class TencentCos {
  static const MethodChannel _channel = const MethodChannel('tencent_cos');

  static void uploadByFile(
      String region,
      String appid,
      String secretId,
      String secretKey,
      String sessionToken,
      expiredTime,
      String uploadCosPath,
      String url) {
    _channel.invokeMethod('TencentCos.uploadFile', {
      'region': region,
      'appid': appid,
      'secretId': secretId,
      'secretKey': secretKey,
      'expiredTime': expiredTime,
      'sessionToken': sessionToken,
      'uploadCosPath': uploadCosPath,
      'url': url,
    });
  }

  static void setMethodCallHandler(Future<dynamic> handler(MethodCall call)) {
    _channel.setMethodCallHandler(handler);
  }
}
