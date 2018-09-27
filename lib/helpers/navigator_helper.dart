import 'dart:async';

import 'package:barber_app/config/constant.dart';
import 'package:barber_app/reducers/loading_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorHelper {
  static popToMain(BuildContext context) {
    Navigator.popUntil(context, (Route<dynamic> route) {
      return route.settings.name == "/";
    });
  }

  static showLoadingDialog(isLoading, [VoidCallback voidCallback]) {
    store.dispatch(LoadingState(isLoading));
    if (voidCallback != null) {
      try {
        new Timer(new Duration(milliseconds: 100), () {
          voidCallback();
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
