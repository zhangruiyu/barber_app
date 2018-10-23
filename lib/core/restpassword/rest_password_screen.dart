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

class RestPasswordScreen extends BasePageRoute {
  @override
  _RestPasswordScreenState createState() => _RestPasswordScreenState();

  @override
  String getRouteName() {
    return "RestPasswordScreen";
  }
}

class _RestPasswordScreenState extends State<RestPasswordScreen> {
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController affirmPasswordEditingController =
      TextEditingController();
  TextEditingController autoCodeEditingController =
      TextEditingController(text: "");
  Timer timer;
  var countDownTextStateKey = new GlobalKey<CountDownTextState>();

  void sendRegisterCode() {
    RequestHelper.sendRestPasswordCode("15201231801").then((onValue) {
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

  void restPassword() {
    NavigatorHelper.showLoadingDialog(true);
    RequestHelper
        .restPassword("15201231801", autoCodeEditingController.text,
            affirmPasswordEditingController.text)
        .then((onValue) {
      store.dispatch(LogOutSuccessful());
      NavigatorHelper.showLoadingDialog(false, () {
        NavigatorHelper.popToMain(context);
      });
      ToastUtils.toast("密码修改成功,请重新登录");
    }).catchError((onError) {
      NavigatorHelper.showLoadingDialog(false);
    });
  }

  clearTimer() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
  }

  @override
  void dispose() {
    clearTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('修改登录密码'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 28.0, right: 28.0, top: 40.0),
          child: new Column(
            children: <Widget>[
              TextFormField(
                obscureText: true,
                controller: passwordEditingController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 10.0, top: 7.0, bottom: 7.0),
                  fillColor: Colors.white,
                  hintText: "新密码",
                ),
                keyboardType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: TextFormField(
                  obscureText: true,
                  controller: affirmPasswordEditingController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 10.0, top: 7.0, bottom: 7.0),
                    fillColor: Colors.white,
                    hintText: "再次输入新密码",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 100.0,
                      child: TextFormField(
                        controller: autoCodeEditingController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                              left: 10.0, top: 7.0, bottom: 7.0),
                          fillColor: Colors.white,
                          hintText: "验证码",
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp(r"^.{0,6}")),
                        ],
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          if (timer == null) {
                            if (affirmPasswordEditingController.text.length <
                                    9 ||
                                passwordEditingController.text.length < 9) {
                              ToastUtils.toast("密码格式应大于等于9位");
                            } else {
                              if (affirmPasswordEditingController.text !=
                                  passwordEditingController.text) {
                                ToastUtils.toast("两次输入的密码不相同");
                              } else {
                                sendRegisterCode();
                              }
                            }
                          }
                        },
                        child: Container(
                          color: theme.accentColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CountDownText(key: countDownTextStateKey),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 58.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new FlatButton(
                      child: new SizedBox(
                          width: WindowUtils.getScreenWidth() - 178,
                          height: 45.0,
                          child: new Center(
                            child: new Text(
                              '确认修改',
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  color: const Color(0xffffffff),
                                  fontSize: 18.0),
                            ),
                          )),
                      onPressed: () async {
                        if (affirmPasswordEditingController.text.length < 9 ||
                            passwordEditingController.text.length < 9) {
                          ToastUtils.toast("密码格式应大于等于9位");
                        } else {
                          if (affirmPasswordEditingController.text !=
                              passwordEditingController.text) {
                            ToastUtils.toast("两次输入的密码不相同");
                          } else {
                            if (autoCodeEditingController.text.length != 6) {
                              ToastUtils.toast("验证码应为6位数字");
                            } else {
                              restPassword();
                            }
                          }
                        }
                      },
                      color: Theme.of(context).accentColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
