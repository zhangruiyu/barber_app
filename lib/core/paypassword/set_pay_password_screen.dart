import 'package:barber_app/base/BasePageRoute.dart';
import 'package:barber_app/core/store/detail/entitys/store_detail_entity.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_common/utils/toast_utils.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SetPayPasswordScreen extends BasePageRoute {
  @override
  _SetPayPasswordScreenState createState() => _SetPayPasswordScreenState();

  @override
  String getRouteName() {
    return "SetPayPasswordScreen";
  }
}

class _SetPayPasswordScreenState extends State<SetPayPasswordScreen> {
  TextEditingController strEditingController;

  @override
  void initState() {
    strEditingController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    strEditingController.dispose();
  }

  void setPayPassword() {
    RequestHelper.setPayPassword(strEditingController.text).then((onValue) {
      ToastUtils.toast("支付密码设置成功");
      Navigator.pop(context);
    }).catchError((onError) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: Text("设置支付密码"),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.send),
            onPressed: setPayPassword,
          ),
        ],
      ),
      body: new Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: new TextField(
            autofocus: true,
            keyboardType: TextInputType.phone,
            controller: strEditingController,
            decoration: new InputDecoration(
              border: const OutlineInputBorder(),
              labelText: "支付密码",
            ),
            maxLines: 1,
            maxLength: 6,
            onChanged: (str) {
              print(str);
            },
          )),
    );
  }
}
