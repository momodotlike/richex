class ExDetailBean {
  CommissionList? commissionList;
  AccountList? accountList;

  ExDetailBean({this.commissionList, this.accountList});

  ExDetailBean.fromJson(Map<String, dynamic> json) {
    commissionList = json['commission_list'] != null
        ? new CommissionList.fromJson(json['commission_list'])
        : null;
    accountList = json['account_list'] != null
        ? new AccountList.fromJson(json['account_list'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commissionList != null) {
      data['commission_list'] = this.commissionList?.toJson();
    }
    if (this.accountList != null) {
      data['account_list'] = this.accountList?.toJson();
    }
    return data;
  }
}

class CommissionList {
  AICCommission? aICCommission;
  AICCommission? aITCommission;

  CommissionList({this.aICCommission, this.aITCommission});

  CommissionList.fromJson(Map<String, dynamic> json) {
    aICCommission = json['AIC_commission'] != null
        ? new AICCommission.fromJson(json['AIC_commission'])
        : null;
    aITCommission = json['AIT_commission'] != null
        ? new AICCommission.fromJson(json['AIT_commission'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aICCommission != null) {
      data['AIC_commission'] = this.aICCommission?.toJson();
    }
    if (this.aITCommission != null) {
      data['AIT_commission'] = this.aITCommission?.toJson();
    }
    return data;
  }
}

class AICCommission {
  String? commission;
  String? bili;

  AICCommission({this.commission, this.bili});

  AICCommission.fromJson(Map<String, dynamic> json) {
    commission = json['commission'];
    bili = json['bili'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commission'] = this.commission;
    data['bili'] = this.bili;
    return data;
  }
}

class AccountList {
  num? aIC;
  num? aIT;
  num? USDT;

  AccountList({this.aIC, this.aIT,this.USDT});

  AccountList.fromJson(Map<String, dynamic> json) {
    aIC = json['AIC'];
    aIT = json['AIT'];
    USDT = json['USDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AIC'] = this.aIC;
    data['AIT'] = this.aIT;
    data['USDT'] = this.USDT;
    return data;
  }
}
