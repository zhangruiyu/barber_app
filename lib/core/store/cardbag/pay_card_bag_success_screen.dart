import 'package:barber_app/base/BasePageRoute.dart';
import 'package:barber_app/core/paylist/pay_list_screen.dart';
import 'package:barber_app/core/store/cardbag/entitys/pay_card_bag_success_entity.dart';
import 'package:barber_app/helpers/navigator_helper.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:flutter/material.dart';

class PayCardBagSuccessScreen extends BasePageRoute {
  final PayCardBagSuccessEntity payCardBagSuccessEntity;

  PayCardBagSuccessScreen(this.payCardBagSuccessEntity);

  @override
  _PayCardBagSuccessScreenState createState() =>
      _PayCardBagSuccessScreenState();

  @override
  String getRouteName() {
    return "PayCardBagSuccessScreen";
  }
}

class _PayCardBagSuccessScreenState extends State<PayCardBagSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var payCardBagSuccessEntity = widget.payCardBagSuccessEntity;
    return Scaffold(
      appBar: Toolbar(
        title: Text("购买成功"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 38.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("购买结果"),
                    Text(payCardBagSuccessEntity.message.toString()),
                  ],
                ),
              )
            ]
              ..addAll(payCardBagSuccessEntity.projectNames.map((projectNames) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 38.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(projectNames.name),
                      Text(projectNames.money.toString()),
                    ],
                  ),
                );
              }))
              ..add(Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 38.0, right: 10.0),
                        width: WindowUtils.getScreenWidth(),
                        child: FlatButton(
                            color: theme.accentColor,
                            onPressed: () {
                              NavigatorHelper.popToMain(context);
                              Navigator.of(context)
                                  .push(PayListScreen().route());
                            },
                            textColor: Colors.white,
                            child: Text("查看消费记录")),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 38.0),
                        width: WindowUtils.getScreenWidth(),
                        child: FlatButton(
                            color: theme.accentColor,
                            onPressed: () {
                              NavigatorHelper.popToMain(context);
                              Navigator.of(context)
                                  .push(PayListScreen().route());
                            },
                            textColor: Colors.white,
                            child: Text("查看我的卡包")),
                      ),
                    )
                  ],
                ),
              ))
              ..toList(),
          ),
        ),
      ),
    );
  }
}
