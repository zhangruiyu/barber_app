import 'dart:async';

import 'package:barber_app/base/BasePageRoute.dart';
import 'package:barber_app/core/passwordmanager/entitys/password_manager_entity.dart';
import 'package:barber_app/core/paypassword/reset_pay_password_screen.dart';
import 'package:barber_app/core/paypassword/set_pay_password_screen.dart';
import 'package:barber_app/core/restpassword/rest_password_screen.dart';
import 'package:barber_app/core/resttel/rest_tel_screen.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_app/utils/toast_utils.dart';
import 'package:barber_app/widget/StatePageState.dart';
import 'package:barber_app/widget/Toolbar.dart';
import 'package:flutter/material.dart';

class PasswordManagerScreen extends BasePageRoute {
  @override
  _PasswordManagerScreenState createState() => _PasswordManagerScreenState();

  @override
  String getRouteName() {
    return "PasswordManagerScreen";
  }
}

class _PasswordManagerScreenState extends State<PasswordManagerScreen> {
  Future<PasswordManagerEntity> requestPasswordManager() {
    final Completer<PasswordManagerEntity> completer =
        new Completer<PasswordManagerEntity>();
    RequestHelper.requestPasswordManager()
        .then((PasswordManagerEntity onValue) {
      completer.complete(onValue);
    }).catchError((onError) {
      completer.complete(null);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new Toolbar(
          title: new Text('密码管理'),
        ),
        body: StatePage(
            loadData: requestPasswordManager,
            buildContent: (data) {
              var passwordManagerEntity = data as PasswordManagerEntity;
              print(passwordManagerEntity.paypassword.toString());
              return new Column(
                children: <Widget>[
                  ListTile(
                      onTap: () {
                        Navigator.push(context, RestTelScreen().route());
                      },
                      title: Text("绑定手机"),
                      subtitle: Text("15201231801"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("去修改"),
                          Icon(Icons.arrow_right),
                        ],
                      )),
                  ListTile(
                      onTap: () {
                        Navigator.push(context, RestPasswordScreen().route());
                      },
                      title: Text("登录密码"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("去修改"),
                          Icon(Icons.arrow_right),
                        ],
                      )),
                  ListTile(
                      onTap: () {
                        if (passwordManagerEntity.paypassword == 0) {
                          Navigator.push(
                              context, SetPayPasswordScreen().route());
                        } else {
                          Navigator.push(
                              context, ResetPayPasswordScreen().route());
                        }
                      },
                      title: Text("支付密码"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(passwordManagerEntity.paypassword == 1
                              ? "去修改"
                              : "去设置"),
                          Icon(Icons.arrow_right),
                        ],
                      )),
                  ListTile(
                      title: Text("QQ"),
                      subtitle: Text("暂不可用"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("暂不可用"),
                          Icon(Icons.arrow_right),
                        ],
                      )),
                  ListTile(
                      title: Text("微信"),
                      subtitle: Text("暂不可用"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text("暂不可用"),
                          Icon(Icons.arrow_right),
                        ],
                      ))
                ],
              );
            }));
  }
}
