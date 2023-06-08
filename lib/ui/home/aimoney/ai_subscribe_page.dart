import 'package:flutter_rich_ex/bean/invest_bean.dart';
import 'package:flutter_rich_ex/dialog/custom_dialog.dart';
import 'package:flutter_rich_ex/event/event.dart';
import 'package:flutter_rich_ex/service/ai/invest_service.dart';
import 'package:flutter_rich_ex/service/user_service.dart';
import 'package:flutter_rich_ex/util/date_util.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiSubscribeController extends BaseController {

  RxString curTab = '收益明细'.obs;
  RxBool showMoney = true.obs;
  String starMoney = '***';
  RxBool checkBox = false.obs;

  var id; // 租赁id
  Rx<ZulinBean> detailBean = ZulinBean().obs;
  RxString ableCount = ''.obs;
  RxBool isShowDetail = false.obs;
  TextEditingController ctrl = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    isShowDetail.value = Get.arguments['hasBuyNode'];
    id = Get.arguments['id'];
    curTab.value = '智能理财';
    getData();
  }

  getData() async{
    var res = await InvestService.getDetail(id);
    if(res != null) {
      InvestBean bean = res;
      detailBean.value = bean.zulin!;
      ableCount.value = '${bean.totalBalance??''}';
    }
  }

  toRule() {
    Get.toNamed(AppRoutes.AI_RULE);
  }

  void toCheckSubscribe() async{
    var mount = ctrl.text.trim();
    if(mount.isEmpty) { // 不为100的整数
      Util.showToast('申购额度格式不能为空');
      return;
    }
    try {
      var t = double.parse(mount) % 100 == 0;
      if(!t) {
        Util.showToast('格式不正确');
        return;
      }
    }catch(e) {
      Util.showToast('格式不正确');
      return;
    }
    // 已认证
    var query = {
      'zulin_id' : id,
      'amount' : mount,
    };
    var res = await InvestService.subscribeAction(query);
    print('结果====$res');
    if(res) {
      var confirm = await Get.dialog(CustomDialog(
        title: '温馨提示',
        content: '恭喜您成功购买  $mount  USDT 智能理财产品。',
        type: DialogType.FORWARD,
        rightText: '查询记录',
        leftText: '取消',
      ));

      if(confirm !=null && confirm) {
        eventBus.fire(RefreshAiMineNavEvent());
        Get.back(result: 2);
      }else {
        Get.back();
      }
    }

    // var res = await UserService.isRealName();
    // if(res !=null) {
    //   bool isAuth = res['authflag'] == 1; // =1 未认证
    //   String msg = res['authflag_msg'];
    //   if(!isAuth) { // 未认证
    //     var confirm = await Get.dialog(const CustomDialog(
    //       title: '温馨提示',
    //       content: '您尚未通过实名认证，暂时不能参与投资该理\n财产品。',
    //       type: DialogType.FORWARD,
    //       rightText: '立即认证',
    //       leftText: '取消',
    //     ));
    //     if(confirm !=null && confirm) {
    //       Util.showToast('跳转到实名认证页面');
    //       return;
    //     }
    //   }else {
    //     var mount = ctrl.text.trim();
    //     if(mount.isEmpty) { // 不为100的整数
    //       Util.showToast('申购额度格式不正确');
    //       return;
    //     }
    //     // 已认证
    //     var query = {
    //       'zulin_id' : id,
    //       'amount' : mount,
    //     };
    //     var res = await InvestService.subscribeAction(query);
    //     print('结果====$res');
    //     if(res) {
    //       var confirm = await Get.dialog(CustomDialog(
    //         title: '温馨提示',
    //         content: '恭喜您成功购买  $mount  USDT 智能理财产品。',
    //         type: DialogType.FORWARD,
    //         rightText: '查询记录',
    //         leftText: '取消',
    //       ));
    //
    //       if(confirm !=null && confirm) {
    //         Util.showToast('跳转到查询记录页面');
    //         return;
    //       }
    //     }
    //   }
    // }

  }

}
class AiSubscribePage extends StatelessWidget {

  AiSubscribePage({Key? key}) : super(key: key);

