import 'dart:async';

import 'package:barber_app/base/BasePageRoute.dart';
import 'package:barber_app/config/constant.dart';
import 'package:barber_app/helpers/navigator_helper.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_app/helpers/user_helper.dart';
import 'package:barber_app/reducers/auth_redux.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:barber_common/widget/count_down_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RestTelScreen extends BasePageRoute {
  @override
  _RestTelScreenState createState() => _RestTelScreenState();

  @override
  String getRouteName() {
    return "RestTelScreen";
  }
}

class _RestTelScreenState extends State<RestTelScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('修改手机号'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 40.0),
          child: new Column(children: <Widget>[Text("请在关于页面,加入qq群反馈")]),
        ));
  }
}
