class ExchangeHistoryBean {
  int? rid;
  int? uid;
  String? sourceCurrency;
  String? shanduiCurrency;
  String? sourceCurrencyAmount;
  String? shanduiCurrencyAmount;
  String? shanduiPer;
  String? shanduiFee;
  String? shanduiTime;

  ExchangeHistoryBean(
      {this.rid,
        this.uid,
        this.sourceCurrency,
        this.shanduiCurrency,
        this.sourceCurrencyAmount,
        this.shanduiCurrencyAmount,
        this.shanduiPer,
        this.shanduiFee,
        this.shanduiTime});

  ExchangeHistoryBean.fromJson(Map<String, dynamic> json) {
    rid = json['rid'];
    uid = json['uid'];
    sourceCurrency = json['source_currency'];
    shanduiCurrency = json['shandui_currency'];
    sourceCurrencyAmount = json['source_currency_amount'];
    shanduiCurrencyAmount = json['shandui_currency_amount'];
    shanduiPer = json['shandui_per'];
    shanduiFee = json['shandui_fee'];
    shanduiTime = json['shandui_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rid'] = this.rid;
    data['uid'] = this.uid;
    data['source_currency'] = this.sourceCurrency;
    data['shandui_currency'] = this.shanduiCurrency;
    data['source_currency_amount'] = this.sourceCurrencyAmount;
    data['shandui_currency_amount'] = this.shanduiCurrencyAmount;
    data['shandui_per'] = this.shanduiPer;
    data['shandui_fee'] = this.shanduiFee;
    data['shandui_time'] = this.shanduiTime;
    return data;
  }
}
