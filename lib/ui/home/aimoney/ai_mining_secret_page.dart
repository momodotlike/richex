import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiMingSecretController extends BaseController {

  RxBool checkBox = false.obs;

  @override
  void onReady() {
    super.onReady();
  }
}

class AiMingSecretPage extends StatelessWidget {
  AiMingSecretPage({Key? key}) : super(key: key);
  late AiMingSecretController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiMingSecretController());

    return Scaffold(
      appBar: MyAppBar('挖矿秘籍'),
      backgroundColor: C.white,
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: MyInsets(horizontal: 25.w,top: 30.h),
      child: MyText("""AIT=USDT  闪兑 扣8%手续费 比例1：1   
 
AIC的产出多少根据当前 销毁AIT的数量和当天AIC的单价计算。

例如销毁100AIT,扣除1%手续费 = 99 ATI 产出 1%计算 9.9/单价0.1 就是产出99个AIC 例如明天价格上涨10%,依旧是9.9/0.11=90个 给的数量就变少了。 """,
      lineHeight: 1.8,),
    );
  }

}

