class AicBean {
  AccountList? accountList;
  String? aitXiaohuiAmount;
  String? aicChanchuAmount;
  String? isXiaohui;
  String? startTime;
  int? startTimeInt;

  AicBean(
      {this.accountList,
        this.aitXiaohuiAmount,
        this.aicChanchuAmount,
        this.isXiaohui});

  AicBean.fromJson(Map<String, dynamic> json) {
    accountList = json['account_list'] != null
        ? new AccountList.fromJson(json['account_list'])
        : null;
    aitXiaohuiAmount = json['ait_xiaohui_amount'];
    aicChanchuAmount = json['aic_chanchu_amount'];
    isXiaohui = '${json['is_xiaohui']}';
    startTime = '${json['start_time']}';
    startTimeInt = json['start_time_int'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.accountList != null) {
      data['account_list'] = this.accountList?.toJson();
    }
    data['ait_xiaohui_amount'] = this.aitXiaohuiAmount;
    data['aic_chanchu_amount'] = this.aicChanchuAmount;
    data['is_xiaohui'] = this.isXiaohui;
    data['start_time'] = this.startTime;
    data['start_time_int'] = this.startTimeInt;
    return data;
  }
}

class AccountList {
  num? aIC;
  num? aIT;

  AccountList({this.aIC, this.aIT});

  AccountList.fromJson(Map<String, dynamic> json) {
    aIC = json['AIC'];
    aIT = json['AIT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AIC'] = this.aIC;
    data['AIT'] = this.aIT;
    return data;
  }
}
