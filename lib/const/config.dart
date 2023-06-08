import 'package:flutter_rich_ex/util/export.dart';

class Config {

  // 判断用户是否登录
  static bool isLogin() {
    return SpUtil.getBool(Constant.IS_LOGIN);
  }
}