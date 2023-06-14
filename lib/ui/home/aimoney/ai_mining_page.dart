import 'package:flutter/services.dart';
import 'package:flutter_rich_ex/bean/aic_bean.dart';
import 'package:flutter_rich_ex/dialog/custom_dialog.dart';
import 'package:flutter_rich_ex/dialog/info_dialog.dart';
import 'package:flutter_rich_ex/service/ai/ai_aic_service.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/component/chart_curve_page.dart';
import 'package:flutter_rich_ex/util/date_util.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_rich_ex/util/timer_util.dart';
import 'package:get/get.dart';

class AiMingController extends BaseController {

  RxBool checkBox = false.obs;
  Rx<AicBean> detailBean = AicBean().obs;
  TextEditingController ctrl = TextEditingController();
  late TimerUtil mCountDownTimerUtil;
  RxInt curSecond = 0.obs;
  RxInt countTotalTime = 0.obs;
  RxString btnStr = '确认'.obs;

  var aicChatCurveMap = {}.obs;
  int pageIndex = 1;

  @override
  void onClose() {
    super.onClose();
    mCountDownTimerUtil?.cancel();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  initTimer() {
    mCountDownTimerUtil = TimerUtil(mInterval: 1000,);
    mCountDownTimerUtil.setTotalTime(countTotalTime.value);
    mCountDownTimerUtil.setOnTimerTickCallback((int tick) {
      int _tick = tick ~/ 1000;
      countTotalTime.value --;
      print('mCountDownTimerUtil ${_tick} --${countTotalTime.value}');
      var formatStr = DateCountDownUtil.constructTime(countTotalTime.value);
      btnStr.value = '挖矿倒计时'.tr + '$formatStr';
      if (countTotalTime.value.toInt() == 0) {
        mCountDownTimerUtil.cancel();
        btnStr.value = '确认'.tr;
      }
    });
    mCountDownTimerUtil.startTimer();
  }

  loadData() async{
    var res = await AiAicService.getAicDetail();
    if(res!=null) {
      detailBean.value = res;
      checkTimer();
    }

    getKlineInfo();
  }

  getKlineInfo() async{
    var query = {
      'page_no': pageIndex,
    };
    var res = await AiAicService.aicRank(query);
    if(res !=null && res['code'] == Constant.code200) {
      aicChatCurveMap.value = res;
    }
  }

  checkTimer() {
    var startTime = detailBean.value.startTime;
    int startTimeInt = detailBean.value.startTimeInt??0;
    // startTimeInt = 1686495452;
    // print('ssss$startTimeInt');
    var today = DateTime.now();
    var todaySecond = DateTime.now().millisecondsSinceEpoch; // 毫秒
    bool isAfter = today.isAfter(DateTime.fromMillisecondsSinceEpoch(startTimeInt * 1000));
    if(!isAfter) {
      countTotalTime.value = ((startTimeInt * 1000 - todaySecond) ~/ 1000).toInt();
      initTimer();
    }
  }

  toMingSecret() {
    Get.toNamed(AppRoutes.AI_MING_SECRET);
  }

  void toSubmitAction() async{
    if(btnStr.value != '确认'.tr) {
      return;
    }
    var count = ctrl.text.trim();
    if(count == '0' || count.isEmpty) {
      Util.showToast('数量不能为0'.tr);
      return;
    }

    var ait = detailBean.value.accountList?.aIT;
    if(double.parse(count) > ait!) {
      Util.showToast('销毁数量不能大于持有数量'.tr);
      return;
    }

    var confirm = await Get.dialog(CustomDialog(
      title: '温馨提示'.tr,
      content: '是否确认销毁？'.tr,
      type: DialogType.FORWARD,
      rightText: '确认'.tr,
      leftText: '取消'.tr,
    ));
    if(confirm ==null || !confirm) {
      return;
    }

    var query = {
      'amount': count
    };
    var res = await AiAicService.destroyAIT(query);
    if(res !=null && res['code'] == Constant.code200) {
      var dlgRes = await Get.dialog(InfoDialog(
        content: '恭喜您销毁成功'.tr,
      ));
      Get.back();
    }else {
      Util.showToast(res['msg']);
    }
  }

}

class AiMingPage extends StatelessWidget {
  AiMingPage({Key? key}) : super(key: key);
  late AiMingController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiMingController());

