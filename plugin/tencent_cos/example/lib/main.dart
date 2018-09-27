import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tencent_cos/tencent_cos.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("abc" + image.path);

    TencentCos.uploadByFile(
        "ap-beijing",
        "1253631018",
        "barber-1253631018",
        "AKIDkfeoNDD81j3V577NyRjXb4fEIg0dB1gx",
        "0M1GEBuPBY4lHCIa64V4j12Gg2PJJKx4",
        "5e5eea7edfebaef7176a95be9b4b4123163ace2d30001",
        "1538044424",
        "pic/dynamic/video_dynamic/1/4.png",
        image.path);
    TencentCos.setMethodCallHandler(_handleMessages);
  }

  Future<Null> _handleMessages(MethodCall call) async {
    print(call.method);
    print(call.arguments);
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Center(
          child: new Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
