library routes;

import 'package:barber_app/core/auto/login_screen.dart';
import 'package:barber_app/core/main/home_tab_screen.dart';
import 'package:barber_common/helpers/navigator_helper.dart';
import 'package:barber_common/models/app_state.dart';
import 'package:barber_common/module/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


Map<String, WidgetBuilder> getRoutes(context, store) {
  return {
    '/': (BuildContext context) => new StoreBuilder<AppState>(
          onInit: (store) {
            var oldState = store.state.copyWith();
            store.onChange.listen((state) {
              if (state.isLoading != oldState.isLoading) {
                if (state.isLoading) {
                  Navigator.push(context, barLoadingScreen);
                } else {
                  if (barLoadingScreen.isCurrent) {
                    Navigator.pop(context);
                  }
                }
                oldState = state.copyWith();
              }
              if (state.currentUser != oldState.currentUser) {
                NavigatorHelper.popToMain(context);
                oldState = state.copyWith();
              }
            });
          },
          builder: (context, store) {
            return new HomeTabScreen();
          },
        ),
    '/auto': (BuildContext context) => new StoreBuilder<AppState>(
          builder: (context, store) {
            return new LoginScreen();
          },
        ),
  };
}
