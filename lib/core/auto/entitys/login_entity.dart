class LoginEntity {
  String token;
  String tel;
  String avatar;
  String nickname;

  LoginEntity({this.token, this.tel, this.avatar, this.nickname});

  LoginEntity.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    tel = json['tel'];
    avatar = json['avatar'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['tel'] = this.tel;
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    return data;
  }
}
