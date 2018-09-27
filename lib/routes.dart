library routes;

import 'package:barber_app/base/DialogRoute.dart';
import 'package:barber_app/core/auto/login_screen.dart';
import 'package:barber_app/core/loading/loading_screen.dart';
import 'package:barber_app/core/main/home_tab_screen.dart';
import 'package:barber_app/helpers/navigator_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'models/app_state.dart';

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
