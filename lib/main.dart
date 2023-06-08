import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rich_ex/ui/tab/home_page.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // 状态栏透明（Android）
  var brightness = Platform.isAndroid ? Brightness.dark : Brightness.light;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness: brightness,
    statusBarIconBrightness: brightness,
  ));
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
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          enableLog: true,
          builder: EasyLoading.init(),
          title: "RichEx",
          getPages: AppPages.routes,
          initialRoute: AppRoutes.SPLASH,
          initialBinding: MainBinding(),
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