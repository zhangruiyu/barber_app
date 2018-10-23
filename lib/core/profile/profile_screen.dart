import 'dart:async';
import 'dart:io';
import 'package:barber_common/helpers/navigator_helper.dart';
import 'package:barber_common/helpers/request_helper.dart';
import 'package:path/path.dart' as file;

import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_app/core/main/account/entitys/account_entity.dart';
import 'package:barber_app/core/profile/edit_profile_string_screen.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:tencent_cos/tencent_cos.dart';

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
  File avatarLocalPath;

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

  void uploadAvatar() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      //需要压缩
      if (image.lengthSync() > 200 * 1000) {
        //控制在200kb
        avatarLocalPath =
        (await FlutterNativeImage.compressImage(image.path, quality: image.lengthSync()~/(200*1000)));
      }else{
        image = avatarLocalPath;
      }

    }
  }

  Future<Null> _handleMessages(MethodCall call) async {
    print(call.method);
    print(call.arguments);
    if (call.method == "onProgress") {
    } else if (call.method == "onFailed") {
      ToastUtils.toast('头像上传失败');
      NavigatorHelper.showLoadingDialog(false);
    } else if (call.method == "onSuccess") {
      commitChange(call.arguments['cosPath']);
    }
  }

  void handleSexRadioValueChanged(int value) {
    setState(() {
      pageCacheUser.gender = value;
    });
  }

  //检测是否有头像
  void checkAvatarChange() {
    NavigatorHelper.showLoadingDialog(true);
    if (avatarLocalPath != null) {
      String extension = file.extension(avatarLocalPath.path);
      RequestHelperCommon.periodEffectiveSign(2).then((cos) {
        TencentCos.uploadByFile(
            "ap-beijing",
            "1253631018",
            "barber-1253631018",
            cos.tmpSecretId,
            cos.tmpSecretKey,
            cos.sessionToken,
            cos.expiredTime,
            "${cos.cosPath}avatar$extension",
            avatarLocalPath.path);
        TencentCos.setMethodCallHandler(_handleMessages);
      }).catchError((err) {
        NavigatorHelper.showLoadingDialog(false);
      });
    } else {
      commitChange();
    }
  }

  void commitChange([String avatarUrl]) {
    RequestHelper.reviseProfile(pageCacheUser.gender, pageCacheUser.nickname,
            pageCacheUser.signature, avatarUrl ?? "")
        .then((data) {
      avatarLocalPath?.deleteSync();
      NavigatorHelper.showLoadingDialog(false, () {
        Navigator.pop(context);
      });
      ToastUtils.toast('信息修改成功');
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
            checkAvatarChange();
          },
        )
      ]),
      body: new Column(
        children: [
          new Padding(
            padding: const EdgeInsets.only(bottom: 20.0, top: 30.0),
            child: GestureDetector(
              onTap: () {
                uploadAvatar();
              },
              child: new CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                      new CachedNetworkImageProvider(pageCacheUser.avatar)),
            ),
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
