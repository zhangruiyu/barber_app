import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_app/core/main/account/entitys/account_entity.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EditProfileStringScreen<X> extends BasePageRoute<X> {
  final String userInfo;
  final String title;
  final int maxLines;
  final int maxLength;

  EditProfileStringScreen(
      this.userInfo, this.title, this.maxLines, this.maxLength);

  @override
  _EditProfileStringScreenState createState() =>
      _EditProfileStringScreenState();

  @override
  String getRouteName() {
    return "EditProfileStringScreen";
  }
}

class _EditProfileStringScreenState extends State<EditProfileStringScreen> {
  TextEditingController strEditingController;

  @override
  void initState() {
    strEditingController = TextEditingController(text: widget.userInfo);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    strEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new Toolbar(title: new Text(widget.title), actions: [
        new IconButton(
          icon: const Icon(Icons.send),
          tooltip: '完成',
          onPressed: () {
            Navigator.pop(context, strEditingController.text);
          },
        )
      ]),
      body: new Container(
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
          child: new TextFormField(
            controller: strEditingController,
            decoration: new InputDecoration(
              border: const OutlineInputBorder(),
              labelText: widget.title,
            ),
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
          )),
    );
  }
}
