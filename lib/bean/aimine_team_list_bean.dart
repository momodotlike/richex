class AiMineTeamListBean {
  String? phone;
  String? jiedianName;
  String? levelName;

  AiMineTeamListBean({this.phone, this.jiedianName, this.levelName});

  AiMineTeamListBean.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    jiedianName = json['jiedian_name'];
    levelName = json['level_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['jiedian_name'] = this.jiedianName;
    data['level_name'] = this.levelName;
    return data;
  }
}
