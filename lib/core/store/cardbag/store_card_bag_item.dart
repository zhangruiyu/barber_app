import 'package:barber_app/core/paypassword/set_pay_password_screen.dart';
import 'package:barber_app/core/store/cardbag/card_bag_affirm_dialog.dart';
import 'package:barber_app/core/store/detail/entitys/store_detail_entity.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_common/helpers/net_work.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:flutter/material.dart';

class StoreCardBagItem extends StatefulWidget {
  final StoreCardBag storeCardBag;

  StoreCardBagItem(this.storeCardBag);

  @override
  _StoreCardBagItemState createState() => _StoreCardBagItemState();
}

class _StoreCardBagItemState extends State<StoreCardBagItem> {
  void payStoreCardBag(int id) {
    RequestHelper.payStoreCardBag(id).then((onValue) async {
      showModalBottomSheet(
          context: context, builder: (_) {
            return CardBagAffirmDialog(onValue,widget.storeCardBag.id,context);
      });
    }).catchError((onError) {
      if (onError.code == ErrorCode.NO_SET_PAYPASSWROD) {
        Navigator.push(context, SetPayPasswordScreen().route());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var storeCardBag = widget.storeCardBag;
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: WindowUtils.getScreenWidth() / 2.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text("${storeCardBag.name}${storeCardBag.count}次"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("原价"),
                Text(storeCardBag.originalTotalPrice.toString() + "元"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("折扣后价格"),
                Text(storeCardBag.discountTotalPrice.toString() + "元"),
              ],
            ),
            Text("此卡购买后可抵扣${storeCardBag.name}${storeCardBag.count}次"),
            FlatButton(
              color: theme.accentColor,
              textColor: Colors.white,
              child: Text("购买"),
              onPressed: () {
                payStoreCardBag(storeCardBag.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
