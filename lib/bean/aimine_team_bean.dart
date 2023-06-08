class AiMineTeamBean {
  String? tjUserQuantity;
  String? tjValidUserQuantity;
  String? tjJiedianUserQuantity;
  String? myAmount;
  String? teamAmount;
  String? jiedianBonus;
  String? zulinBonus;
  String? tuijianBonus;
  String? teamBonus;
  String? shareBonus;
  String? weightBonus;
  String? levelId;
  String? levelName;

  AiMineTeamBean(
      {this.tjUserQuantity,
        this.tjValidUserQuantity,
        this.tjJiedianUserQuantity,
        this.myAmount,
        this.teamAmount,
        this.jiedianBonus,
        this.zulinBonus,
        this.tuijianBonus,
        this.teamBonus,
        this.shareBonus,
        this.weightBonus,
        this.levelId,
        this.levelName});

  AiMineTeamBean.fromJson(Map<String, dynamic> json) {
    tjUserQuantity = '${json['tj_user_quantity']}';
    tjValidUserQuantity = '${json['tj_valid_user_quantity']}';
    tjJiedianUserQuantity = '${json['tj_jiedian_user_quantity']}';
    myAmount = '${json['my_amount']}';
    teamAmount = '${json['team_amount']}';
    jiedianBonus = '${json['jiedian_bonus']}';
    zulinBonus = '${json['zulin_bonus']}';
    tuijianBonus = '${json['tuijian_bonus']}';
    teamBonus = '${json['team_bonus']}';
    shareBonus = '${json['share_bonus']}';
    weightBonus = '${json['weight_bonus']}';
    levelId = '${json['levelid']}';
    levelName = '${json['level_name']}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tj_user_quantity'] = this.tjUserQuantity;
    data['tj_valid_user_quantity'] = this.tjValidUserQuantity;
    data['tj_jiedian_user_quantity'] = this.tjJiedianUserQuantity;
    data['my_amount'] = this.myAmount;
    data['team_amount'] = this.teamAmount;
    data['jiedian_bonus'] = this.jiedianBonus;
    data['zulin_bonus'] = this.zulinBonus;
    data['tuijian_bonus'] = this.tuijianBonus;
    data['team_bonus'] = this.teamBonus;
    data['share_bonus'] = this.shareBonus;
    data['weight_bonus'] = this.weightBonus;
    data['levelid'] = this.levelId;
    data['level_name'] = this.levelName;
    return data;
  }
}
