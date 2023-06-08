import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class RouteUtil {

  static forceUpdate() {
    Get.forceAppUpdate();
  }

  static toLogin() {
    Get.offNamed(AppRoutes.LOGIN);
  }

  static toMain() async{
    return await Get.offNamed(AppRoutes.MAIN);
  }

  static toNewPage(String appPath, Map<String, dynamic>? params) async{
    return await Get.toNamed(appPath, arguments: params);
  }

  static back() {
    Get.back();
  }

  static cleanUserInfo() {
    SpUtil.putString(Constant.token, '');
    SpUtil.putBool(Constant.IS_LOGIN,false);
    var route = Get.currentRoute;
    if(route == AppRoutes.LOGIN) {
      return;
    }
    Get.offAllNamed(AppRoutes.LOGIN);
  }
}