

class CosEntity {
  String tmpSecretId;
  String cosPath;
  String tmpSecretKey;
  String sessionToken;
  int expiredTime;

  CosEntity(
      {this.tmpSecretId,
        this.cosPath,
        this.tmpSecretKey,
        this.sessionToken,
        this.expiredTime});

  CosEntity.fromJson(Map<String, dynamic> json) {
    tmpSecretId = json['tmpSecretId'];
    cosPath = json['cosPath'];
    tmpSecretKey = json['tmpSecretKey'];
    sessionToken = json['sessionToken'];
    expiredTime = json['expiredTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tmpSecretId'] = this.tmpSecretId;
    data['cosPath'] = this.cosPath;
    data['tmpSecretKey'] = this.tmpSecretKey;
    data['sessionToken'] = this.sessionToken;
    data['expiredTime'] = this.expiredTime;
    return data;
  }
}
