class WalletListEntity {
  List<WalletEntity> cardBagList;

  WalletListEntity({this.cardBagList});

  WalletListEntity.fromJson(Map<String, dynamic> json) {
    if (json['cardBagList'] != null) {
      cardBagList = new List<WalletEntity>();
      json['cardBagList'].forEach((v) {
        cardBagList.add(new WalletEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cardBagList != null) {
      data['expenseCalendar'] =
          this.cardBagList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletEntity {
  String storeName;
  List<CardBagList> cardBagList;

  WalletEntity({this.storeName, this.cardBagList});

  WalletEntity.fromJson(Map<String, dynamic> json) {
    storeName = json['storeName'];
    if (json['cardBagList'] != null) {
      cardBagList = new List<CardBagList>();
      json['cardBagList'].forEach((v) {
        cardBagList.add(new CardBagList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeName'] = this.storeName;
    if (this.cardBagList != null) {
      data['cardBagList'] = this.cardBagList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardBagList {
  int count;
  String name;
  String createTime;
  List<Record> record;
  String storeName;

  CardBagList(
      {this.count, this.name, this.record, this.storeName, this.createTime});

  CardBagList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    name = json['name'];
    if (json['record'] != null) {
      record = new List<Record>();
      json['record'].forEach((v) {
        record.add(new Record.fromJson(v));
      });
    }
    storeName = json['store_name'];
    createTime = json['create_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['name'] = this.name;
    if (this.record != null) {
      data['record'] = this.record.map((v) => v.toJson()).toList();
    }
    data['store_name'] = this.storeName;
    data['create_time'] = this.createTime;
    return data;
  }
}

class Record {
  String createTime;
  String projectName;
  int cardBagCount;
  int cardBagMoney;

  Record(
      {this.createTime,
      this.projectName,
      this.cardBagCount,
      this.cardBagMoney});

  Record.fromJson(Map<String, dynamic> json) {
    createTime = json['create_time'];
    projectName = json['project_name'];
    cardBagCount = json['card_bag_count'];
    cardBagMoney = json['card_bag_money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.createTime;
    data['project_name'] = this.projectName;
    data['card_bag_count'] = this.cardBagCount;
    data['card_bag_money'] = this.cardBagMoney;
    return data;
  }
}
