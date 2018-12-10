import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:barber_app/bean_factory.dart';
import 'package:barber_common/config/constant.dart';
import 'package:barber_common/exception/NetException.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppRequestClient {
  static Future<T> request<T>(String url,
      [Map<String, dynamic> queryParameters]) async {
    Options options = new Options(
        baseUrl:
            'http://${Platform.isAndroid ? '192.168.199.216:8080' : '127.0.0.1:8080'}',
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
      if (response.statusCode == HttpStatus.ok) {
        var data = response.data;
        debugPrint(options.headers.toString());
        debugPrint(requestUrl);
        debugPrint(json.encode(response.data));
        if (data['code'].toString() == '1003') {
//        UserHelper.loginOut();
          return new Future.value(BeanFactory.generateOBJ<T>(response.data));
        } else if (data['code'].toString() != '200') {
//        ScaffoldState.showSnackBar(new SnackBar(content: new Text(data['msg'])));
          ToastUtils.toast(data['message']);
          return new Future.error(new NetException(data['code'], data['msg']));
        } else {
          return new Future.value(
              BeanFactory.generateOBJ<T>(response.data['data']));
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
