class AiMineInvestHisBean {
  int? touziAmount;
  String? touziTime;
  int? dayQuntity;
  String? dayAddPer;
  String? beginDay;
  String? lastPer;
  String? totalBonus;
  String? zulinName;
  String? statusVal;

  AiMineInvestHisBean(
      {this.touziAmount,
        this.touziTime,
        this.dayQuntity,
        this.dayAddPer,
        this.beginDay,
        this.lastPer,
        this.totalBonus,
        this.zulinName,
        this.statusVal});

  AiMineInvestHisBean.fromJson(Map<String, dynamic> json) {
    touziAmount = json['touzi_amount'];
    touziTime = json['touzi_time'];
    dayQuntity = json['day_quntity'];
    dayAddPer = json['day_add_per'];
    beginDay = json['begin_day'];
    lastPer = json['last_per'];
    totalBonus = json['total_bonus'];
    zulinName = json['zulin_name'];
    statusVal = '${json['status_val']}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['touzi_amount'] = this.touziAmount;
    data['touzi_time'] = this.touziTime;
    data['day_quntity'] = this.dayQuntity;
    data['day_add_per'] = this.dayAddPer;
    data['begin_day'] = this.beginDay;
    data['last_per'] = this.lastPer;
    data['total_bonus'] = this.totalBonus;
    data['zulin_name'] = this.zulinName;
    data['status_val'] = this.statusVal;
    return data;
  }
}
