class AddressInfoBean {
  int? id;
  int? userId;
  int? areaId;
  String? address;
  String? name;
  String? mobile;
  int? utime;
  int? isDef;
  String? areaName;

  AddressInfoBean(
      {this.id,
        this.userId,
        this.areaId,
        this.address,
        this.name,
        this.mobile,
        this.utime,
        this.isDef,
        this.areaName});

  AddressInfoBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    areaId = json['area_id'];
    address = json['address'];
    name = json['name'];
    mobile = json['mobile'];
    utime = json['utime'];
    isDef = json['is_def'];
    areaName = json['area_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['area_id'] = this.areaId;
    data['address'] = this.address;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['utime'] = this.utime;
    data['is_def'] = this.isDef;
    data['area_name'] = this.areaName;
    return data;
  }
}
