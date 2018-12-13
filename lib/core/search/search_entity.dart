class SearchEntity {
  List<SearchStoreItem> storeList;

  SearchEntity({this.storeList});

  SearchEntity.fromJson(Map<String, dynamic> json) {
    if (json['storeList'] != null) {
      storeList = new List<SearchStoreItem>();
      json['storeList'].forEach((v) {
        storeList.add(new SearchStoreItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.storeList != null) {
      data['storeList'] = this.storeList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchStoreItem {
  String name;
  int id;

  SearchStoreItem({this.id, this.name});

  SearchStoreItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
