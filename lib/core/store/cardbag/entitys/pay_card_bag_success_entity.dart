
class PayCardBagSuccessEntity {
  String message;
  List<ProjectNames> projectNames;

  PayCardBagSuccessEntity({this.message, this.projectNames});

  PayCardBagSuccessEntity.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['projectNames'] != null) {
      projectNames = new List<ProjectNames>();
      json['projectNames'].forEach((v) {
        projectNames.add(new ProjectNames.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.projectNames != null) {
      data['projectNames'] = this.projectNames.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectNames {
  String name;
  String money;

  ProjectNames({this.name, this.money});

  ProjectNames.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    money = json['money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['money'] = this.money;
    return data;
  }
}
