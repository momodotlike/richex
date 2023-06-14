import 'package:flutter/services.dart';
import 'package:flutter_rich_ex/bean/ex_detail_bean.dart';
import 'package:flutter_rich_ex/dialog/custom_dialog.dart';
import 'package:flutter_rich_ex/dialog/info_dialog.dart';
import 'package:flutter_rich_ex/service/ai/ai_quick_ex_service.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/component/chose_type_coin_sheet.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiQuickExchangeController extends BaseController {

  RxBool hasContent = false.obs;
  RxString curCoinType = 'AIT'.obs;
  final String TYPE_AIC = 'AIC';
  final String TYPE_AIT = 'AIT';

  Rx<ExDetailBean> detailBean = ExDetailBean().obs;
  RxString coinCount = '0'.obs;
  RxString usdtCount = '0'.obs;
  TextEditingController ctrl = TextEditingController();
  RxString getCount = '0'.obs;
  RxString feeContent = '0'.obs;

  @override
  void onReady() {
    super.onReady();
    getData();
    initListener();
  }

  initListener() {
    ctrl.addListener(() {
      exChangeCoin();
    });
  }

  exChangeCoin() {
    var aic = detailBean.value.commissionList?.aICCommission;
    var ait = detailBean.value.commissionList?.aITCommission;
    var cur = curCoinType.value;
    var inputContent = ctrl.text.trim();
    hasContent.value = inputContent.isNotEmpty;

    var fee = '';
    var ex = '1';
    if(curCoinType.value == TYPE_AIC) {
      fee = aic?.commission??'0';
      ex = aic?.bili??'1';
    }else {
      fee = ait?.commission??'0';
      ex = ait?.bili??'1';
    }
    getCount.value = '${inputContent.toInt() * int.parse(ex)}';
    feeContent.value = '${num.parse(fee) * 100}';
  }

  getData() async{
    var res = await AiQuickExService.getDetail();
    if(res !=null) {
      detailBean.value = ExDetailBean.fromJson(res);
      checkCoin();
      exChangeCoin();
    }
  }

  checkCoin() {
    if(curCoinType.value == TYPE_AIC) {
      coinCount.value = '${detailBean.value.accountList?.aIC}';
    }else {
      coinCount.value = '${detailBean.value.accountList?.aIT}';
    }
    exChangeCoin();
  }

  toHistory() {
    Get.toNamed(AppRoutes.AI_QUICK_EX_HISTORY);
  }

  void submitExChange() async{
    var amount = ctrl.text.trim();
    if(amount.isEmpty) {
      Util.showToast('兑换数量不能为空'.tr);
      return;
    }

    if(num.parse(amount) > num.parse(coinCount.value)) {
      Util.showToast('兑换数量不能大于钱包余额'.tr);
      return;
    }

    var confirm = await Get.dialog(CustomDialog(
      title: '温馨提示'.tr,
      content: '是否确认兑换'.tr + ' $amount ${curCoinType.value}',
      type: DialogType.FORWARD,
      rightText: '确认'.tr,
      leftText: '取消'.tr,
    ));

    if(confirm ==null || !confirm) {
      return;
    }

    var query = {
      'type': curCoinType.value == TYPE_AIT ? '1' : '2',
      'amount': amount,
    };
    var res = await AiQuickExService.exchangeAction(query);
    Util.showToast(res['msg']);
    if(res['code'] == Constant.code200) {
      await getData();
      ctrl.clear();
      hasContent.value = false;
    }
  }

}

class AiQuickExchangePage extends StatelessWidget {
  AiQuickExchangePage({Key? key}) : super(key: key);
  late AiQuickExchangeController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiQuickExchangeController());
    return Scaffold(
      appBar: MyAppBar('闪兑'.tr,actions: [
        MyButton(
          width: 60.w,
          height: 50.h,
          margin: MyInsets(right: 15.w),
          onTap: () => controller.toHistory(),
          color: C.white,
          child: MyText('闪兑记录'.tr,),
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
        MyText('支付'.tr,size: 16.sp,bold: true,),
        14.h.spaceH,
        MyTextField(
          hintText: '充值数量'.tr,
          autofocus: false,
          controller: controller.ctrl,
          contentPadding: MyInsets(vertical: 10.h,left: 12.w),
          keyboardType: TextInputType.number,
          inputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
          ],
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
                     controller.ctrl.clear();
                     controller.hasContent.value = false;
                     controller.checkCoin();
                     // controller.exChangeCoin();
                   }
                  },
                  child: Obx(() => MyText(controller.curCoinType.value,color: C.f333,bold: true,)),
                ),
                MyDivider(height: 16.h,width: 1,color: C.mainColor,margin: MyInsets(horizontal: 15.w),),
                GestureDetector(
                  onTap: () {
                    controller.ctrl.text = controller.coinCount.value;
                  },
                  child: MyText('全部'.tr,color: C.f333,bold: true,),
                ),
              ],
            ),
          ),
        ),
        10.h.spaceH,
        Obx(() => MyText( '钱包余额'.tr + '： ${controller.coinCount.value} ',size: 12.sp,),),


        26.h.spaceH,
        MyImg.assetImg('home/ai/ic_ai_quik_exchange.png', 44.w, 44.h),
        18.h.spaceH,


        MyText('得到'.tr,size: 16.sp,bold: true,),
        14.h.spaceH,
        Container(
          width: Get.width,
          padding: MyInsets(horizontal: 16.w,vertical: 12.h),
          decoration: BoxDecoration(
            color: C.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: C.divider,width: 1)
          ),
          child: Row(
            children: [
              Expanded(child: Obx(() {
                return MyText(controller.getCount.value,);
              })),
              MyText('USDT',color: C.f333,bold: true,),
            ],
          ),
        ),
        10.h.spaceH,
        Obx(() => MyText('钱包余额'.tr + '： ${controller.detailBean.value.accountList?.USDT??'0'} ',size: 12.sp,)),

        150.h.spaceH,
        Row(
          children: [
            MyImg.icQues,
            10.w.spaceW,
            Obx(() {
              var aic = controller.detailBean.value.commissionList?.aICCommission;
              var ait = controller.detailBean.value.commissionList?.aITCommission;
              var cur = controller.curCoinType.value;
              var fee = '';
              var ex = '1';
              if(controller.curCoinType.value == controller.TYPE_AIC) {
                fee = aic?.commission??'0';
                ex = aic?.bili??'1';
              }else {
                fee = ait?.commission??'0';
                ex = ait?.bili??'1';
              }
              return MyText('1$cur=${1 * int.parse(ex)}USDT,' + '扣除手续费'.tr +'${controller.feeContent.value}%',color: C.ffa8c35,);
            })
          ],
        ),
        20.h.spaceH,
        Obx(() => _btn()),
      ],
    );
  }

  _btn() {
    return MyButton(
      textColor: controller.hasContent.isTrue ? C.white :  C.f333,
      height: 44.h,
      width: Get.width - 24.w,
      text: '确认'.tr,
      round: 22.0,
      color: controller.hasContent.isTrue ? C.mainColor : C.fe3e3e3,
      onTap: () {
        controller.submitExChange();
      },
    );
  }
}
