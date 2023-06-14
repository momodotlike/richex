import 'package:flutter_rich_ex/bean/area_code_info.dart';
import 'package:flutter_rich_ex/router/routes.dart';
import 'package:flutter_rich_ex/service/user_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_rich_ex/util/timer_util.dart';
import 'package:get/get.dart';

class ForgetPwdController extends BaseController {

  Rx<TextEditingController> newPwdCtrl = TextEditingController().obs;
  Rx<TextEditingController> confirmPwdCtrl = TextEditingController().obs;
  Rx<TextEditingController> codeCtrl = TextEditingController().obs;
  RxBool showPwd = false.obs;

  late TimerUtil mCountDownTimerUtil;
  final String NOR_COUNT_TIME = '获取验证码'.tr;
  RxString countTime = '获取验证码'.tr.obs;
  RxBool btnEnable = true.obs;
  RxBool checkBtnEnable = false.obs;

  String phoneCodeStr = '';
  RxBool showInputContent = false.obs;

  @override
  void onReady() {
    super.onReady();
    initTimer();
    initListener();
  }

  initTimer() {
    mCountDownTimerUtil = TimerUtil(mInterval: 1000, mTotalTime: 60 * 1000);
    mCountDownTimerUtil.setOnTimerTickCallback((int tick) {
      int _tick = tick ~/ 1000;
      countTime.value = '${_tick}s';
      if (_tick.toInt() == 0) {
        countTime.value = '获取验证码'.tr;
        mCountDownTimerUtil.setTotalTime(60 * 1000);
      }
    });
  }

  initListener() {
    newPwdCtrl.value.addListener(() {
      checkBtnEnable.value = checkPwd();
    });
    confirmPwdCtrl.value.addListener(() {
      checkBtnEnable.value = checkPwd();
    });
    codeCtrl.value.addListener(() {
      checkBtnEnable.value = checkPwd();
    });

  }

  checkPwd() {
    return newPwdCtrl.value.text.isNotEmpty && confirmPwdCtrl.value.text.isNotEmpty && codeCtrl.value.text.isNotEmpty;
  }

  startTimer() async{
    var mobile = phoneCodeStr.trim();
    if(countTime.value != NOR_COUNT_TIME) return;
    if(mobile.isEmpty) {
      Util.showToast('手机号不能为空'.tr);
      return;
    }
    mCountDownTimerUtil.startCountDown();
    var data = {
      'mobile': mobile,
      'code': Constant.SMS_LOGIN
    };
  }

  toLogin() async{
    var data = {
      'mobile': '15502013146',
      'password': '123456',
    };
    bool result = await UserService.loginPre(data);
    if(result) {
      SpUtil.putBool(Constant.IS_LOGIN,true);
      RouteUtil.toMain();
    }
  }

  void checkIsEmail() {
    showInputContent.value = phoneCodeStr.isNotEmpty;
  }
}

class ForgetPwdPage extends StatelessWidget {
  ForgetPwdPage({Key? key}) : super(key: key);
  final ForgetPwdController controller = Get.put(ForgetPwdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('找回密码'.tr),
      backgroundColor: C.white,
      body: Obx(() {
        String curStr = '下一步'.tr;
        if(controller.showInputContent.isTrue) {
          curStr = '确认'.tr;
        }
        return Stack(
          children: [
            _body(),
            Positioned(
                left: 12.w,
                right: 12.w,
                bottom: 50.h,
                child: MyButton(
                  round: 30.w,
                  height: 44.h,
                  width: Get.width - 24.w,
                  color: C.mainColor,
                  onTap: () {
                    Get.back();
                  },
                  child: MyText(curStr,color: C.f333,),
                )
            )
          ],
        );
      }),
    );
  }

  _body() {
    return Container(
      padding: MyInsets(horizontal: 15.w),
      child: ListView(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyImg.icQues,
                10.w.spaceW,
                MyText('找回密码后,1小时无法提币 '.tr,color: C.ffa8c35,size: 15.sp,),
              ],
            ),
          ),
          20.h.spaceH,
          Container(
            height: 44.h,
            child: MyTextField(
              hintStyle: TextStyle(color: C.f999,fontSize: 14.sp),
              hintText: '请输入您的邮箱或手机号码'.tr,
              contentPadding: MyInsets(vertical: 12.h,left: 15.w),
              onChanged: (v) {
                controller.phoneCodeStr = v.trim();
                controller.checkIsEmail();
              },
            ),
          ),
          if(controller.showInputContent.isTrue)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.h.spaceH,
              _phoneLoginItem('输入新密码'.tr,controller.newPwdCtrl.value,showPwd: true),
              24.h.spaceH,
              _phoneLoginItem('确认新密码'.tr,controller.confirmPwdCtrl.value,showPwd: true),
              24.h.spaceH,
              _phoneLoginItem('请输入验证码'.tr,controller.codeCtrl.value,showVerify: true),
            ],
          ),

          // Obx(() => MyButton(
          //   margin: MyInsets(top: 30.h,bottom: 10.h),
          //   width: 300.w,
          //   height: 50.h,
          //   round: 30.w,
          //   color: controller.loginBtnEnable.isTrue ? C.mainColor : C.fe3e3e3,
          //   onTap: () {
          //
          //   },
          //   child: MyText('登录',color: C.f333,size: 16.sp,),
          // )),
        ],
      ),
    );
  }

  _phoneLoginItem(String hint,TextEditingController ctrl,{bool showVerify = false, bool showPwd = false}) {

    BorderRadius borderRadius = BorderRadius.circular(24);
    if(showVerify) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(24),
        bottomLeft: Radius.circular(24),
      );
    }

    return Container(
      height: 40.h,
      child: Row(
        children: [
          Expanded(child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: C.f999,fontSize: 14.sp),
              contentPadding: const MyInsets(vertical: 13, left: 12),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: C.ff6f6f6,width: 1),
                borderRadius: borderRadius,
              ),
              fillColor: C.ff6f6f6,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: C.ff6f6f6,width: 1),
                  borderRadius: borderRadius,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: C.ff6f6f6,width: 1),
                  borderRadius: borderRadius
              ),
              suffixIcon: showPwd ? IconButton(
                icon: Icon(
                  controller.showPwd.isFalse ? Icons.visibility : Icons.visibility_off,
                  size: 20,
                  color: C.f9e9e9e,
                ),
                onPressed: () {
                  controller.showPwd.value = !controller.showPwd.value;
                },
              ) : null,
            ),
            controller: ctrl,
          )),
          if(showVerify)
            Obx(() => Container(
                width: 118.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: controller.btnEnable.isFalse ? C.fc4c4c4 : C.fa4ff74,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(24),
                      bottomRight: Radius.circular(24)
                    )
                ),
                child: MyGestureDetector(
                  // text: controller.countTime.value,
                  // textSize: 12.sp,
                  // color: controller.countTime.value == controller.NOR_COUNT_TIME ? C.mainColor : C.fc4c4c4,
                  // textColor: C.white,
                  onTap: () {
                    if(controller.countTime.value != controller.NOR_COUNT_TIME) return;
                    if(controller.phoneCodeStr.isEmpty) {
                      Util.showToast('手机号不能为空'.tr);
                      return;
                    }
                    controller.startTimer();
                  },
                  child: MyText(controller.countTime.value,color: C.f333,size: 14.sp,),
                )
            ))
        ],
      ),
    );
  }
}
