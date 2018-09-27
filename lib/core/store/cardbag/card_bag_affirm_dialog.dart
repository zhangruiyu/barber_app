import 'package:barber_app/core/affirm_pay_password/affirm_pay_password_screen.dart';
import 'package:barber_app/core/paysuccess/entitys/pay_success_entity.dart';
import 'package:barber_app/core/paysuccess/pay_success_screen.dart';
import 'package:barber_app/core/store/cardbag/entitys/pay_card_bag_success_entity.dart';
import 'package:barber_app/core/store/cardbag/pay_card_bag_success_screen.dart';
import 'package:barber_app/core/store/detail/entitys/pay_bag_preview_entity.dart';
import 'package:barber_app/helpers/navigator_helper.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_app/utils/WindowUtils.dart';
import 'package:flutter/material.dart';

class CardBagAffirmDialog extends StatefulWidget {
  final PayBagPreviewEntity payBagPreviewEntity;
  final int cardBagId;
  final BuildContext keepContext;

  CardBagAffirmDialog(
      this.payBagPreviewEntity, this.cardBagId, this.keepContext);

  @override
  _CardBagAffirmDialogState createState() => _CardBagAffirmDialogState();
}

class _CardBagAffirmDialogState extends State<CardBagAffirmDialog> {
  void payMoney(String payPassword) async {
    NavigatorHelper.showLoadingDialog(true);
    RequestHelper.payCardBag(widget.cardBagId, payPassword)
        .then((PayCardBagSuccessEntity onValue) {
      NavigatorHelper.showLoadingDialog(false, () {
        Navigator.pop(widget.keepContext);
        Navigator.push(
            widget.keepContext, PayCardBagSuccessScreen(onValue).route());
      });
    }).catchError((onError) {
      NavigatorHelper.showLoadingDialog(false);
    });
  }

  void showAffirmPayPasswordScreen() {
    Navigator.pop(context);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AffirmPayPasswordScreen(payMoney);
        });
  }

  @override
  Widget build(BuildContext context) {
    var payBagPreviewEntity = widget.payBagPreviewEntity;
    var theme = Theme.of(context);
    return SafeArea(
      bottom: true,
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Container(
                height: 50.0,
                child: new Row(
                  children: <Widget>[
                    new IconButton(
                      onPressed: () {
                        Navigator.canPop(context) && Navigator.pop(context);
                      },
                      icon: Icon(Icons.close),
                    ),
                    new Flexible(
                      child: new Container(
                        padding: const EdgeInsets.only(right: 44.0),
                        child: new Text(
                          "确认购买",
                          style: theme.textTheme.subhead,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      flex: 1,
                      fit: FlexFit.tight,
                    )
                  ],
                )),
            new Divider(
              height: 10.0,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("名称"),
                  Text(
                      "${payBagPreviewEntity.name} ${payBagPreviewEntity.count} 次"),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("可使用次数"),
                  Text("${payBagPreviewEntity.count} 次"),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("用户资金"),
                  Text(payBagPreviewEntity.userMoney.toString() + "元"),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("购买金额"),
                  Text(payBagPreviewEntity.originalMoney.toString() + "元"),
                ],
              ),
            )
          ]
            ..add(Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
              width: WindowUtils.getScreenWidth(),
              child: FlatButton(
                  color: theme.accentColor,
                  onPressed: () {
                    showAffirmPayPasswordScreen();
                  },
                  textColor: Colors.white,
                  child: Text("确认购买")),
            ))
            ..toList(),
        ),
      ),
    );
  }
}
