class PaySuccessEntity {
  String message;
  List<ProjectNames> projectNames;

  PaySuccessEntity({this.message, this.projectNames});

  PaySuccessEntity.fromJson(Map<String, dynamic> json) {
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
  String title;
  String subtitle;
  String trailing;

  ProjectNames({this.title, this.trailing,this.subtitle});

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
