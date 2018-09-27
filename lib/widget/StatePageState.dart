import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef Widget ContentBuild<T>(T value);

class StatePage extends StatefulWidget {
  final Function loadData;
  final ContentBuild<dynamic> buildContent;
  final String noDataText;
  final String noDataImg;

  StatePage({
    @required this.loadData,
    @required this.buildContent,
    this.noDataText,
    this.noDataImg,
  });

  @override
  _StatePageState createState() => new _StatePageState();
}

class _StatePageState extends State<StatePage> {
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<dynamic>(
        future: widget.loadData(),
        initialData:
            new AsyncSnapshot<String>.withData(ConnectionState.waiting, null),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.connectionState);
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data;
            //错误了
            if (data == null) {
              return new Center(
                child: new GestureDetector(
                  onTap: () {
                    setState(() {});
                  },
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.sms_failed),
                      new Text('数据获取失败,点击重试'),
                    ],
                  ),
                ),
              );
            } else {
              if (data is List && data.length == 0) {
                return new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Icon(Icons.data_usage),
                      new Text(widget.noDataText ?? '暂无记录'),
                    ],
                  ),
                );
              } else {
                return widget.buildContent(snapshot.data);
              }
            }
          } else {
            return new Text('别着急');
          }
        });
  }
}
