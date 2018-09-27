import 'dart:convert';

import 'package:barber_app/config/constant.dart';
import 'package:barber_app/models/user.dart';
import 'package:flutter/material.dart';

//暂时不准备用数据库存用sp吧 参考
class UserHelper {
  static User getStoreUserCache() {
    return store.state.currentUser;
  }

/*
  static loginOut([BuildContext buildContext]) async {
    //最先清楚手势密码
    sp.setString(SP_USER_INFO, null);
    SK.accountPageStateKey.currentState?.refreshPage();
    if (buildContext != null && _userCache() != null) {
      if(!HomeTab.getMainRoute().isFirst){
        NavigatorHelper.popToMain(buildContext);
      }
      showDialog(
          context: SK.bottomNavigationDemoStateKey.currentState.context,
          builder: (BuildContext context) {
            return new LoginDialog(
              onPressed: () {
                Navigator.pop(context);
                NavigatorHelper.push2Login(context);
              },
            );
          },
          );
    }
    if (_userCache() != null) {
      _userCache() = null;
    }
  }*/

  //更新到内存并写入数据库
  static updateAndSave(setUp) {
    setUp();
//    saveData();
  }

  static bool haveOnlineUser() {
    return getStoreUserCache() != null;
  }

  static loginChecked(context, onSuccessCallback, [props = const {}]) {
    if (haveOnlineUser()) {
      onSuccessCallback();
    } else {
      Navigator.pushNamed(context, "/auto");
    }
  }

  static const String SP_USER_INFO = 'SP_USER_INFO';

  static void saveData(User user) {
    sp.setString(SP_USER_INFO, user != null ? json.encode(user.toJson()) : '');
  }

  static User loadSharedPreferencesUserData() {
    String localData = sp.getString(SP_USER_INFO);
    //不要去掉问号(..
//    debugPrint(localData);
    if (localData?.isNotEmpty == true) {
      return new User.fromJson(json.decode(localData));
    } else {
      debugPrint('用户数据为空');
      return null;
    }
  }

  static String getUserToken() {
    if (getStoreUserCache() != null) {
      return getStoreUserCache().token;
    } else {
      return "";
    }
  }

  static String getTokenUrl() {
    return '?token=${getUserToken()}';
  }
}
