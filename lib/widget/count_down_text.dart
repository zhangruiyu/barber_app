import 'package:flutter/material.dart';

class CountDownText extends StatefulWidget {
  const CountDownText({Key key}) : super(key: key);

  @override
  CountDownTextState createState() => CountDownTextState();
}

class CountDownTextState extends State<CountDownText> {
  String text = "发送验证码";

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      text,
      style: theme.textTheme.body1.merge(TextStyle(color: Colors.white)),
    );
  }

  void setText(int countDown) {
    setState(() {
      if (countDown <= 0) {
        text = "发送验证码";
      } else {
        text = "$countDown秒";
      }
    });
  }
}
