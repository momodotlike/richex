class InvestBean {
  List<ZulinBean>? zulinList;
  String? jiedian;
  String? totalBalance;
  ZulinBean? zulin;

  InvestBean({this.zulinList, this.jiedian,this.totalBalance,this.zulin});

  InvestBean.fromJson(Map<String, dynamic> json) {
    if (json['zulin_list'] != null) {
      zulinList = [];
      json['zulin_list'].forEach((v) {
        zulinList?.add(ZulinBean.fromJson(v));
      });
    }
    jiedian = '${json['jiedian']}';
    totalBalance = '${json['total_balance']}';
    zulin = json['zulin'] != null ? ZulinBean.fromJson(json['zulin']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.zulinList != null) {
      data['zulin_list'] = this.zulinList?.map((v) => v.toJson()).toList();
    }
    data['jiedian'] = this.jiedian;
    data['total_balance'] = this.totalBalance;
    data['total_balance'] = this.totalBalance;
    if (this.zulin != null) {
      data['zulin'] = this.zulin?.toJson();
    }
    return data;
  }
}

class ZulinBean {
  String? zulinId;
  String? zulinName;
  String? beginPer;
  String? dayAddPer;
  String? maxPer;
  String? nianhuaPer;
  String? minZulinAmount;
  String? maxZulinAmount;
  String? ownZulinAmount;

  ZulinBean(
      {this.zulinId,
        this.zulinName,
        this.beginPer,
        this.dayAddPer,
        this.maxPer,
        this.minZulinAmount,
        this.maxZulinAmount,
        this.ownZulinAmount,
      });

  ZulinBean.fromJson(Map<String, dynamic> json) {
    zulinId = '${json['zulin_id']}';
    zulinName = '${json['zulin_name']}';
    beginPer = '${json['begin_per']}';
    dayAddPer = '${json['day_add_per']}';
    nianhuaPer = '${json['nianhua_per']}';
    maxPer = '${json['max_per']}';
    minZulinAmount = '${json['min_zulin_amount']}';
    maxZulinAmount = '${json['max_zulin_amount']}';
    ownZulinAmount = '${json['own_zulin_amount']}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['zulin_id'] = this.zulinId;
    data['zulin_name'] = this.zulinName;
    data['begin_per'] = this.beginPer;
    data['day_add_per'] = this.dayAddPer;
    data['nianhua_per'] = this.nianhuaPer;
    data['max_per'] = this.maxPer;
    data['min_zulin_amount'] = this.minZulinAmount;
    data['max_zulin_amount'] = this.maxZulinAmount;
    data['own_zulin_amount'] = this.ownZulinAmount;
    return data;
  }
}
