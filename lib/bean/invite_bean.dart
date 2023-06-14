class InviteBean {
  String? phone;
  String? levelName;
  String? createtime;

  InviteBean({this.phone, this.levelName, this.createtime});

  InviteBean.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    levelName = json['level_name'];
    createtime = json['createtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['level_name'] = this.levelName;
    data['createtime'] = this.createtime;
    return data;
  }
}