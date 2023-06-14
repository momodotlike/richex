import 'package:flutter/material.dart';
import 'package:flutter_rich_ex/base/base_controller.dart';
import 'package:flutter_rich_ex/const/constant.dart';
import 'package:flutter_rich_ex/router/routes.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_rich_ex/util/sp_util.dart';
import 'package:flutter_rich_ex/widgets/my_widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashController extends BaseController with GetSingleTickerProviderStateMixin{

  late final AnimationController lottieCtrl;

  @override
  void onInit() {
    lottieCtrl = AnimationController(vsync: this);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 1),() {
      bool isFirstEnter = SpUtil.getBool(Constant.isFirstEnter,defValue: false);
      // String token = SpUtil.getString(Constant.token,defValue: '');
      // if(isFirstEnter && token.isNotEmpty) {
      //   RouteUtil.toMain();
      //   return;
      // }
      // SpUtil.putString(Constant.contactToken,'ab44b219bfe3aebcbc1b60b12967b7a4');
      // SpUtil.putBool(Constant.IS_LOGIN,true);
      RouteUtil.toMain();
      // RouteUtil.toLogin();
    });
  }

  @override
  void dispose() {
    lottieCtrl.dispose();
    super.dispose();
  }

}

class SplashPage extends StatelessWidget {
  SplashPage({Key? key}) : super(key: key);

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar('ttt'),
      // body: Lottie.asset(
      //   'assets/json/splash.json',
      //   controller: controller.lottieCtrl,
      //   height: Get.height,
      //   width: Get.width,
      //   onLoaded: (composition) {
      //     // Configure the AnimationController with the duration of the
      //     // Lottie file and start the animation.
      //     controller.lottieCtrl
      //       ..duration = composition.duration
      //       ..forward();
      //   },
      // ),
      body: Stack(
        children: [
          Center(
            child: MyImg.assetImg('ic_launcher.png', 100.w, 100.h),
          ),
        ],
      ),
    );
  }
}
