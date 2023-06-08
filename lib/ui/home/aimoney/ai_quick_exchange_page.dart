import 'package:flutter_rich_ex/ui/component/my_divider.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/component/chose_type_coin_sheet.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiQuickExchangeController extends BaseController {

  RxBool hasContent = false.obs;
  RxString curCoinType = 'AIC'.obs;

  @override
  void onReady() {
    super.onReady();
  }

  toHistory() {
    Get.toNamed(AppRoutes.AI_QUICK_EX_HISTORY);
  }

}

class AiQuickExchangePage extends StatelessWidget {
  AiQuickExchangePage({Key? key}) : super(key: key);
  late AiQuickExchangeController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiQuickExchangeController());
    return Scaffold(
      appBar: MyAppBar('闪兑',actions: [
        MyButton(
          width: 60.w,
          height: 50.h,
          margin: MyInsets(right: 15.w),
          onTap: () => controller.toHistory(),
          color: C.white,
          child: MyText('闪兑记录',),
        )
      ],),
      backgroundColor: C.white,
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: MyInsets(horizontal: 25.w),
      children: [
        MyText('支付',size: 16.sp,bold: true,),
        14.h.spaceH,
        MyTextField(
          hintText: '充值数量',
          autofocus: false,
          contentPadding: MyInsets(vertical: 10.h,left: 12.w),
          suffixIcon: Container(
            width: 98.w,
            alignment: Alignment.centerRight,
            padding: MyInsets(right: 12.w),
            child: Row(
              children: [
                MyGestureDetector(
                  onTap: () async{
                   var res = await Get.bottomSheet(const ChoseTypeCoinSheet());
                   if(res !=null) {
                     print('res==+$res');
                     controller.curCoinType.value = res;
                   }
                  },
                  child: Obx(() => MyText(controller.curCoinType.value,color: C.f333,bold: true,)),
                ),
                MyDivider(height: 16.h,width: 1,color: C.mainColor,margin: MyInsets(horizontal: 15.w),),
                MyText('全部',color: C.f333,bold: true,),
              ],
            ),
          ),
        ),
        10.h.spaceH,
        MyText('钱包余额： 0 ',size: 12.sp,),


        26.h.spaceH,
        MyImg.assetImg('home/ai/ic_ai_quik_exchange.png', 44.w, 44.h),
        18.h.spaceH,


        MyText('得到',size: 16.sp,bold: true,),
        14.h.spaceH,
        MyTextField(
          hintText: '0',
          autofocus: false,
          contentPadding: MyInsets(vertical: 10.h,left: 12.w),
          suffixIcon: Container(
            width: 60.w,
            alignment: Alignment.centerRight,
            padding: MyInsets(right: 12.w),
            child: MyText('USDT',color: C.f333,bold: true,),
          ),
        ),
        10.h.spaceH,
        MyText('钱包余额： 0 ',size: 12.sp,),

        150.h.spaceH,
        Row(
          children: [
            MyImg.icQues,
            10.w.spaceW,
            MyText('1AIC=1USDT,扣除手续费扣8%',color: C.ffa8c35,),
          ],
        ),
        20.h.spaceH,
        _btn(),
      ],
    );
  }

  _btn() {
    return MyButton(
      textColor: C.f333,
      height: 44.h,
      width: Get.width - 24.w,
      text: '确认',
      round: 22.0,
      color: controller.hasContent.isTrue ? C.mainColor : C.fe3e3e3,
      onTap: () {
      },
    );
  }
}
