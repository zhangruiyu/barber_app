import 'dart:async';

import 'package:barber_app/core/auto/auto_page_model.dart';
import 'package:barber_app/helpers/navigator_helper.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_app/models/app_state.dart';
import 'package:barber_app/models/user.dart';
import 'package:barber_app/reducers/auth_redux.dart';
import 'package:barber_app/reducers/loading_redux.dart';
import 'package:barber_app/styles/color_style.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class LoginPage extends StatefulWidget {
  final double width;
  final AutoPageShowModel model;

  LoginPage({this.model, this.width});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController telEditingController;
  TextEditingController passwordEditingController =
      TextEditingController(text: "123123123");

  @override
  void initState() {
    telEditingController = TextEditingController(text: widget.model.loginTel);
    super.initState();
  }

  ThunkAction<AppState> actionLogin(String tel, String password) {
    ThunkAction<AppState> action = (Store<AppState> store) async {
      NavigatorHelper.showLoadingDialog(true);
      RequestHelper.login(tel, password).then((onValue) {
        NavigatorHelper.showLoadingDialog(false);
        store.dispatch(LogInSuccessful(
            user: User(
          token: onValue.token,
          tel: onValue.tel,
          avatar: onValue.avatar,
          nickname: onValue.nickname,
        )));
      }).catchError((onError) {
        NavigatorHelper.showLoadingDialog(false);
        store.dispatch(LogInFail(onError));
      });
    };
    return action;
  }

  @override
  void dispose() {
    widget.model.loginTel = telEditingController.text;
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
              margin: const EdgeInsets.only(top: 18.0),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 50.0),
                  child: GestureDetector(
                    onTap: () {
                      widget.model.setCurrentPage("Register");
                    },
                    child: Text(
                      "注册",
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
                onPressed: () {},
                child: StoreBuilder<AppState>(
                  builder: (context, store) {
                    return new GestureDetector(
                      onTap: () {
                        if (telEditingController.text.length < 11) {
                          ToastUtils.toast("手机号格式不对");
                        } else if (passwordEditingController.text.isEmpty) {
                          ToastUtils.toast("密码格式不对");
                        } else {
                          store.dispatch(actionLogin(telEditingController.text,
                              passwordEditingController.text));
                        }
                      },
                      child: Container(
                        width: widget.width - 90,
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "登录",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  color: Colors.lightBlueAccent,
                  onPressed: () {},
                  textColor: Colors.white,
                  child: Text("QQ"),
                ),
                FlatButton(
                  color: Colors.green,
                  onPressed: () {},
                  textColor: Colors.white,
                  child: Text("微信"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
