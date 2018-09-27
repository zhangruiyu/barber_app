import 'dart:collection';

import 'package:barber_app/base/BasePageRoute.dart';
import 'package:barber_app/core/pay/store_project.dart';
import 'package:barber_app/core/paypassword/set_pay_password_screen.dart';
import 'package:barber_app/core/store/subjects/affirm_project_dialog.dart';
import 'package:barber_app/core/store/subjects/entitys/affirm_dialog_show_entity.dart';
import 'package:barber_app/core/store/subjects/subjects_item.dart';
import 'package:barber_app/helpers/navigator_helper.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:barber_app/styles/color_style.dart';
import 'package:barber_app/utils/WindowUtils.dart';
import 'package:barber_app/utils/toast_utils.dart';
import 'package:barber_app/widget/Toolbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SubjectsScreen extends BasePageRoute {
  final StoreProject onValue;
  final Subtypes selectSubtypeItem;

  SubjectsScreen(this.onValue, this.selectSubtypeItem);

  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();

  @override
  String getRouteName() {
    return "SubjectsScreen";
  }
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  var selectStoreProject;

  @override
  void initState() {
    selectStoreProject = SelectStoreProject(widget.onValue.buyStoreCardBags);
    if (widget.selectSubtypeItem != null) {
      selectStoreProject.addStoreProject(widget.selectSubtypeItem);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var buyStoreCardBags = widget.onValue.buyStoreCardBags;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: Toolbar(
          title: Text("项目列表"),
        ),
        body: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: ScopedModel<StoreProjectModel>(
                  model: StoreProjectModel(widget.onValue.allProject),
                  child: Container(child:
                      ScopedModelDescendant<StoreProjectModel>(
                          builder: (context, widget, StoreProjectModel model) {
                    return Row(
                      children: <Widget>[
                        Container(
                          width: 90.0,
                          color: unselectBG,
                          height: WindowUtils.getScreenHeight(),
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              var storeProject = model.onValue[index];
                              return GestureDetector(
                                onTap: () {
                                  model.setCurrentIndex(index);
                                },
                                child: Container(
                                  color: model.currentIndex == index
                                      ? Colors.white
                                      : Colors.transparent,
                                  padding: const EdgeInsets.only(
                                      top: 28.0,
                                      right: 28.0,
                                      bottom: 28.0,
                                      left: 28.0),
                                  child: Text(
                                    storeProject.name,
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.body1.merge(
                                        TextStyle(color: theme.accentColor)),
                                  ),
                                ),
                              );
                            },
                            itemCount: model.onValue.length,
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              var subtype = model
                                  .onValue[model.currentIndex].subtypes[index];
                              return SubjectsItem(subtype, selectStoreProject,
                                  buyStoreCardBags);
                            },
                            itemCount: model
                                .onValue[model.currentIndex].subtypes.length,
                          ),
                        )
                      ],
                    );
                  })),
                ),
              ),
              buildBottomTotalWidget(selectStoreProject)
            ],
          ),
        ));
  }

  Widget buildBottomTotalWidget(SelectStoreProject selectStoreProjectModel) {
    final ThemeData theme = Theme.of(context);

    return ScopedModel<SelectStoreProject>(
        model: selectStoreProjectModel,
        child: Container(
          height: 50.0,
          margin: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
              borderRadius: new BorderRadius.circular(30.0),
              color: Colors.black54),
          child: ScopedModelDescendant<SelectStoreProject>(
            builder: (BuildContext context, Widget child, Model model) {
              return new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Text(
                        "¥${selectStoreProjectModel.totalMoney()}",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (selectStoreProjectModel.buyStoreCardBags.length <=
                          0) {
                        ToastUtils.toast("金额过低无法支付");
                      } else {
                        generateIndent();
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.only(
                              bottomRight: Radius.circular(30.0),
                              topRight: Radius.circular(30.0)),
                          color: theme.accentColor),
                      child: Text(
                        "去结算",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }

  void generateIndent() {
    NavigatorHelper.showLoadingDialog(true);
    RequestHelper.generateIndent(
            selectStoreProject.generateSelectProjectString(),
            widget.onValue.allProject[0].storeId.toString())
        .then((AffirmDialogShowEntity onValue) {
      NavigatorHelper.showLoadingDialog(false, () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return AffirmProjectDialog(onValue, context);
            });
      });
    }).catchError((onError) {
      NavigatorHelper.showLoadingDialog(false, () {
        if (onError.code == 1005) {
          Navigator.push(context, SetPayPasswordScreen().route());
        }
      });
    });
  }
}

class StoreProjectModel extends Model {
  List<ItemProject> onValue;

  //默认展示第一组数据
  int currentIndex = 0;

  StoreProjectModel(this.onValue);

  setCurrentIndex(int index) {
    if (index != currentIndex) {
      currentIndex = index;
      notifyListeners();
    }
  }
}

class SelectStoreProject extends Model {
  HashMap<String, List<Subtypes>> selectLists = new HashMap();
  List<BuyStoreCardBags> buyStoreCardBags;

  SelectStoreProject(this.buyStoreCardBags);

  addStoreProject(Subtypes item) {
    if (selectLists.containsKey(item.id)) {
      selectLists[item.id].add(item);
    } else {
      selectLists.putIfAbsent(item.id, () => [item]);
    }
    notifyListeners();
  }

  removeStoreProject(Subtypes item) {
    if (selectLists.containsKey(item.id)) {
      if (selectLists[item.id].length > 0) {
        selectLists[item.id].remove(item);
      }
      if (selectLists[item.id].length == 0) {
        selectLists.remove(item.id);
      }
    }
    notifyListeners();
  }

  int getSelectId(String subtypeId) {
    return selectLists[subtypeId]?.length ?? 0;
  }

  int totalMoney() {
    int totalMoney = 0;
    selectLists.forEach((key, value) {
      var buyStoreCardBag =
          buyStoreCardBags.firstWhere((BuyStoreCardBags storeCardBag) {
        return storeCardBag.storeSubtypeId == key;
      }, orElse: () {
        return null;
      });
      //如果卡包里有这个项目
      if (buyStoreCardBag != null) {
        int needPayCount = value.length - buyStoreCardBag.count;
        //超出卡包次数部分需要付费
        if (needPayCount > 0) {
          value.sublist(0, needPayCount).forEach((item) {
            totalMoney += item.money;
          });
        }
      } else {
        value.forEach((item) {
          totalMoney += item.money;
        });
      }
    });
    return totalMoney;
  }

  String generateSelectProjectString() {
    return selectLists.values.fold<List<String>>(List<String>(), (list, f) {
      f.forEach((item) {
        list.add(item.id);
      });
      return list;
    }).join("###########");
  }
}
