import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:barber_app/config/constant.dart';
import 'package:barber_app/exception/NetException.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:dio/dio.dart';

typedef T TransformToEntity<T>(dynamic json);

class RequestClient {
  static Future<T> request<T>(TransformToEntity modelTransform, String url,
      [Map<String, dynamic> queryParameters]) async {
    Options options = new Options(
        baseUrl:
            'http://${Platform.isAndroid ? '127.0.0.1:8080' : '127.0.0.1:8080'}',
        connectTimeout: 15000,
        receiveTimeout: 13000,
        headers: {
          'os': Platform.operatingSystem,
          'Authorization': "Bearer ${store.state.currentUser?.token ?? ""}"
        });

    Dio dio = new Dio(options);
    String requestUrl = url;

    try {
      Response response = await dio.post(requestUrl,
          data:
              new FormData.from(queryParameters ?? new Map<String, String>()));
      print(queryParameters);
      if (response.statusCode == HttpStatus.OK) {
        var data = response.data;
        debugPrint(options.headers.toString());
        debugPrint(requestUrl);
        debugPrint(json.encode(response.data));
        if (data['code'].toString() == '1003') {
//        UserHelper.loginOut();
          return new Future.value(modelTransform(response.data) as T);
        } else if (data['code'].toString() != '200') {
//        ScaffoldState.showSnackBar(new SnackBar(content: new Text(data['msg'])));
          ToastUtils.toast(data['message']);
          return new Future.error(new NetException(data['code'], data['msg']));
        } else {
          return new Future.value(modelTransform(response.data['data']) as T);
        }
      } else {
        if (response.statusCode == 400) {
          ToastUtils.toast("注意 要处理登录了");
          throw 'Error getting IP address:\nHttp status ${response.statusCode}';
        } else {
          return new Future.error(
              new NetException(response.statusCode, response.toString()));
        }
      }
    } catch (e) {
      print(e);
      ToastUtils.toast("注意 要处理登录了${e.toString()}");
      return new Future.error(
          new NetException(ErrorCode.NormalError, e.toString()));
    }
  }
}

class ErrorCode {
  static int NormalError = 500;
  static int NO_SET_PAYPASSWROD = 1005;
}
