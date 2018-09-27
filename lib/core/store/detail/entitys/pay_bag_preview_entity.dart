
class PayBagPreviewEntity {
  String message;
  int userMoney;
  int count;
  String name;
  int originalMoney;

  PayBagPreviewEntity(
      {this.message,
        this.userMoney,
        this.count,
        this.name,
        this.originalMoney});

  PayBagPreviewEntity.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userMoney = json['userMoney'];
    count = json['count'];
    name = json['name'];
    originalMoney = json['originalMoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userMoney'] = this.userMoney;
    data['count'] = this.count;
    data['name'] = this.name;
    data['originalMoney'] = this.originalMoney;
    return data;
  }
}