    return Scaffold(
      appBar: MyAppBar('AIC挖矿'.tr,actions: [
        MyButton(
          width: 60.w,
          height: 50.h,
          margin: MyInsets(right: 15.w),
          onTap: () {
            Get.toNamed(AppRoutes.AI_ASSET);
          },
          color: C.white,
          child: MyText('AIT资产'.tr,),
        )
      ],),
      backgroundColor: C.white,
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: MyInsets(horizontal: 15.w,top: 18.h),
      children: [
        Obx(() => _headInfo()),
        Obx(() => _lineInfo()),
        30.h.spaceH,
        Obx(() => _actionInfo()),
      ],
    );
  }

  _headInfo() {
    var detail = controller.detailBean.value;
    var aic = detail.accountList?.aIC??'';
    return Container(
      child: Row(
        children: [
          _infoCard('账户余额 AIC'.tr,'$aic','交易'.tr,'账单'.tr,showBtn: true),
          7.w.spaceW,
          _infoCard('销毁数量'.tr,detail.aitXiaohuiAmount??'','产出数量'.tr,detail.aicChanchuAmount??''),
        ],
      ),
    );
  }

  _infoCard(String top,String bot,String t2,String b2,{bool showBtn = false}) {
    return Expanded(
        child: MyCard(
          height: 112.h,
          margin: MyInsets(right: 0.w),
          padding: MyInsets(all: 0.w),
          child: Stack(
            children: [
              MyImg.assetImg('home/ai/bg_ming_top.png', double.infinity, 170.h,fit: BoxFit.fill,),
              Container(
                padding: MyInsets(top: 12.h,left: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoCardItem(top,bot),
                    if(!showBtn)
                    _infoCardItem(t2,b2),
                    if(showBtn)
                    16.h.spaceH,
                    if(showBtn)
                    Row(
                      children: [
                        MyButton(
                          width: 70.w,
                          height: 28.h,
                          round: 16.0,
                          border: Border.all(color: C.white,width: 1),
                          child: MyText(t2,color: C.white,),
                          onTap: () {
                            Get.toNamed(AppRoutes.AI_QUICK_EXCHANGE);
                          },
                        ),
                        7.w.spaceW,
                        MyButton(
                          width: 70.w,
                          height: 28.h,
                          round: 16.0,
                          border: Border.all(color: C.white,width: 1),
                          child: MyText(b2,color: C.white,),
                          onTap: () {
                            Get.toNamed(AppRoutes.AI_CHECK);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }

  _infoCardItem(String top,String bot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(top,size: 12.sp,color: C.white,lineHeight: 1.6,),
        MyText(bot,color: C.white,size: 18.sp,bold: true,lineHeight: 1.6,),
      ],
    );
  }

  _lineInfo() {
    var klineInfo = controller.aicChatCurveMap.value;
    print('klineInfo===$klineInfo');
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.h.spaceH,
          MyText('AIC价格涨幅'.tr,color: C.black,size: 16.sp,bold: true,),
          Container(
            margin: MyInsets(top: 20.h,bottom: 30.h,horizontal: 10.w),
            height: 140.h,
            width: Get.width,
            child: Stack(
              children: [
                if(klineInfo['data'] !=null)
                ChartCurvePage(list: klineInfo['data'],yMax: klineInfo['max_price']??100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText('\$ ${klineInfo['dangqian_price']??''}',size: 18.sp,bold: true,),
                    Padding(
                      padding: MyInsets(top: 4.h),
                      child: MyText(' ${klineInfo['dangqian_bili']??''}%',size: 12.sp,color: C.mainColor,),
                    ),
                  ],
                ),
              ],
            ),
          ),
          20.h.spaceH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Row(
              //   children: [
              //     Container(
              //       width: 28.w,
              //       height: 8.h,
              //       color: C.ff7aa28,
              //       margin: MyInsets(right: 8.w),
              //     ),
              //     MyText('价格'.tr,color: C.black,size: 14.sp,),
              //   ],
              // ),
              Row(
                children: [
                  Container(
                    width: 28.w,
                    height: 8.h,
                    color: C.faaf687,
                    margin: MyInsets(right: 8.w),
                  ),
                  MyText('24h涨幅比利'.tr,color: C.black,size: 14.sp,),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
  _actionInfo() {
    print('详情==== ${controller.detailBean.value.toJson()}');
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText('销毁挖矿'.tr,color: C.f5f5f5f,size: 18.sp,bold: true,),
              // GestureDetector(
              //   onTap: () => controller.toMingSecret(),
              //   child: MyText('挖矿秘籍'.tr,color: C.f5f5f5f,size: 15.sp,),
              // ),
            ],
          ),
          18.h.spaceH,
          MyTextField(
            hintText: '输入销毁数量'.tr,
            autofocus: false,
            contentPadding: MyInsets(vertical: 10.h,left: 12.w),
            suffixIcon: GestureDetector(
              onTap: () {
                controller.ctrl.text = '${controller.detailBean.value.accountList?.aIT??'0'}';
              },
              child: Container(
                width: 40.w,
                alignment: Alignment.centerRight,
                padding: MyInsets(right: 12.w),
                child: MyText('全部'.tr,color: C.mainColor,bold: true,),
              ),
            ),
            keyboardType: TextInputType.number,
            inputFormatter: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: controller.ctrl,
          ),
          18.h.spaceH,
          Obx(() => MyText('账户余额'.tr + ': ${controller.detailBean.value.accountList?.aIT??'0'} AIT',size: 15.sp,),),
          18.h.spaceH,
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: MyInsets(horizontal: 10.w),
                  width: 14.w,
                  height: 14.h,
                  child: Checkbox(value: controller.checkBox.value, onChanged: (v) {
                    controller.checkBox.value = v!;
                  },activeColor: C.mainColor,),
                ),
                MyText('勾选并同意'.tr,color: C.f333),
                // MyButton(
                //   color: C.whiteBg,
                //   onTap: () {
                //   },
                //   child: MyText('DIPX理财协议',color: C.mainColor,),
                // )

              ],
            );
          }),

          80.h.spaceH,
          Obx(() => _btn()),
        ],
      ),
    );
  }

  _btn() {
    return MyButton(
      textColor: controller.checkBox.isTrue ? C.white : C.f333,
      height: 44.h,
      width: Get.width - 24.w,
      text: controller.btnStr.value.tr,
      round: 22.0,
      color: controller.checkBox.isTrue ? C.mainColor : C.fe3e3e3,
      onTap: () {
        controller.toSubmitAction();
      },
    );
  }
}

