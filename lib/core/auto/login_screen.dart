import 'package:barber_app/core/auto/auto_page_model.dart';
import 'package:barber_app/core/auto/login_page.dart';
import 'package:barber_app/core/auto/register_page.dart';
import 'package:barber_common/styles/color_style.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AutoPageShowModel autoPageShowModel = AutoPageShowModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ScopedModel<AutoPageShowModel>(
      model: autoPageShowModel,
      child: Scaffold(
        body: Container(
          width: WindowUtils.getScreenWidth(),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("assets/auto_bg.jpg")),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: new EdgeInsets.only(
                    top: WindowUtils.getScreenHeight() * 0.1,
                    bottom: WindowUtils.getScreenHeight() * 0.04),
                child: Text("Welcome",
                    style: theme.textTheme.display1
                        .merge(TextStyle(color: Colors.white))),
              ),
              Text("Reasonable arrangement of time",
                  style: theme.textTheme.subhead
                      .merge(TextStyle(color: Colors.white))),
              Padding(
                padding: new EdgeInsets.only(
                    top: 10.0, bottom: WindowUtils.getScreenHeight() * 0.04),
                child: Text("is to save time",
                    style: theme.textTheme.subhead
                        .merge(TextStyle(color: Colors.white))),
              ),
              Container(
                  width: WindowUtils.getScreenWidth() - 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3.0),
                      border: Border.all(color: autoBorder),
                      color: autoContent),
                  child: ScopedModelDescendant<AutoPageShowModel>(
                      builder: (context, widget, model) {
                        if (model.currentPageName == "LoginPage") {
                          return LoginPage(
                              model: model,
                              width: WindowUtils.getScreenWidth() - 80);
                        }
                        return RegisterPage(
                            model: model,
                            width: WindowUtils.getScreenWidth() - 80);
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
