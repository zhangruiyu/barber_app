import 'package:barber_app/core/pay/store_project.dart';
import 'package:barber_app/core/store/subjects/subjects_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SubjectsItem extends StatefulWidget {
  final Subtypes subtype;
  final SelectStoreProject selectStoreProject;
  final List<BuyStoreCardBags> buyStoreCardBags;

  SubjectsItem(this.subtype, this.selectStoreProject, this.buyStoreCardBags);

  @override
  _SubjectsItemState createState() => _SubjectsItemState();
}

class _SubjectsItemState extends State<SubjectsItem> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    var selectCount = widget.selectStoreProject.getSelectId(widget.subtype.id);
    //获取匹配当前的已购买卡包
    var matchingBuyStoreCardBag =
        widget.buyStoreCardBags.firstWhere((BuyStoreCardBags buyStoreCardBag) {
      return buyStoreCardBag.storeSubtypeId == widget.subtype.id;
    }, orElse: () {
      return null;
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          enabled: true,
          onTap: () {},
          title: Text(
            widget.subtype.name,
            style: TextStyle(fontSize: 12.0),
            maxLines: 2,
          ),
          subtitle: Text("${widget.subtype.money}元"),
          leading: new CachedNetworkImage(
            width: 50.0,
            height: 50.0,
            imageUrl: widget.subtype.pic,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              selectCount > 0
                  ? IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          widget.selectStoreProject
                              .removeStoreProject(widget.subtype);
                        });
                      })
                  : null,
              selectCount > 0 ? Text(selectCount.toString()) : null,
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    widget.selectStoreProject.addStoreProject(widget.subtype);
                  });
                },
              ),
            ].where((o) => o != null).toList(),
          ),
        ),
        matchingBuyStoreCardBag == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(right: 18.0),
                child: Text(
                  "卡包还可抵扣${matchingBuyStoreCardBag.count}次",
                  style: theme.textTheme.body1.merge(
                    TextStyle(color: theme.accentColor),
                  ),
                ),
              ),
        Divider()
      ].where((o) => o != null).toList(),
    );
  }
}
