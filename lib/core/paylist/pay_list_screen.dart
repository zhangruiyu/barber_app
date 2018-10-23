import 'dart:async';

import 'package:barber_app/base/BasePageRoute.dart';
import 'package:barber_app/core/paylist/entitys/pay_list_entity.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_common/widget/StatePageState.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:barber_common/widget/divider.dart';
import 'package:flutter/material.dart';
import 'package:refresh_wow/refresh_wow.dart';

class PayListScreen extends BasePageRoute {
  @override
  _PayListScreenState createState() => _PayListScreenState();

  @override
  String getRouteName() {
    return "PayListScreen";
  }
}

class _PayListScreenState extends State<PayListScreen> {
  var localList = [];
  var hasMore = false;
  var pageIndex = 0;
  final GlobalKey<RefreshListViewState> refreshListViewStateKey =
      new GlobalKey<RefreshListViewState>();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<Null> _handleRefresh() {
    pageIndex = 0;
    return _fetchData().then((_) {
      return new Future<Null>.value(null);
    });
  }

  Future<Null> _handleLoadMore() {
    return _fetchData().then((_) {
      return new Future<Null>.value(null);
    });
  }

  Future<dynamic> _fetchData() {
    final Completer<dynamic> completer = new Completer<dynamic>();

    RequestHelper.expenseCalendar(pageIndex).then((List<PayListEntity> data) {
      completer.complete(data);
      if (pageIndex == 0) {
        localList = data;
      } else {
        localList.addAll(data);
      }
      ++pageIndex;
      hasMore = (data).length >= 10;
      refreshListViewStateKey.currentState
          ?.setData(localList, hasMore ? _handleLoadMore : null);
    }).catchError((onError) {
      completer.complete(null);
    });
    return completer.future;
  }

  Future<List<PayListEntity>> payList() async {
    final Completer<List<PayListEntity>> completer =
        new Completer<List<PayListEntity>>();
    RequestHelper.expenseCalendar(0).then((List<PayListEntity> onValue) {
      completer.complete(onValue);
    }).catchError((onError) {
      completer.complete(null);
    });

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: Toolbar(
          title: Text("消费记录"),
        ),
        body: StatePage(
          loadData: payList,
          buildContent: (data) {
            var storeList = data as List<PayListEntity>;
            return ListView.builder(
              itemCount: storeList.length,
              itemBuilder: (BuildContext context, int index) {
                List<ExpenseCalendar> storeCardBagList =
                    storeList[index].expenseCalendar;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(top: 8.0),
                      child: Text(storeList[index].createTime),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                          color: Colors.grey),
                    ),
                  ]..addAll(storeCardBagList.map((item) {
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.subtitle),
                        trailing: Text(item.trailing),
                      );
                    }).toList()),
                );
              },
            );
          },
        ));
  }
}
