class StoreDetailEntity {
  StoreInfo storeInfo;
  List<StoreAllProjects> storeAllProjects;
  int userMoney;
  List<StoreCardBag> storeCardBag;
  int queueCurrentIndex;
  int allQueueUpCount;

  StoreDetailEntity(
      {this.storeInfo,
      this.storeAllProjects,
      this.userMoney,
      this.storeCardBag,
      this.queueCurrentIndex,
      this.allQueueUpCount});

  StoreDetailEntity.fromJson(Map<String, dynamic> json) {
    storeInfo = json['storeInfo'] != null
        ? new StoreInfo.fromJson(json['storeInfo'])
        : null;
    if (json['storeAllProjects'] != null) {
      storeAllProjects = new List<StoreAllProjects>();
      json['storeAllProjects'].forEach((v) {
        storeAllProjects.add(new StoreAllProjects.fromJson(v));
      });
    }
    userMoney = json['userMoney'];
    if (json['storeCardBag'] != null) {
      storeCardBag = new List<StoreCardBag>();
      json['storeCardBag'].forEach((v) {
        storeCardBag.add(new StoreCardBag.fromJson(v));
      });
    }
    queueCurrentIndex = json['queueCurrentIndex'];
    allQueueUpCount = json['allQueueUpCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storeInfo != null) {
      data['storeInfo'] = this.storeInfo.toJson();
    }
    if (this.storeAllProjects != null) {
      data['storeAllProjects'] =
          this.storeAllProjects.map((v) => v.toJson()).toList();
    }
    data['userMoney'] = this.userMoney;
    if (this.storeCardBag != null) {
      data['storeCardBag'] = this.storeCardBag.map((v) => v.toJson()).toList();
    }
    data['queueCurrentIndex'] = this.queueCurrentIndex;
    data['allQueueUpCount'] = this.allQueueUpCount;
    return data;
  }
}

class StoreInfo {
  String name;
  String avatar;
  String createTime;
  String address;

  StoreInfo({this.name, this.avatar, this.createTime, this.address});

  StoreInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    createTime = json['create_time'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['create_time'] = this.createTime;
    data['address'] = this.address;
    return data;
  }
}

class StoreAllProjects {
  String id;
  String pic;
  String name;
  int money;
  String createTime;

  StoreAllProjects({this.id, this.pic, this.name, this.money, this.createTime});

  StoreAllProjects.fromJson(Map<String, dynamic> json) {
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

class StoreCardBag {
  int id;
  String name;
  int storeId;
  String storeSubtypeId;
  int count;
  String createTime;
  int discountTotalPrice;
  int originalTotalPrice;

  StoreCardBag(
      {this.id,
      this.name,
      this.storeId,
      this.storeSubtypeId,
      this.count,
      this.createTime,
      this.discountTotalPrice,
      this.originalTotalPrice});

  StoreCardBag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    storeId = json['store_id'];
    storeSubtypeId = json['store_subtype_id'];
    count = json['count'];
    createTime = json['create_time'];
    discountTotalPrice = json['discount_total_price'];
    originalTotalPrice = json['original_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['store_id'] = this.storeId;
    data['store_subtype_id'] = this.storeSubtypeId;
    data['count'] = this.count;
    data['create_time'] = this.createTime;
    data['discount_total_price'] = this.discountTotalPrice;
    data['original_total_price'] = this.originalTotalPrice;
    return data;
  }
}
