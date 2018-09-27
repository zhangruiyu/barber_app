class AccountEntity {
  UserInfo userInfo;
  int cardBagCount;

  AccountEntity({
    this.userInfo,
    this.cardBagCount,
  });

  AccountEntity.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    cardBagCount = json['cardBagCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo.toJson();
    }
    data['cardBagCount'] = this.cardBagCount;
    return data;
  }
}

class UserInfo {
  String avatar;
  String nickname;
  String realName;
  String signature;
  int gender;

  UserInfo(
      {this.avatar, this.nickname, this.realName, this.signature, this.gender});

  UserInfo.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    nickname = json['nickname'];
    realName = json['real_name'];
    signature = json['signature'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['real_name'] = this.realName;
    data['signature'] = this.signature;
    data['gender'] = this.gender;
    return data;
  }
}
