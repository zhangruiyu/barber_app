
class AddStoreQueueEntity {
  int allQueueUpCount;
  List<AllQueueUp> allQueueUp;
  int currentIndex;

  AddStoreQueueEntity({this.allQueueUpCount, this.allQueueUp, this.currentIndex});

  AddStoreQueueEntity.fromJson(Map<String, dynamic> json) {
    allQueueUpCount = json['allQueueUpCount'];
    if (json['allQueueUp'] != null) {
      allQueueUp = new List<AllQueueUp>();
      json['allQueueUp'].forEach((v) {
        allQueueUp.add(new AllQueueUp.fromJson(v));
      });
    }
    currentIndex = json['currentIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> AddStoreQueueEntity = new Map<String, dynamic>();
    AddStoreQueueEntity['allQueueUpCount'] = this.allQueueUpCount;
    if (this.allQueueUp != null) {
      AddStoreQueueEntity['allQueueUp'] = this.allQueueUp.map((v) => v.toJson()).toList();
    }
    AddStoreQueueEntity['currentIndex'] = this.currentIndex;
    return AddStoreQueueEntity;
  }
}

class AllQueueUp {
  String serverName;
  String createTime;

  AllQueueUp({this.serverName, this.createTime});

  AllQueueUp.fromJson(Map<String, dynamic> json) {
    serverName = json['serverName'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> AddStoreQueueEntity = new Map<String, dynamic>();
    AddStoreQueueEntity['serverName'] = this.serverName;
    AddStoreQueueEntity['createTime'] = this.createTime;
    return AddStoreQueueEntity;
  }
}