
class StoreProject {
  List<ItemProject> allProject;
  List<BuyStoreCardBags> buyStoreCardBags;

  StoreProject({this.allProject, this.buyStoreCardBags});

  StoreProject.fromJson(Map<String, dynamic> json) {
    if (json['allProject'] != null) {
      allProject = new List<ItemProject>();
      json['allProject'].forEach((v) {
        allProject.add(new ItemProject.fromJson(v));
      });
    }
    if (json['buyStoreCardBags'] != null) {
      buyStoreCardBags = new List<BuyStoreCardBags>();
      json['buyStoreCardBags'].forEach((v) {
        buyStoreCardBags.add(new BuyStoreCardBags.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.allProject != null) {
      data['allProject'] = this.allProject.map((v) => v.toJson()).toList();
    }
    if (this.buyStoreCardBags != null) {
      data['buyStoreCardBags'] =
          this.buyStoreCardBags.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemProject {
  int id;
  String name;
  int storeId;
  String addTime;
  List<Subtypes> subtypes;

  ItemProject({this.id, this.name, this.storeId, this.addTime, this.subtypes});

  ItemProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeId = json['store_id'];
    addTime = json['add_time'];
    if (json['subtypes'] != null) {
      subtypes = new List<Subtypes>();
      json['subtypes'].forEach((v) {
        subtypes.add(new Subtypes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['store_id'] = this.storeId;
    data['add_time'] = this.addTime;
    if (this.subtypes != null) {
      data['subtypes'] = this.subtypes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subtypes {
  String id;
  String pic;
  String name;
  int money;
  //卡包的编号,为空说明没有卡包
  int cardBagId;
  String createTime;

  Subtypes({this.id, this.pic, this.name, this.money, this.createTime});

  Subtypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pic = json['pic'];
    name = json['name'];
    money = json['money'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pic'] = this.pic;
    data['name'] = this.name;
    data['money'] = this.money;
    data['create_time'] = this.createTime;
    return data;
  }
}

class BuyStoreCardBags {
  int id;
  int userId;
  int storeCardBagId;
  int count;
  String createTime;
  List record;
  String name;
  int storeId;
  String storeSubtypeId;
  int discountTotalPrice;
  int originalTotalPrice;

  BuyStoreCardBags(
      {this.id,
      this.userId,
      this.storeCardBagId,
      this.count,
      this.createTime,
      this.record,
      this.name,
      this.storeId,
      this.storeSubtypeId,
      this.discountTotalPrice,
      this.originalTotalPrice});

  BuyStoreCardBags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    storeCardBagId = json['store_card_bag_id'];
    count = json['count'];
    createTime = json['create_time'];
    record = json['record'];
    name = json['name'];
    storeId = json['store_id'];
    storeSubtypeId = json['store_subtype_id'];
    discountTotalPrice = json['discount_total_price'];
    originalTotalPrice = json['original_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['store_card_bag_id'] = this.storeCardBagId;
    data['count'] = this.count;
    data['create_time'] = this.createTime;
    data['record'] = this.record;
    data['name'] = this.name;
    data['store_id'] = this.storeId;
    data['store_subtype_id'] = this.storeSubtypeId;
    data['discount_total_price'] = this.discountTotalPrice;
    data['original_total_price'] = this.originalTotalPrice;
    return data;
  }
}
