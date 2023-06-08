class SubscribeNodeBean {
  int? jiedianId;
  String? jiedianName;
  int? jiedianAmount;
  int? giveLevelId;
  int? totalNodeQuantity;
  int? dayAwardAmount;
  String? feeFenhongPer;
  String? giveLevelName;
  String? phone;
  String? totalBonus;
  String? dayQuntity;

  SubscribeNodeBean(
      {this.jiedianId,
        this.jiedianName,
        this.jiedianAmount,
        this.giveLevelId,
        this.totalNodeQuantity,
        this.dayAwardAmount,
        this.feeFenhongPer,
        this.phone,
        this.totalBonus,
        this.dayQuntity,
        this.giveLevelName});

  SubscribeNodeBean.fromJson(Map<String, dynamic> json) {
    jiedianId = json['jiedian_id'];
    jiedianName = json['jiedian_name'];
    jiedianAmount = json['jiedian_amount'];
    giveLevelId = json['give_level_id'];
    totalNodeQuantity = json['total_node_quantity'];
    dayAwardAmount = json['day_award_amount'];
    feeFenhongPer = json['fee_fenhong_per'];
    giveLevelName = json['give_level_name'];
    phone = '${json['phone']}';
    totalBonus = '${json['total_bonus']}';
    dayQuntity = '${json['day_quntity']}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['jiedian_id'] = this.jiedianId;
    data['jiedian_name'] = this.jiedianName;
    data['jiedian_amount'] = this.jiedianAmount;
    data['give_level_id'] = this.giveLevelId;
    data['total_node_quantity'] = this.totalNodeQuantity;
    data['day_award_amount'] = this.dayAwardAmount;
    data['fee_fenhong_per'] = this.feeFenhongPer;
    data['give_level_name'] = this.giveLevelName;
    data['phone'] = this.phone;
    data['total_bonus'] = this.totalBonus;
    data['day_quntity'] = this.dayQuntity;
    return data;
  }
}
