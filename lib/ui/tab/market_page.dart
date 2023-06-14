import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText('行情'),
          MyButton(
            textColor: C.white,
            text: 'setting_language'.tr,
            onTap: () {
              var c = Get.deviceLocale;
              print('当前语言 $c');
              Get.updateLocale(const Locale('zh', 'CN'));
            },
          ),
        ],
      )
    );
  }
}
