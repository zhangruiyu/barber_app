class User {
  String avatar;
  String token;
  String tel;
  String nickname;

  User({this.avatar, this.token, this.tel,this.nickname});

  User.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    token = json['token'];
    tel = json['tel'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['token'] = this.token;
    data['tel'] = this.tel;
    data['nickname'] = this.nickname;
    return data;
  }

  @override
  String toString() {
    return 'User{avatar: $avatar, token: $token, tel: $tel, nickname: $nickname}';
  }
}
