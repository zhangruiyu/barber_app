class HomeEntity {
  List<Banners> banners;
  List<ActiveStoreList> activeStoreList;

  HomeEntity({this.banners, this.activeStoreList});

  HomeEntity.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = new List<Banners>();
      json['banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
    if (json['activeStoreList'] != null) {
      activeStoreList = new List<ActiveStoreList>();
      json['activeStoreList'].forEach((v) {
        activeStoreList.add(new ActiveStoreList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    if (this.activeStoreList != null) {
      data['activeStoreList'] =
          this.activeStoreList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  String title;
  String url;
  String picUrl;

  Banners({this.title, this.url, this.picUrl});

  Banners.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    picUrl = json['picUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['picUrl'] = this.picUrl;
    return data;
  }
}

class ActiveStoreList {
  String name;
  String avatar;
  int id;
  String lastUseTime;

  ActiveStoreList({this.name, this.id, this.lastUseTime,this.avatar});

  ActiveStoreList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    avatar = json['avatar'];
    lastUseTime = json['last_use_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['last_use_time'] = this.lastUseTime;
    return data;
  }
}
