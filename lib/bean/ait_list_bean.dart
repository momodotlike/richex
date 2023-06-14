class AitListBean {
  int? procType;
  String? num;
  String? createTime;
  String? procTypeVal;

  AitListBean({this.procType, this.num, this.createTime, this.procTypeVal});

  AitListBean.fromJson(Map<String, dynamic> json) {
    procType = json['proc_type'];
    num = json['num'];
    createTime = json['create_time'];
    procTypeVal = json['proc_type_val'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['proc_type'] = this.procType;
    data['num'] = this.num;
    data['create_time'] = this.createTime;
    data['proc_type_val'] = this.procTypeVal;
    return data;
  }
}