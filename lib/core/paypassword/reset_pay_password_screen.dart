import 'dart:async';

import 'package:barber_app/base/BasePageRoute.dart';
import 'package:barber_app/core/store/detail/entitys/store_detail_entity.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_app/utils/toast_utils.dart';
import 'package:barber_app/widget/Toolbar.dart';
import 'package:barber_app/widget/count_down_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResetPayPasswordScreen extends BasePageRoute {
  @override
  _ResetPayPasswordScreenState createState() => _ResetPayPasswordScreenState();

  @override
  String getRouteName() {
    return "ResetPayPasswordScreen";
  }
}

class _ResetPayPasswordScreenState extends State<ResetPayPasswordScreen> {
  TextEditingController strEditingController;
  TextEditingController autoCodeEditingController =
      TextEditingController(text: "");
  var countDownTextStateKey = new GlobalKey<CountDownTextState>();
  Timer timer;

  @override
  void initState() {
    strEditingController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    clearTimer();
    strEditingController.dispose();
    super.dispose();
  }

  clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  void resetPayPassword() {
    RequestHelper.resetPayPassword(
            strEditingController.text, autoCodeEditingController.text)
        .then((onValue) {
      ToastUtils.toast("支付密码设置成功");
      Navigator.pop(context);
    }).catchError((onError) {});
  }

  void sendResetPayPasswordCode() {
    RequestHelper.sendResetPayPasswordCode().then((onValue) {
      var n = onValue.expire;
      timer = new Timer.periodic(new Duration(seconds: 1), (Timer timer) {
        n--;
        countDownTextStateKey.currentState?.setText(n);
        if (n <= 0) {
          clearTimer();
        }
      });
    }).catchError((onError) {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: Toolbar(
        title: Text("重置支付密码"),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.send),
            onPressed: resetPayPassword,
          ),
        ],
      ),
      body: new Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new TextField(
                autofocus: true,
                keyboardType: TextInputType.phone,
                controller: strEditingController,
                decoration: new InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: "新支付密码",
                ),
                maxLines: 1,
                maxLength: 6,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                      width: 130.0,
                      child: new TextField(
                        autofocus: true,
                        keyboardType: TextInputType.phone,
                        controller: autoCodeEditingController,
                        decoration: new InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: "验证码",
                        ),
                        maxLines: 1,
                        maxLength: 6,
                        onChanged: (str) {
                          print(str);
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Container(
                      alignment: Alignment.center,
                      color: theme.accentColor,
                      width: 80.0,
                      height: 40.0,
                      child: GestureDetector(
                          onTap: () {
                            if (timer == null) {
                              if (strEditingController.text.length < 6) {
                                ToastUtils.toast("新支付密码应为6位数字");
                              } else {
                                sendResetPayPasswordCode();
                              }
                            }
                          },
                          child: CountDownText(key: countDownTextStateKey)),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
