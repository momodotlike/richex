import 'package:flutter_rich_ex/ui/login/login_page.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class RouteAuthMiddleware extends GetMiddleware {

  RouteAuthMiddleware();

  @override
  RouteSettings? redirect(String? route) {
    return super.redirect(route);
  }

  //创建任何内容之前调用此函数
  @override
  GetPage? onPageCalled(GetPage? page) {
    String token = SpUtil.getString(Constant.token,defValue: '');
    print('token==$token');
    if(token.isEmpty) {
      return GetPage(name: AppRoutes.LOGIN, page: () => LoginPage());
    }
    return super.onPageCalled(page);
  }

  //此函数将在绑定初始化后立即调用。在这里，您可以在创建绑定之后和创建页面小部件之前执行一些操作
  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) {
    return super.onPageBuildStart(page);
  }

  //该函数将在调用 GetPage.page 函数后立即调用，并为您提供函数的结果。并获取将显示的小部件
  @override
  Widget onPageBuilt(Widget page) {
    return super.onPageBuilt(page);
  }

  //此函数将在处理完页面的所有相关对象（控制器、视图等）后立即调用
  @override
  void onPageDispose() {
    print('onPageDispose -----${Get.currentRoute}');
    super.onPageDispose();
  }

}