  late AiSubscribeController controller ;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiSubscribeController());
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar(
        '',
        centerTitle: Obx(() => MyText(controller.curTab.value,size: 18.sp,)),
        actions: [
          GestureDetector(
            onTap: () => controller.toRule(),
            child: Container(
              alignment: Alignment.centerRight,
              margin: MyInsets(right: 15.w),
              child: MyText('规则'),
            ),
          )
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: MyInsets(horizontal: 14.w,top: 20.h),
      children: [
        Obx(() => _info()),
        _limitInfo(),
        Obx(() => _btn()),
      ],
    );
  }

  _info() {
    ZulinBean bean = controller.detailBean.value;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyImg.assetImg('home/ai/ic_invest_list_usdt.png', 27.w, 27.h),
            8.w.spaceW,
            MyText('USDT',size: 18.sp,),
            10.w.spaceW,
            MyButton(
              round: 6.0,
              color: C.mainColor.withOpacity(0.8),
              width: 42.w,
              height: 16.h,
              textColor: C.white,
              textSize: 10.sp,
              text: '第一期',
            )
          ],
        ),
        30.h.spaceH,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText('${bean.minZulinAmount??''} USDT / 0.001%',size: 13.sp,color: C.f5f5f5f,),
            MyText('${bean.maxZulinAmount??''} USDT',size: 13.sp,color: C.f5f5f5f,),
          ],
        ),
        Stack(
          children: [
            Container(
              height: 7.h,
              width: Get.width,
              color: C.fe2e2e2,
              margin: MyInsets(bottom: 20.h,top: 6.h),
            ),
            Container(
                height: 7.h,
                color: C.mainColor,
                width: (double.parse(bean.ownZulinAmount??'0') / double.parse(bean.maxZulinAmount??'1')) * Get.width,
                margin: MyInsets(bottom: 20.h,top: 6.h),
            )
          ],
        ),

        _infoItem('最大利率','${bean.maxPer??''} %'),
        _infoItem('预计年化','${bean.nianhuaPer??''} %'),
        _infoItem('申购限额','${controller.detailBean.value.minZulinAmount??''}-${controller.detailBean.value.maxZulinAmount??''}'),
        // _infoItem('预计利息','6.6484 AIT'),
        _infoItem('起息日期',DateUtil.formatDate(DateTime.now().add(const Duration(days: 2)),format: DateFormats.y_mo_d_h_m)),
      ],
    );
  }

  _limitInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        24.h.spaceH,
        MyText('申购额度',size: 18.sp,color: C.f333,bold: true,),
        MyTextField(
          hintText: '100 USDT 倍数起 ',
          autofocus: false,
          contentPadding: MyInsets(vertical: 10.h,left: 12.w),
          suffixIcon: MyGestureDetector(
            onTap: () {
              controller.ctrl.text = controller.ableCount.value;
            },
            child: Container(
              width: 40.w,
              alignment: Alignment.centerRight,
              padding: MyInsets(right: 12.w),
              child: MyText('全部',color: C.mainColor,bold: true,),
            ),
          ),
          controller: controller.ctrl,
          keyboardType: TextInputType.number,
        ),
        18.h.spaceH,
        Obx(() => MyText('   账户余额:${controller.ableCount.value} USDT',size: 15.sp,)),
        22.h.spaceH,
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
              MyText('勾选并同意',color: C.f333),
              // MyButton(
              //   color: C.white,
              //   onTap: () {
              //
              //   },
              //   child: MyText(' DIPX理财协议',color: C.mainColor,),
              // )

            ],
          );
        }),
        40.h.spaceH,
        Row(
          children: [
            MyImg.icQues,
            10.w.spaceW,
            // MyText('不返本金,只产生利息,手续费本金扣8%',color: C.ffa8c35,),
            MyText('利息奖励AIT',color: C.ffa8c35,),
          ],
        ),
        20.h.spaceH,
      ],
    );
  }

  _btn() {
    return MyButton(
      textColor: controller.checkBox.isTrue ? C.white : C.f333,
      height: 44.h,
      width: Get.width - 24.w,
      text: '确认申购',
      round: 22.0,
      color: controller.checkBox.isTrue ? C.mainColor : C.fe3e3e3,
      onTap: () {
        controller.toCheckSubscribe();
      },
    );
  }

  _infoItem(String left,String right) {
    return Padding(
      padding: MyInsets(bottom: 5.h),
      child: Row(
        children: [
          MyText(left,size: 15.sp,color: C.f5f5f5f,),
          30.w.spaceW,
          MyText(right,size: 18.sp,color: C.f333,bold: true,),
        ],
      ),
    );
  }
}
