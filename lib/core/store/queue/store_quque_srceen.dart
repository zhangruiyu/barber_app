import 'dart:async';

import 'package:barber_app/base/BasePageRoute.dart';
import 'package:barber_app/core/store/queue/entitys/add_store_queue_entity.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:flutter/material.dart';

class StoreQuqueScreen extends BasePageRoute {
  final int storeId;

  final String name;

  StoreQuqueScreen(this.storeId, this.name);

  @override
  _StoreQuqueScreenState createState() => _StoreQuqueScreenState();

  @override
  String getRouteName() {
    return "StoreQuqueSrceen";
  }
}

class _StoreQuqueScreenState extends State<StoreQuqueScreen> {
  AddStoreQueueEntity addStoreQueueEntity;
  Timer timer;

  @override
  void initState() {
    requestQueue();
    super.initState();
    timer = new Timer.periodic(new Duration(seconds: 10), (timer) {
      requestQueue();
    });
  }

  requestQueue() {
    RequestHelper
        .addStoreQueue(widget.storeId, widget.name)
        .then((AddStoreQueueEntity onValue) {
      setState(() {
        addStoreQueueEntity = onValue;
      });
    }).catchError((onError) {});
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: Toolbar(title: Text("预约大厅"), actions: <Widget>[
        new IconButton(
          tooltip: 'Search',
          icon: const Icon(Icons.refresh),
          onPressed: () async {
            requestQueue();
          },
        ),
      ]),
      body: SafeArea(
        child: addStoreQueueEntity == null
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          var itemQueueUp =
                              addStoreQueueEntity.allQueueUp[index];
                          var isShowSubtitle =
                              index == addStoreQueueEntity.currentIndex ||
                                  index == 0;
                          return ListTile(
                              selected:
                                  index == addStoreQueueEntity.currentIndex,
                              title: Text(itemQueueUp.serverName),
                              subtitle: isShowSubtitle
                                  ? Text(
                                      (index == addStoreQueueEntity.currentIndex
                                              ? "(我)"
                                              : "") +
                                          (index == 0 ? "(正在进行消费)" : ""))
                                  : null,
                              trailing:
                                  Text("开始排队时间\n${itemQueueUp.createTime}"));
                        },
                        itemCount: addStoreQueueEntity.allQueueUp.length,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 28.0, bottom: 18.0),
                      child: Text(
                        "一共  ${addStoreQueueEntity.allQueueUpCount}  人正在排队",
                        style: theme.textTheme.subhead,
                      ),
                    ),
                    Text("您当前在  ${addStoreQueueEntity.currentIndex + 1}  位",
                        style: theme.textTheme.subhead),
                  ],
                ),
              ),
      ),
    );
  }
}
