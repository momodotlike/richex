
// tuijian  推荐收益
// weight  分红收益
// zulin  租赁收益
// jiedian  节点收益
// share  分享收益
// team  团队收益

class AiMineDetailBean {
  String? valuation;
  String? amount;
  String? income;
  DetailListBean? tuijian;
  DetailListBean? weight;
  DetailListBean? zulin;
  DetailListBean? jiedian;
  DetailListBean? pingji;
  DetailListBean? share;
  DetailListBean? team;

  AiMineDetailBean(
      {this.valuation,
        this.amount,
        this.income,
        this.tuijian,
        this.weight,
        this.zulin,
        this.jiedian,
        this.pingji,
        this.share,
        this.team});

  AiMineDetailBean.fromJson(Map<String, dynamic> json) {
    valuation = '${json['valuation']}';
    amount = '${json['amount']}';
    income = '${json['income']}';
    tuijian = (json['tuijian'] != null && '${json['tuijian']}' != '[]') ? new DetailListBean.fromJson(json['tuijian']) : null;
    weight =
    (json['weight'] != null && '${json['weight']}' != '[]') ? new DetailListBean.fromJson(json['weight']) : null;
    zulin = (json['zulin'] != null && '${json['zulin']}' != '[]') ? new DetailListBean.fromJson(json['zulin']) : null;
    jiedian =
    (json['jiedian'] != null && '${json['jiedian']}' != '[]') ? new DetailListBean.fromJson(json['jiedian']) : null;
    pingji =
    ( json['pingji'] != null &&  '${json['pingji']}' != '[]') ? new DetailListBean.fromJson(json['pingji']) : null;
    share = (json['share'] != null && '${json['share']}' != '[]') ? new DetailListBean.fromJson(json['share']) : null;
    team = (json['team'] != null && '${json['team']}' != '[]') ? new DetailListBean.fromJson(json['team']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valuation'] = this.valuation;
    data['amount'] = this.amount;
    data['income'] = this.income;
    if (this.tuijian != null) {
      data['tuijian'] = this.tuijian?.toJson();
    }
    if (this.weight != null) {
      data['weight'] = this.weight?.toJson();
    }
    if (this.zulin != null) {
      data['zulin'] = this.zulin?.toJson();
    }
    if (this.jiedian != null) {
      data['jiedian'] = this.jiedian?.toJson();
    }
    if (this.pingji != null) {
      data['pingji'] = this.pingji?.toJson();
    }
    if (this.share != null) {
      data['share'] = this.share?.toJson();
    }
    if (this.team != null) {
      data['team'] = this.team?.toJson();
    }
    return data;
  }
}

class DetailListBean {
  int? period;
  int? uid;
  String? levelWeightPer;
  String? weightPer;
  String? bonus;
  String? sendBonus;
  String? statTime;
  String? isSend;
  String? sendTime;
  String? uidLevelName;

  DetailListBean(
      {this.period,
        this.uid,
        this.levelWeightPer,
        this.weightPer,
        this.bonus,
        this.sendBonus,
        this.statTime,
        this.isSend,
        this.sendTime,
        this.uidLevelName});

  DetailListBean.fromJson(Map<String, dynamic> json) {
    period = json['period'] ?? '';
    uid = json['uid'] ?? '';
    levelWeightPer = json['level_weight_per'] ?? '';
    weightPer = json['weight_per'] ?? '';
    bonus = json['bonus'] ?? '';
    sendBonus = json['send_bonus'] ?? '';
    statTime = json['stat_time'] ?? '';
    isSend = json['is_send'] ?? '';
    sendTime = json['send_time'] ?? '';
    uidLevelName = json['uid_level_name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['period'] = this.period;
    data['uid'] = this.uid;
    data['level_weight_per'] = this.levelWeightPer;
    data['weight_per'] = this.weightPer;
    data['bonus'] = this.bonus;
    data['send_bonus'] = this.sendBonus;
    data['stat_time'] = this.statTime;
    data['is_send'] = this.isSend;
    data['send_time'] = this.sendTime;
    data['uid_level_name'] = this.uidLevelName;
    return data;
  }
}
