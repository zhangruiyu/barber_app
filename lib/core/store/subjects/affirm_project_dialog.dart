import 'package:barber_app/core/affirm_pay_password/affirm_pay_password_screen.dart';
import 'package:barber_app/core/paypassword/set_pay_password_screen.dart';
import 'package:barber_app/core/paysuccess/entitys/pay_success_entity.dart';
import 'package:barber_app/core/paysuccess/pay_success_screen.dart';
import 'package:barber_app/core/store/subjects/entitys/affirm_dialog_show_entity.dart';
import 'package:barber_app/helpers/navigator_helper.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:flutter/material.dart';

class AffirmProjectDialog extends StatefulWidget {
  final AffirmDialogShowEntity affirmDialogShowEntity;
  final BuildContext keepContext;

  AffirmProjectDialog(this.affirmDialogShowEntity, this.keepContext);

  @override
  _AffirmProjectDialogState createState() => _AffirmProjectDialogState();
}

class _AffirmProjectDialogState extends State<AffirmProjectDialog> {
  void payMoney(String paypassword) {
    NavigatorHelper.showLoadingDialog(true);
    RequestHelper.payByIndent(widget.affirmDialogShowEntity.selectResult,
            widget.affirmDialogShowEntity.storeId.toString(), paypassword)
        .then((PaySuccessEntity onValue) {
      NavigatorHelper.showLoadingDialog(false, () {
        NavigatorHelper.popToMain(widget.keepContext);
        Navigator.push(widget.keepContext, PaySuccessScreen(onValue).route());
      });
    }).catchError((onError) {
      NavigatorHelper.showLoadingDialog(false, () {
        if (onError.code == 1005) {
          Navigator.push(context, SetPayPasswordScreen().route());
        }
      });
    });
  }

  void showAffirmPayPasswordScreen() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return AffirmPayPasswordScreen(payMoney);
        });
  }

  @override
  Widget build(BuildContext context) {
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
          ]
            ..add(SizedBox(
              height: WindowUtils.getScreenHeight() * 0.3,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var projectNames =
                      widget.affirmDialogShowEntity.projectNames[index];
                  return ListTile(
                    title: Text(projectNames.title),
                    subtitle: Text(projectNames.subtitle),
                    trailing: Text(projectNames.trailing),
                  );
                },
                itemCount: widget.affirmDialogShowEntity.projectNames.length,
              ),
            ))
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
                  child: Text(
                      "确认购买:${widget.affirmDialogShowEntity.totalMoney}元")),
            ))
            ..toList(),
        ),
      ),
    );
  }
}
