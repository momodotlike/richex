import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter_rich_ex/bean/area_code_info.dart';
import 'package:flutter_rich_ex/router/routes.dart';
import 'package:flutter_rich_ex/service/user_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_rich_ex/util/timer_util.dart';
import 'package:get/get.dart';

class RegisterController extends BaseController {

  Rx<TextEditingController> accCtrl = TextEditingController().obs;
  Rx<TextEditingController> pwdCtrl = TextEditingController().obs;
  RxBool showPwd = false.obs;
  RxBool checkBox = false.obs;

  late TimerUtil mCountDownTimerUtil;
  final String NOR_COUNT_TIME = '获取验证码';
  RxString countTime = '获取验证码'.obs;
  RxBool btnEnable = false.obs;
  RxBool loginBtnEnable = false.obs;
  RxString currAreaCode = 'USA'.obs;

  RxString curLoginType = '邮箱'.obs;
  final String TYPE_EMAIL = '邮箱';
  final String TYPE_PHONE = '手机号';

  RxString curCodeStr = '+86'.obs;

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
        countTime.value = '获取验证码';
        mCountDownTimerUtil.setTotalTime(60 * 1000);
      }
    });
  }

  initListener() {
    accCtrl.value.addListener(() {
      btnEnable.value = checkEnable();
      loginBtnEnable.value = checkTwoEnable();
    });
    pwdCtrl.value.addListener(() {
      loginBtnEnable.value = checkTwoEnable();
    });
  }

  checkEnable() {
    return accCtrl.value.text.trim().isNotEmpty;
  }

  checkTwoEnable() {
    return accCtrl.value.text.trim().isNotEmpty && pwdCtrl.value.text.trim().isNotEmpty;
  }

  startTimer() async{
    var mobile = accCtrl.value.text.trim();
    if(countTime.value != NOR_COUNT_TIME) return;
    if(mobile.isEmpty) {
      Util.showToast('手机号不能为空');
      return;
    }
    print('当前内容===${accCtrl.value.text}');
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

  void toRegister() {
    Get.toNamed(AppRoutes.FORGET_PWD);
  }

  void toAreaCodeList() async{
    var res = await Get.toNamed(AppRoutes.AREA_CODE);
    print('当前结果$res');
    if(res !=null) {
      curCodeStr.value = res;
    }
  }
}

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: MyInsets(horizontal: 15.w),
      child: ListView(
        padding: MyInsets(top: Get.mediaQuery.padding.top.h + 20.h),
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // MyText('登录',color: C.f131a22,size: 18.sp,),
                MyGestureDetector(
                  onTap: () => Get.back(),
                  child: MyText('去登录',color: C.f999,size: 16.sp,),
                ),
              ],
            ),
          ),
          100.h.spaceH,
          MyImg.assetImg('login/ic_login_logo.png', 194.w, 88.h),
          96.h.spaceH,
          Container(
            margin: MyInsets(bottom: 12.h),
            child: Obx(() {
              return Row( // curLoginType
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyGestureDetector(
                      onTap: () {
                        controller.curLoginType.value = controller.TYPE_EMAIL;
                      },
                      child: MyText('邮箱',color: controller.curLoginType.value == controller.TYPE_EMAIL ? C.f131a22 : C.f999,size: 18.sp,)
                  ),
                  MyGestureDetector(
                      onTap: () {
                        controller.curLoginType.value = controller.TYPE_PHONE;
                      },
                      child: MyText('手机号',color: controller.curLoginType.value == controller.TYPE_PHONE ? C.f131a22 : C.f999,size: 16.sp,)
                  ),
                ],
              );
            }),
          ),

          Obx(() {
            if(controller.curLoginType.value == controller.TYPE_EMAIL) {
              return MyCard(
                  child: Column(
                    children: [
                      _areaItem(),
                      16.h.spaceH,
                      _phoneLoginItem('请输入您的邮地址',controller.accCtrl.value,),
                      16.h.spaceH,
                      _phoneLoginItem('请输入验证码',controller.pwdCtrl.value,showVerify: true),
                      16.h.spaceH,
                      _phoneLoginItem('邀请码（必填）',controller.pwdCtrl.value),
                    ],
                  )
              );
            }
            return MyCard(
                child: Column(
                  children: [
                    _phoneLoginItem('请输入您的邮箱或手机号码',controller.accCtrl.value,showPre: true),
                    16.h.spaceH,
                    _phoneLoginItem('请输入密码',controller.pwdCtrl.value,showPwd: true),
                    16.h.spaceH,
                    _phoneLoginItem('邀请码（必填）',controller.pwdCtrl.value),
                  ],
                )
            );
          }),

          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(value: controller.checkBox.value, onChanged: (v) {
                  controller.checkBox.value = v!;
                },activeColor: C.mainColor,),
                MyText('勾选同意',color: C.f333),
                if(controller.curLoginType.value == controller.TYPE_EMAIL)
                MyButton(
                  color: C.whiteBg,
                  onTap: () {
                  },
                  child: MyText('用户服务协议',color: C.mainColor,),
                )
              ],
            );
          }),

          Obx(() => MyButton(
            margin: MyInsets(top: 30.h,bottom: 10.h),
            width: 300.w,
            height: 50.h,
            round: 30.w,
            color: controller.loginBtnEnable.isTrue ? C.mainColor : C.fe3e3e3,
            onTap: () {

            },
            child: MyText('登录',color: C.f333,size: 16.sp,),
          )),
        ],
      ),
    );
  }

  _phoneLoginItem(String hint,TextEditingController ctrl,{bool showVerify = false, bool showPwd = false, bool showPre = false}) {

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
              prefixIcon: showPre ? MyGestureDetector(
                onTap: () {
                  controller.toAreaCodeList();
                },
                child: Container(
                  padding: MyInsets(left: 10.w),
                  child: Row(
                    children: [
                      MyText('${controller.curCodeStr.value}  '),
                      MyImg.icArrDown
                    ],
                  ),
                ),
              ) : null
            ),
            controller: ctrl,
          )),
          if(showVerify)
            Obx(() => Container(
                width: 118.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: controller.btnEnable.isFalse ? C.fc4c4c4 : C.mainColor,
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
                    if(controller.accCtrl.value.text.isEmpty) {
                      Util.showToast('手机号不能为空');
                      return;
                    }
                    controller.startTimer();
                  },
                  child: MyText(controller.countTime.value,color: controller.btnEnable.isFalse ? C.f333 : C.white,size: 14.sp,),
                )
            ))
        ],
      ),
    );
  }

  _areaItem() {
    return Container(
      height: 40.h,
      padding: MyInsets(horizontal: 15.w),
      decoration: BoxDecoration(
          color: C.ff6f6f6,
          borderRadius: const BorderRadius.all(Radius.circular(24))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText('USA',size: 18.sp,),
          Icon(Icons.keyboard_arrow_right_outlined,size: 20.sp,color: C.f999,)
        ],
      ),
    );
  }
}
