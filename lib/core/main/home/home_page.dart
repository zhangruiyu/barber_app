import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:banner/banner.dart';
import 'package:barber_common/config/constant.dart';
import 'package:barber_app/core/main/home/entitys/home_entity.dart';
import 'package:barber_app/core/main/home/i_refresh.dart';
import 'package:barber_app/core/main/home_tab_screen.dart';
import 'package:barber_app/core/search/search_demo_search_delegate.dart';
import 'package:barber_app/core/search/search_entity.dart';
import 'package:barber_app/core/store/detail/store_detail_srceen.dart';
import 'package:barber_app/core/store/queue/store_quque_srceen.dart';
import 'package:barber_app/core/store/subjects/subjects_screen.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:barber_common/widget/BannerShowWidget.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:barber_common/widget/divider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

//import 'package:amap_location/amap_location.dart';
//import 'package:amap_location/amap_location_option.dart';

//import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RefreshPage {
  HomeEntity homeEntity;

  @override
  void initState() {
    HomeTabScreenState.tabStates[0] = this;
    super.initState();
    initAMap();
    refreshPage();
  }

  Future initAMap() async {
//    AMapLocationClient.setApiKey("bf6b216bde7b5eeee42b23a5c4f75fe3");
//    await AMapLocationClient.startup(new AMapLocationOption(
//        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
//    _checkPersmission();
  }

  _checkPersmission() async {
    /* PermissionStatus permissions =
    ( await PermissionHandler()
        .requestPermissions([PermissionGroup.locationWhenInUse]))[PermissionGroup.locationWhenInUse];
//    PermissionStatus permission = await PermissionHandler()
//        .checkPermissionStatus(PermissionGroup.locationWhenInUse);
    if (permissions == PermissionStatus.granted) {
      var millisecondsSinceEpoch2 = DateTime.now().millisecondsSinceEpoch;
      var location = await AMapLocationClient.getLocation(true);
      print(location.latitude);
      print(location.longitude);
      print(DateTime.now().millisecondsSinceEpoch - millisecondsSinceEpoch2);
      AMapLocationClient.shutdown();
    } else {
      ToastUtils.toast("定位权限获取失败");
    }*/
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void refreshPage() {
    RequestHelper.refreshHome().then((onValue) {
      setState(() {
        homeEntity = onValue;
      });
    }).catchError((onError) {});
  }

  selectStore() async {
    var searchHistory =
        (sp.getStringList("searchHistory") ?? List<String>()).map((strHistory) {
      return SearchEntity.fromJson(json.decode(strHistory));
    }).toList();
    if (searchHistory.isEmpty) {
      searchHistory.add(SearchEntity(id: 1, name: "中原理发店(四惠店)"));
    }
    final SearchDemoSearchDelegate _delegate =
        new SearchDemoSearchDelegate(searchHistory);
    final SearchEntity selected = await showSearch<SearchEntity>(
      context: context,
      delegate: _delegate,
    );
    if (selected != null) {
      Navigator.push(
          context, StoreDetailScreen(selected.id, selected.name).route());
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var imageH = WindowUtils.isIPhoneX(context) ? 180 + 24 : 180;
    var bannerHeight = Platform.isAndroid
        ? WindowUtils.getScreenHeight() * 0.28
        : WindowUtils.getScreenWidth() / 375.0 * imageH;
    return Scaffold(
      appBar: new Toolbar(
        leading: null,
        title: const Text('欢迎'),
        actions: <Widget>[
          new IconButton(
            tooltip: '请输入店铺名称',
            icon: const Icon(Icons.search),
            onPressed: selectStore,
          ),
          new IconButton(
            tooltip: 'More (not implemented)',
            icon: const Icon(Icons.camera_enhance),
            onPressed: () {
              //跳转扫码界面
              //模拟器无法扫码
              String result =
                  "http://www.baidu.com/barber.apk?type=1&store_id=1";
              Uri uri = Uri.parse(result);
              if (result != null) {
                var queryParameters = uri.queryParameters;
                int type = int.parse(queryParameters['type']);
                //扫码付钱
                if (type == 1) {
                  int store_id = int.parse(queryParameters['store_id']);
                  Navigator.push(
                      context, StoreDetailScreen(store_id, "").route());
                }
              }
            },
          ),
        ],
      ),
      body: homeEntity != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new BannerView(
                  data: homeEntity.banners,
                  height: bannerHeight,
                  buildShowView: (int index, data) {
                    return new BannerShowWidget(picUrl: data.picUrl);
                  },
                  onBannerClickListener: (int index, data) {
                    ToastUtils.toast(data.title);
                  },
                ),
                CSDivider(
                  colorHeight: 20.0,
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 18.0),
                  child: Text("最近常去"),
                ),
                homeEntity.activeStoreList == null
                    ? null
                    : Padding(
                        padding: const EdgeInsets.only(top: 28.0, bottom: 20.0),
                        child: Row(
                            children: homeEntity.activeStoreList
                                .map((activeStoreItem) {
                          return Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                    radius: 40.0,
                                    backgroundImage:
                                        new CachedNetworkImageProvider(
                                            activeStoreItem.avatar)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(activeStoreItem.name),
                                ),
                                FlatButton(
                                  color: theme.accentColor,
                                  child: Text(
                                    "进入店铺",
                                    style: new TextStyle(
                                        color: const Color(0xffffffff),
                                        fontSize: 12.0),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        StoreDetailScreen(activeStoreItem.id,
                                                activeStoreItem.name)
                                            .route());
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList()),
                      ),
              ],
            )
          : Text("ing..."),
      floatingActionButton: new FloatingActionButton(
        heroTag: this,
        onPressed: () {
          selectStore();
        },
        tooltip: '排队',
        child: Text("排队"),
      ),
    );
  }
}
