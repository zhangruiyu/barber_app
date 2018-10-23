import 'package:barber_common/config/constant.dart';
import 'package:barber_common/helpers/user_helper.dart';
import 'package:barber_common/models/app_state.dart';
import 'package:barber_app/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  //获取sp实例
  sp = await SharedPreferences.getInstance();
  store.state.currentUser = UserHelper.loadSharedPreferencesUserData();
  runApp(new MyApp());
}

final ThemeData _kGalleryLightTheme = new ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepOrange,
    platform: TargetPlatform.iOS,
    dividerColor: Color(0xfff5f5f5));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        theme: _kGalleryLightTheme,
        title: "待定",
//        locale: const Locale('zh', 'CN'),
        debugShowCheckedModeBanner: false,
        routes: getRoutes(context, store),
        initialRoute: "/",
      ),
    );
  }
}
