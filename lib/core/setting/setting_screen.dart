import 'package:barber_app/base/BasePageRoute.dart';
import 'package:barber_app/models/app_state.dart';
import 'package:barber_app/reducers/auth_redux.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SettingScreen extends BasePageRoute {
  static const String routeName = '/SettingPage';

  @override
  String getRouteName() {
    return routeName;
  }

  @override
  State<StatefulWidget> createState() => new SettingPageState();
}

class SettingPageState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var edgeInsets = new EdgeInsets.only(top: 10.0);
    const textStyle = const TextStyle();
    return new StoreBuilder<AppState>(builder: (context, store) {
      var currentUser = store.state.currentUser;
      return new Scaffold(
          appBar: new Toolbar(
            title: new Text('设置'),
          ),
          body: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.only(top: 40.0),
                color: const Color(0xffffffff),
                child: new Column(children: <Widget>[
                  new Image.asset(
                    'assets/ic_qq_login.webp',
                    width: 40.0,
                    height: 40.0,
                  ),
                  new Padding(
                    padding: edgeInsets,
                    child: new Text('版本号: v1.0.0'),
                  ),
                  new Padding(
                    padding: edgeInsets,
                    child: new Text('QQ服务群: 609487304'),
                  ),
                  new Padding(
                    padding: edgeInsets,
                    child: new Text('如有建议和问题,请加入群反馈'),
                  ),
                  ListTile(
                      enabled: true,
                      onTap: () {
                        ToastUtils.toast("个人开发者,如有合作,请加入qq群反馈");
                      },
                      title: new Text(
                        '关于我们',
                        style: textStyle,
                      ),
                      trailing: new Icon(Icons.arrow_right)),
                  ListTile(
                      enabled: true,
                      onTap: () {
                        print("aaa");
                      },
                      title: new Text(
                        '版本更新',
                        style: textStyle,
                      ),
                      trailing: new Icon(Icons.arrow_right))
                  // onSubmitted：当用户在键盘上点击完成编辑时调用
                ]),
              ),
              currentUser == null
                  ? null
                  : new FlatButton(
                      padding: new EdgeInsets.only(
                          bottom: WindowUtils.isIPhoneX(context) ? 26.0 : 0.0),
                      child: new SizedBox(
                          width: WindowUtils.getScreenWidth(),
                          height: 45.0,
                          child: new Center(
                            child: new Text(
                              '退出登录',
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  color: const Color(0xffffffff),
                                  fontSize: 18.0),
                            ),
                          )),
                      onPressed: () async {
                        store.dispatch(LogOutSuccessful());
                        Navigator.of(context).pop();
                      },
                      color: Theme.of(context).accentColor,
                    ),
            ].where((Object o) => o != null).toList(),
          ));
    });
  }
}
