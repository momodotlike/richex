class NodeDetailBean {
  String? jiedianId;
  String? jiedianName;
  String? dayQuntity;
  String? totalBonus;
  String? bonus;

  NodeDetailBean(
      {this.jiedianId,
        this.jiedianName,
        this.dayQuntity,
        this.totalBonus,
        this.bonus});

  NodeDetailBean.fromJson(Map<String, dynamic> json) {
    jiedianId = '${json['jiedian_id']}';
    jiedianName = '${json['jiedian_name']}';
    dayQuntity = '${json['day_quntity']}';
    totalBonus = '${json['total_bonus']}';
    bonus = '${json['bonus']}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jiedian_id'] = this.jiedianId;
    data['jiedian_name'] = this.jiedianName;
    data['day_quntity'] = this.dayQuntity;
    data['total_bonus'] = this.totalBonus;
    data['bonus'] = this.bonus;
    return data;
  }
}
