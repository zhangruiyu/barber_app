import 'dart:collection';

import 'package:barber_app/core/main/account/account_page.dart';
import 'package:barber_app/core/main/dynamic/dynamic_page.dart';
import 'package:barber_app/core/main/home/home_page.dart';
import 'package:barber_app/core/main/home/i_refresh.dart';
import 'package:flutter/material.dart';
import 'package:navigation_bar/NavigationPageView.dart';
import 'package:navigation_bar/navigation_tab_bar.dart';

class HomeTabScreen extends StatefulWidget {
  @override
  HomeTabScreenState createState() => HomeTabScreenState();
}

class HomeTabScreenState extends State<HomeTabScreen>
    with TickerProviderStateMixin {
  //当前页面的角标
  static HashMap<int, RefreshPage> tabStates = HashMap<int, RefreshPage>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var accentBackgroundColors = Theme.of(context).accentColor;
    return new NavigationTabBar(
      onTap: (value, previousIndex) {
        try {
          HomeTabScreenState.tabStates[value].refreshPage();
        } catch (e) {
          print("还未初始化$value");
        }
      },
      tabBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return HomePage();
        } else if (index == 1) {
          return DynamicPage();
        }
        return new AccountPage();
      },
      navigationViews: <NavigationPageView>[
        new NavigationPageView(
          icon: const Icon(Icons.home),
          title: '首页',
          color: accentBackgroundColors,
          vsync: this,
        ),
        new NavigationPageView(
          icon: const Icon(Icons.notifications),
          title: '社区',
          color: accentBackgroundColors,
          vsync: this,
        ),
        new NavigationPageView(
          icon: const Icon(Icons.menu),
          title: '账户',
          color: accentBackgroundColors,
          vsync: this,
        ),
      ],
    );
  }
}
