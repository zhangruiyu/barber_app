import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_app/core/paylist/pay_list_screen.dart';
import 'package:barber_app/core/paysuccess/entitys/pay_success_entity.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:flutter/material.dart';

class PaySuccessScreen extends BasePageRoute {
  final PaySuccessEntity paySuccessEntity;

  PaySuccessScreen(this.paySuccessEntity);

  @override
  _PaySuccessScreenState createState() => _PaySuccessScreenState();

  @override
  String getRouteName() {
    return "PaySuccessScreen";
  }
}

class _PaySuccessScreenState extends State<PaySuccessScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: Toolbar(
        title: Text("购买成功"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 38.0),
          child: Column(
            children: <Widget>[]
              ..addAll(widget.paySuccessEntity.projectNames.map((projectNames) {
                return ListTile(
                  title: Text(projectNames.title),
                  subtitle: projectNames.subtitle.isEmpty
                      ? null
                      : Text(projectNames.subtitle),
                  trailing: Text(projectNames.trailing),
                );
              }))
              ..add(Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 38.0, vertical: 38.0),
                width: WindowUtils.getScreenWidth(),
                child: FlatButton(
                    color: theme.accentColor,
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).push(PayListScreen().route());
                    },
                    textColor: Colors.white,
                    child: Text("查看消费记录")),
              ))
              ..toList(),
          ),
        ),
      ),
    );
  }
}
