import 'dart:async';

import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_app/core/wallet/entitys/wallet_entity.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_common/widget/StatePageState.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:flutter/material.dart';

class WalletScreen extends BasePageRoute {
  @override
  _WalletScreenState createState() => _WalletScreenState();

  @override
  String getRouteName() {
    return "WalletScreen";
  }
}

class _WalletScreenState extends State<WalletScreen> {
  Future<List<WalletEntity>> walletList() async {
    final Completer<List<WalletEntity>> completer =
        new Completer<List<WalletEntity>>();
    RequestHelper.walletList().then((List<WalletEntity> onValue) {
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
          title: Text("我的卡包"),
        ),
        body: StatePage(
          loadData: walletList,
          buildContent: (data) {
            var storeList = data as List<WalletEntity>;
            return ListView.builder(
              itemCount: storeList.length,
              itemBuilder: (BuildContext context, int index) {
                var storeCardBagList = storeList[index].cardBagList;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(top: 8.0),
                      child: Text(storeList[index].storeName),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              topRight: Radius.circular(20.0)),
                          color: Colors.grey),
                    ),
                  ]..addAll(storeCardBagList.map((item) {
                      return ExpansionTile(
                        backgroundColor: theme.dividerColor,
                        children: item.record.map((record) {
                          return ListTile(
                            title: Text(
                              record.projectName,
                            ),
                            trailing: Text(
                              "消费次数:X${record.cardBagCount.toString()}",
                            ),
                            subtitle: Text(
                              record.createTime.toString()
                              ,style: theme.textTheme.caption,
                            ),
                          );
                        }).toList(),
                        title: Text(item.name),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("剩余:x${item.count}次"),
                            Text("购买于:${item.createTime}",style: theme.textTheme.caption,),
                          ],
                        ),
                      );
                    }).toList()),
                );
              },
            );
          },
        ));
  }
}
