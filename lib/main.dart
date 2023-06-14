import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rich_ex/internationalization/message.dart';
import 'package:flutter_rich_ex/ui/tab/home_page.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  var token = Uri.base.queryParameters['token'];
  var language = Uri.base.queryParameters['language'];
  print('当前token=====================================$token');
  print('当前language=====================================$language');
  // if(kDebugMode) {
  //   token = '03dedf4b6a3cdcc6beeae9701247cb68';
  // }
  if(token !=null && "$token".isNotEmpty) {
    SpUtil.putString(Constant.contactToken, token);
    SpUtil.putBool(Constant.IS_LOGIN,true);
  }
  // if(kDebugMode) {
  //   language = 'en';
  // }
  SpUtil.putString(Constant.language, '$language');
  if(!kIsWeb) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // 状态栏透明（Android）
    var brightness = Platform.isAndroid ? Brightness.dark : Brightness.light;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness,
    ));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375.0, 812.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx, widget) {
        var language = SpUtil.getString(Constant.language);
        var c = Locale(language);
        print('language-------$language-------------Local======$c');

        return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          enableLog: true,
          builder: EasyLoading.init(),
          title: "FUJI",
          getPages: AppPages.routes,
          // initialRoute: AppRoutes.SPLASH,
          initialRoute: AppRoutes.AI_MONEY,
          initialBinding: MainBinding(),
          translations: Messages(), // 你的翻译
          fallbackLocale: const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
          // locale: Get.deviceLocale, // 跟谁手机系统切换
          locale: Locale(language),
          theme: ThemeData(
              scaffoldBackgroundColor: C.whiteBg
          ),
        ).call((v) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => Util.stopInput(),
            child: v,
          );
        });
      },
    );
  }
}

class MainBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}