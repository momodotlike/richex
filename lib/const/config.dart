import 'package:flutter_rich_ex/util/export.dart';

class Config {

  // 判断用户是否登录
  static bool isLogin() {
    var contactToken = SpUtil.getString(Constant.contactToken,defValue: '');
    return SpUtil.getBool(Constant.IS_LOGIN) && contactToken.isNotEmpty;
  }
}