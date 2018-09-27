

class PayListEntity {
  String createTime;
  List<ExpenseCalendar> expenseCalendar;

  PayListEntity({this.createTime, this.expenseCalendar});

  PayListEntity.fromJson(Map<String, dynamic> json) {
    createTime = json['create_time'];
    if (json['expenseCalendar'] != null) {
      expenseCalendar = new List<ExpenseCalendar>();
      json['expenseCalendar'].forEach((v) {
        expenseCalendar.add(new ExpenseCalendar.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['create_time'] = this.createTime;
    if (this.expenseCalendar != null) {
      data['expenseCalendar'] =
          this.expenseCalendar.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExpenseCalendar {
  String title;
  String subtitle;
  String trailing;

  ExpenseCalendar({this.title, this.subtitle, this.trailing});

  ExpenseCalendar.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    trailing = json['trailing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['trailing'] = this.trailing;
    return data;
  }
}
