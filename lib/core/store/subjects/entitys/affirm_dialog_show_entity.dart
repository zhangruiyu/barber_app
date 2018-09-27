class AffirmDialogShowEntity {
  String selectResult;
  int storeId;
  List<ProjectNames> projectNames;
  int totalMoney;
  int discountsMoney;

  AffirmDialogShowEntity(
      {this.selectResult,
      this.storeId,
      this.projectNames,
      this.totalMoney,
      this.discountsMoney});

  AffirmDialogShowEntity.fromJson(Map<String, dynamic> json) {
    selectResult = json['selectResult'];
    storeId = json['storeId'];
    if (json['projectNames'] != null) {
      projectNames = new List<ProjectNames>();
      json['projectNames'].forEach((v) {
        projectNames.add(new ProjectNames.fromJson(v));
      });
    }
    totalMoney = json['totalMoney'];
    discountsMoney = json['discountsMoney'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selectResult'] = this.selectResult;
    data['storeId'] = this.storeId;
    if (this.projectNames != null) {
      data['projectNames'] = this.projectNames.map((v) => v.toJson()).toList();
    }
    data['totalMoney'] = this.totalMoney;
    data['discountsMoney'] = this.discountsMoney;
    return data;
  }
}

class ProjectNames {
  String title;
  String subtitle;
  String trailing;

  ProjectNames({this.title, this.subtitle, this.trailing});

  ProjectNames.fromJson(Map<String, dynamic> json) {
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
