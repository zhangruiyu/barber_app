import 'dart:async';

import 'package:banner/banner.dart';
import 'package:barber_app/core/pay/store_project.dart';
import 'package:barber_app/core/store/cardbag/store_card_bag_item.dart';
import 'package:barber_app/core/store/detail/entitys/store_detail_entity.dart';
import 'package:barber_app/core/store/queue/store_quque_srceen.dart';
import 'package:barber_app/core/store/subjects/subjects_screen.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_common/base/BasePageRoute.dart';
import 'package:barber_common/utils/WindowUtils.dart';
import 'package:barber_common/widget/BannerShowWidget.dart';
import 'package:barber_common/widget/StatePageState.dart';
import 'package:barber_common/widget/Toolbar.dart';
import 'package:barber_common/widget/divider.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class StoreDetailScreen extends BasePageRoute {
  final int storeId;

  final String name;

  StoreDetailScreen(this.storeId, this.name);

  @override
  _StoreDetailSrceenState createState() => _StoreDetailSrceenState();

  @override
  String getRouteName() {
    return "StoreDetailScreen";
  }
}

class _StoreDetailSrceenState extends State<StoreDetailScreen> {
  Timer timer;

  @override
  void initState() {
    requestStoreDetail();
    super.initState();
    /* timer = new Timer.periodic(new Duration(seconds: 10), (timer) {
      requestQueue();
    });*/
  }

  Future<StoreDetailEntity> requestStoreDetail() {
    final Completer<StoreDetailEntity> completer =
        new Completer<StoreDetailEntity>();
    RequestHelper.storeDetail(widget.storeId).then((StoreDetailEntity onValue) {
      completer.complete(onValue);
    }).catchError((onError) {
      completer.complete(null);
    });
    return completer.future;
  }

  void selectSubjectPay(Subtypes itemProject) {
    RequestHelper.getStoreAllProject(widget.storeId).then((onValue) async {
      //跳转到选择页面
      Navigator.push(context, SubjectsScreen(onValue, itemProject).route());
    }).catchError((onError) {});
  }

  void selectProjectToQueue(StoreDetailEntity storeDetailEntity) {
    if (storeDetailEntity.queueCurrentIndex == -1) {
      RequestHelper.getStoreAllProject(widget.storeId).then((onValue) async {
        //跳转到选择项目页面
        var projectName = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: onValue.allProject.map((storeProject) {
                    return ListTile(
                      enabled: true,
                      onTap: () {
                        Navigator.pop(context, storeProject.name);
                      },
                      title: Text(storeProject.name),
                    );
                  }).toList(),
                ),
              );
            });
        addStoreQueue(widget.storeId, projectName);
      }).catchError((onError) {});
    } else {
      addStoreQueue(widget.storeId, "");
    }
  }

  Future addStoreQueue(int storeId, String projectName) async {
    await Navigator.push(
        context, StoreQuqueScreen(storeId, projectName).route());
    requestStoreDetail();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bannerHeight = WindowUtils.getScreenHeight() * 0.24;
    var theme = Theme.of(context);
    return Scaffold(
        appBar: Toolbar(title: Text(widget.name), actions: <Widget>[
          new IconButton(
            tooltip: '分享',
            icon: const Icon(Icons.share),
            onPressed: () async {
              Share.share('check out my website https://example.com');
            },
          ),
        ]),
        body: StatePage(
          loadData: requestStoreDetail,
          buildContent: (data) {
            var storeDetailEntity = data as StoreDetailEntity;
            return SingleChildScrollView(
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new BannerView(
                        data: [storeDetailEntity.storeInfo.avatar],
                        height: bannerHeight,
                        buildShowView: (int index, data) {
                          return new BannerShowWidget(picUrl: data);
                        },
                        onBannerClickListener: (int index, data) {},
                      ),
                      ListTile(
                        title: Text(storeDetailEntity.storeInfo.name),
                        subtitle: Text(
                            "创建时间   ${storeDetailEntity.storeInfo.createTime}"),
                      ),
                      FlatButton.icon(
                        icon: Icon(
                          Icons.location_on,
                          size: 20.0,
                          color: Colors.black54,
                        ),
                        onPressed: () {},
                        label: Text(
                          storeDetailEntity.storeInfo.address,
                          style: theme.textTheme.body2,
                        ),
                      ),
                      ListTile(
                        title:
                            Text("预约人数一共${storeDetailEntity.allQueueUpCount}人"),
                        subtitle: Text(storeDetailEntity.queueCurrentIndex == -1
                            ? "请点击右侧按钮预约"
                            : "您当前正在第${storeDetailEntity.queueCurrentIndex}位"),
                        trailing: FlatButton(
                          color: theme.accentColor,
                          textColor: Colors.white,
                          child: Text("去预约"),
                          onPressed: () {
                            selectProjectToQueue(storeDetailEntity);
                          },
                        ),
                      ),
                      storeDetailEntity.storeCardBag.isEmpty
                          ? null
                          : CSDivider(
                              colorHeight: 20.0,
                              height: 20.0,
                            ),
                      storeDetailEntity.storeCardBag.isEmpty
                          ? null
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "次卡",
                                    style: theme.textTheme.subhead,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Text(
                                      "可用于抵扣消费",
                                      style: theme.textTheme.body1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      storeDetailEntity.storeCardBag.isEmpty
                          ? null
                          : Container(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              height: 250.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  var storeCardBag =
                                      storeDetailEntity.storeCardBag[index];
                                  return StoreCardBagItem(storeCardBag);
                                },
                                itemCount:
                                    storeDetailEntity.storeCardBag.length,
                              ),
                            ),
                      CSDivider(
                        colorHeight: 20.0,
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "项目列表",
                              style: theme.textTheme.body2,
                            ),
                            GestureDetector(
                              onTap: () {
                                selectSubjectPay(null);
                              },
                              child: Text(
                                "查看所有项目",
                                style: theme.textTheme.body2
                                    .merge(TextStyle(color: theme.accentColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: storeDetailEntity.storeAllProjects
                            .map((itemProject) {
                          return ListTile(
                            title: Text(itemProject.name),
                            subtitle: Text(itemProject.money.toString()),
                            trailing: FlatButton(
                              color: theme.accentColor,
                              textColor: Colors.white,
                              child: Text("去支付"),
                              onPressed: () {
                                selectSubjectPay(Subtypes(
                                    name: itemProject.name,
                                    money: itemProject.money,
                                    createTime: itemProject.createTime,
                                    pic: itemProject.pic,
                                    id: itemProject.id));
                              },
                            ),
                          );
                        }).toList(),
                      )
                    ].where((o) => o != null).toList()),
              ),
            );
          },
        ));
  }
}
