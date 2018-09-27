
class PasswordManagerEntity {
  int paypassword;

  PasswordManagerEntity({this.paypassword});

  PasswordManagerEntity.fromJson(Map<String, dynamic> json) {
    paypassword = json['paypassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paypassword'] = this.paypassword;
    return data;
  }
}
