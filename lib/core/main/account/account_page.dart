import 'package:barber_app/core/main/account/entitys/account_entity.dart';
import 'package:barber_app/core/main/account/item_entitys.dart';
import 'package:barber_app/core/main/home/i_refresh.dart';
import 'package:barber_app/core/main/home_tab_screen.dart';
import 'package:barber_app/core/passwordmanager/password_manager_screen.dart';
import 'package:barber_app/core/paylist/pay_list_screen.dart';
import 'package:barber_app/core/profile/profile_screen.dart';
import 'package:barber_app/core/setting/setting_screen.dart';
import 'package:barber_app/core/wallet/wallet_screen.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_app/helpers/user_helper.dart';
import 'package:barber_app/models/app_state.dart';
import 'package:barber_app/styles/color_style.dart';
import 'package:barber_app/styles/text_style.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:barber_common/widget/divider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

final List<HomeItemWidget> loginIconList = <HomeItemWidget>[
  new HomeItemWidget(url: "phone.png", type: "tel"),
  new HomeItemWidget(url: "ic_qq_login.webp", type: "qq"),
];

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with RefreshPage {
  AccountEntity accountEntity;

  @override
  void refreshPage() {
    RequestHelper.refreshAccount().then((onValue) {
      setState(() {
        accountEntity = onValue;
      });
    }).catchError((onError) {});
  }

  @override
  void initState() {
    HomeTabScreenState.tabStates[2] = this;
    refreshPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreBuilder<AppState>(
      builder: (context, store) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              accountEntity == null || store.state.currentUser == null
                  ? Container(
                      decoration: BoxDecoration(
                          color: accountNoLoginBg,
                          borderRadius: BorderRadius.circular(3.0)),
                      margin: const EdgeInsets.all(12.0),
                      padding: new EdgeInsets.only(
                          top: WindowUtils.isIPhoneX(context) ? 54.0 : 0.0),
                      child: new Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: new Text(
                              "登陆小助手,体验更多功能",
                              style: textStyle,
                            ),
                          ),
                          new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  loginIconList.map((HomeItemWidget loginIcon) {
                                return new Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10.0, 20.0, 10.0, 20.0),
                                    child: new GestureDetector(
                                      onTap: () {
                                        if (loginIcon.type == "tel") {
                                          Navigator.pushNamed(context, "/auto");
                                        }
                                        /*  LoginPage
                                      .start(context, {'cbk': widget.props['cbk']});*/
                                      },
                                      child: new Image.asset(
                                        'assets/${loginIcon.url}',
                                        width: 40.0,
                                        height: 40.0,
                                      ),
                                    ));
                              }).toList()),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: CachedNetworkImageProvider(
                                  "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1658705104,2007766312&fm=27&gp=0.jpg"))),
                      padding: new EdgeInsets.only(
                          top: WindowUtils.isIPhoneX(context) ? 84.0 : 68.0,
                          bottom: 40.0,
                          left: 12.0,
                          right: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              ProfileScreen(accountEntity.userInfo).route());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  height: 60.0,
                                  width: 60.0,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        new CachedNetworkImageProvider(
                                      accountEntity.userInfo.avatar,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 18.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        accountEntity.userInfo.nickname,
                                        style: whiteTitleStyle20,
                                      ),
                                      accountEntity
                                              .userInfo.signature.isNotEmpty
                                          ? Text(
                                              accountEntity.userInfo.signature,
                                              style: whiteTitleStyle14,
                                            )
                                          : null
                                    ].where((o) => o != null).toList(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  "个人资料",
                                  style: whiteTitleStyle14,
                                ),
                                new Icon(
                                  Icons.arrow_right,
                                  color: Colors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
              accountEntity == null
                  ? null
                  : ListTile(
                      onTap: () {
                        UserHelper.loginChecked(context, () {
                          Navigator.of(context)
                              .push(new WalletScreen().route());
                        });
                      },
                      title: Text("账户余额"),
                      subtitle: Text("可用于消费和提现"),
                      trailing: Text("19900元"),
                      leading: Icon(Icons.attach_money),
                    ),
              accountEntity == null
                  ? null
                  : ListTile(
                      onTap: () {
                        UserHelper.loginChecked(context, () {
                          Navigator.of(context)
                              .push(new WalletScreen().route());
                        });
                      },
                      title: Text("卡包"),
                      subtitle: Text("可用于抵扣消费"),
                      trailing: Text("${accountEntity.cardBagCount}张可用"),
                      leading: Icon(Icons.account_balance_wallet),
                    ),
              CSDivider(
                colorHeight: 20.0,
                height: 20.0,
              ),
              ListTile(
                title: Text("消费记录"),
                enabled: true,
                leading: Icon(Icons.view_list),
                onTap: () {
                  UserHelper.loginChecked(context, () {
                    Navigator.of(context).push(new PayListScreen().route());
                  });
                },
              ),
              CSDivider(
                colorHeight: 20.0,
                height: 20.0,
              ),
              ListTile(
                title: Text("安全中心"),
                enabled: true,
                leading: Icon(Icons.adjust),
                onTap: () {
                  UserHelper.loginChecked(context, () {
                    Navigator.of(context)
                        .push(new PasswordManagerScreen().route());
                  });
                },
              ),
              ListTile(
                title: Text("设置"),
                enabled: true,
                leading: Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).push(new SettingScreen().route());
                },
              ),
            ].where((o) => o != null).toList(),
          ),
        );
      },
    );
  }
}
