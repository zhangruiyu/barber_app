import 'package:barber_app/base/BasePageRoute.dart';
import 'package:barber_app/core/main/account/entitys/account_entity.dart';
import 'package:barber_app/core/profile/edit_profile_string_screen.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_app/utils/toast_utils.dart';
import 'package:barber_app/widget/Toolbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends BasePageRoute {
  final UserInfo userInfo;

  ProfileScreen(this.userInfo);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  @override
  String getRouteName() {
    return "ProfileScreen";
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController addressEditingController;
  UserInfo pageCacheUser;

  @override
  void initState() {
    pageCacheUser = UserInfo.fromJson(widget.userInfo.toJson());
    addressEditingController = new TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    addressEditingController.dispose();
  }

  void handleSexRadioValueChanged(int value) {
    setState(() {
      pageCacheUser.gender = value;
    });
  }

  void commitChange() {
    RequestHelper
        .reviseProfile(pageCacheUser.gender, pageCacheUser.nickname,
            pageCacheUser.signature, pageCacheUser.avatar)
        .then((data) {
      ToastUtils.toast('信息修改成功');
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return new Scaffold(
      appBar: new Toolbar(title: new Text('编辑个人信息'), actions: [
        new IconButton(
          icon: const Icon(Icons.send),
          tooltip: '提交修改',
          onPressed: () {
            commitChange();
          },
        )
      ]),
      body: new Column(
        children: [
          new Padding(
            padding: const EdgeInsets.only(bottom: 20.0, top: 30.0),
            child: new CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    new CachedNetworkImageProvider(pageCacheUser.avatar)),
          ),
          ListTile(
            onTap: () async {
              String signature = (await Navigator.push(
                      context,
                      EditProfileStringScreen<String>(
                              pageCacheUser.nickname, "修改昵称", 1, 25)
                          .route())) ??
                  pageCacheUser.nickname;
              setState(() {
                pageCacheUser.nickname = signature;
              });
            },
            title: Text(
              "昵称",
              style: theme.textTheme.caption,
            ),
            subtitle: Text(
              pageCacheUser.nickname,
              style: theme.textTheme.body2,
            ),
          ),
          Divider(
            height: 1.0,
            indent: 20.0,
          ),
          ListTile(
            onTap: () async {
              String signature = (await Navigator.push(
                      context,
                      EditProfileStringScreen<String>(
                              pageCacheUser.signature, "修改个人签名", 4, 255)
                          .route())) ??
                  pageCacheUser.signature;
              setState(() {
                pageCacheUser.signature = signature;
              });
            },
            title: Text(
              "个人签名",
              style: theme.textTheme.caption,
            ),
            subtitle: Text(
              pageCacheUser.signature.isEmpty
                  ? "暂未设置"
                  : pageCacheUser.signature,
              style: theme.textTheme.body2,
            ),
          ),
          Divider(
            height: 1.0,
            indent: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: new Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
              new Icon(Icons.flash_off),
              new Radio(
                  value: 1,
                  groupValue: pageCacheUser.gender,
                  onChanged: handleSexRadioValueChanged),
              new Text('男'),
              new Radio<int>(
                  value: 0,
                  groupValue: pageCacheUser.gender,
                  onChanged: handleSexRadioValueChanged),
              new Text('女'),
            ]),
          ),
          Divider(
            height: 1.0,
            indent: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: new TextField(
              controller: addressEditingController,
              decoration: const InputDecoration(
                  icon: const Icon(Icons.location_on),
                  labelText: '添加居住地,为您匹配最近店铺'),
            ),
          ),
        ],
      ),
    );
  }
}
