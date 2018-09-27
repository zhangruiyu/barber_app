class RegisterEntity {
  int expire;

  RegisterEntity({this.expire});

  RegisterEntity.fromJson(Map<String, dynamic> json) {
    expire = json['expire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expire'] = this.expire;
    return data;
  }
}
