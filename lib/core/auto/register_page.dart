import 'dart:async';

import 'package:barber_app/core/auto/auto_page_model.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_app/styles/color_style.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:barber_common/widget/count_down_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  final double width;
  final AutoPageShowModel model;

  RegisterPage({this.model, this.width});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

const inputMarginTop = 18.0;

class _RegisterPageState extends State<RegisterPage> {
  var countDownTextStateKey = new GlobalKey<CountDownTextState>();
  TextEditingController telEditingController;
  TextEditingController passwordEditingController =
      TextEditingController(text: "");
  TextEditingController autoCodeEditingController =
      TextEditingController(text: "");
  Timer timer;

  @override
  void initState() {
    telEditingController = TextEditingController(text: widget.model.loginTel);
    super.initState();
  }

  void sendRegisterCode() {
    RequestHelper.sendRegisterCode(
            telEditingController.text, passwordEditingController.text)
        .then((onValue) {
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

  void registerUser() {
    RequestHelper.registerUser(telEditingController.text,
            passwordEditingController.text, autoCodeEditingController.text)
        .then((onValue) {
      ToastUtils.toast("注册成功,请登录");
      widget.model.setCurrentPage("LoginPage");
    }).catchError((onError) {});
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
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0), color: inputBorder),
              child: TextFormField(
                controller: telEditingController,
                style: theme.textTheme.subhead
                    .merge(TextStyle(color: Colors.white)),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 10.0, top: 7.0, bottom: 7.0),
                    hintStyle: theme.textTheme.subhead
                        .merge(TextStyle(color: Colors.white)),
                    fillColor: Colors.white,
                    hintText: "请输入手机号",
                    border: InputBorder.none),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp(r"^.{0,11}")),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0), color: inputBorder),
              margin: const EdgeInsets.only(top: inputMarginTop),
              child: TextFormField(
                obscureText: true,
                controller: passwordEditingController,
                style: theme.textTheme.subhead
                    .merge(TextStyle(color: Colors.white)),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 10.0, top: 7.0, bottom: 7.0),
                    hintStyle: theme.textTheme.subhead
                        .merge(TextStyle(color: Colors.white)),
                    fillColor: Colors.white,
                    hintText: "请输入密码",
                    border: InputBorder.none),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp(r"^.{0,18}")),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: inputMarginTop),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3.0),
                          color: inputBorder),
                      child: TextFormField(
                        obscureText: true,
                        controller: autoCodeEditingController,
                        style: theme.textTheme.subhead
                            .merge(TextStyle(color: Colors.white)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 10.0, top: 7.0, bottom: 7.0),
                            hintStyle: theme.textTheme.subhead
                                .merge(TextStyle(color: Colors.white)),
                            fillColor: Colors.white,
                            hintText: "验证码",
                            border: InputBorder.none),
                        keyboardType: TextInputType.text,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp(r"^.{0,6}")),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    fit: FlexFit.loose,
                    child: GestureDetector(
                        onTap: () {
                          if (timer == null) {
                            if (telEditingController.text.length < 11) {
                              ToastUtils.toast("手机号格式不正确");
                            } else {
                              sendRegisterCode();
                            }
                          }
                        },
                        child: CountDownText(key: countDownTextStateKey)),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
                  child: GestureDetector(
                    onTap: () {
                      widget.model.setCurrentPage("LoginPage");
                    },
                    child: Text(
                      "登录",
                      style: theme.textTheme.body1
                          .merge(TextStyle(color: Colors.white)),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: FlatButton(
                  color: theme.accentColor,
                  textColor: Colors.white,
                  onPressed: () {
                    if (telEditingController.text.length < 11) {
                      ToastUtils.toast("手机号格式不正确");
                    } else if (passwordEditingController.text.length < 9) {
                      ToastUtils.toast("密码不能低于9位");
                    } else if (autoCodeEditingController.text.length < 6) {
                      ToastUtils.toast("验证码应位6位");
                    } else {
                      registerUser();
                    }
                  },
                  child: Container(
                    width: widget.width - 90,
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "立即注册",
                      textAlign: TextAlign.center,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
