class StoreInfoBean {
  int? id;
  String? storeName;
  String? mobile;
  String? linkman;
  String? logo;
  int? areaId;
  String? address;
  String? coordinate;
  String? operatingHours;
  String? latitude;
  String? longitude;
  int? ctime;
  int? utime;
  String? distance;
  String? allAddress;

  StoreInfoBean(
      {this.id,
        this.storeName,
        this.mobile,
        this.linkman,
        this.logo,
        this.areaId,
        this.address,
        this.coordinate,
        this.operatingHours,
        this.latitude,
        this.longitude,
        this.ctime,
        this.utime,
        this.distance,
        this.allAddress});

  StoreInfoBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    mobile = json['mobile'];
    linkman = json['linkman'];
    logo = json['logo'];
    areaId = json['area_id'];
    address = json['address'];
    coordinate = json['coordinate'];
    operatingHours = json['operating_hours'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    ctime = json['ctime'];
    utime = json['utime'];
    distance = json['distance'];
    allAddress = json['all_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_name'] = this.storeName;
    data['mobile'] = this.mobile;
    data['linkman'] = this.linkman;
    data['logo'] = this.logo;
    data['area_id'] = this.areaId;
    data['address'] = this.address;
    data['coordinate'] = this.coordinate;
    data['operating_hours'] = this.operatingHours;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['ctime'] = this.ctime;
    data['utime'] = this.utime;
    data['distance'] = this.distance;
    data['all_address'] = this.allAddress;
    return data;
  }
}
