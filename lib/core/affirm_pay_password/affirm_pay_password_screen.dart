import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_app/core/paypassword/reset_pay_password_screen.dart';
import 'package:flutter/material.dart';

class AffirmPayPasswordScreen extends BasePageRoute {
  final void Function(String payPassword) payMoney;

  AffirmPayPasswordScreen(this.payMoney);

  @override
  _AffirmPayPasswordScreenState createState() =>
      _AffirmPayPasswordScreenState();

  @override
  String getRouteName() {
    return "AffirmPayPasswordScreen";
  }
}

class _AffirmPayPasswordScreenState extends State<AffirmPayPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SafeArea(
      bottom: true,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
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
                          "输入支付密码",
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
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 18.0),
              child: TextField(
                autofocus: true,
                obscureText: true,
                decoration: new InputDecoration(
                  border: const OutlineInputBorder(),
                ),
                maxLength: 6,
                keyboardType: TextInputType.number,
                onChanged: (str) {
                  if (str.length == 6) {
                    widget.payMoney(str);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 28.0, top: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, ResetPayPasswordScreen().route());
                },
                child: Text(
                  "忘记密码",
                  style: theme.textTheme.body1
                      .merge(TextStyle(color: theme.accentColor)),
                ),
              ),
            )
          ]..toList(),
        ),
      ),
    );
  }
}
