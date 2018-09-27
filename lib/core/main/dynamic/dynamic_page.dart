import 'package:barber_app/core/main/home/i_refresh.dart';
import 'package:barber_app/core/main/home_tab_screen.dart';
import 'package:flutter/material.dart';

class DynamicPage extends StatefulWidget {
  @override
  _DynamicPageState createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> with RefreshPage {
  @override
  void initState() {
    HomeTabScreenState.tabStates[1] = this;
    super.initState();
  }

  @override
  void refreshPage() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text("社区"),
        elevation: 0.0,
      ),
      body: Container(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: '发布动态',
        child: const Icon(Icons.add),
      ),
    );
  }
}
