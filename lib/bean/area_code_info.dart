class AreaCodeInfo {
  String? country;
  int? code;

  AreaCodeInfo({this.country,this.code});

  AreaCodeInfo.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['country'] = country;
    data['code'] = code;
    return data;
  }
}