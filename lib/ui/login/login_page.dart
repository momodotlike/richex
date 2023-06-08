import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_rich_ex/bean/area_code_info.dart';
import 'package:flutter_rich_ex/router/routes.dart';
import 'package:flutter_rich_ex/service/login_service.dart';
import 'package:flutter_rich_ex/service/user_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_rich_ex/util/timer_util.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {

  Rx<TextEditingController> accCtrl = TextEditingController().obs;
  Rx<TextEditingController> pwdCtrl = TextEditingController().obs;
  RxBool showPwd = false.obs;
  RxBool checkBox = false.obs;

  late TimerUtil mCountDownTimerUtil;
  final String NOR_COUNT_TIME = '获取验证码';
  RxString countTime = '获取验证码'.obs;
  RxBool btnEnable = false.obs;
  RxBool loginBtnEnable = false.obs;
  RxString currAreaCode = '852'.obs;

  List<AreaCodeInfo> areaCodeList = [
    AreaCodeInfo(code: 852,country: '香港'),
    AreaCodeInfo(code: 886,country: '台湾'),
    AreaCodeInfo(code: 853,country: '澳门'),
    AreaCodeInfo(code: 81,country: '日本'),
    AreaCodeInfo(code: 66,country: '泰国'),
  ];

  RxString curLoginType = '验证码'.obs;
  final String TYPE_PWD = '密码';
  final String TYPE_CODE = '验证码';

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

    mobile = 'chauubhfklfunmsoul@bbitj.com';

    var res = await LoginService.sendCode(name: mobile,from: 'reg');
    print('当前内容===${accCtrl.value.text}');
    // mCountDownTimerUtil.startCountDown();
    var data = {
      'mobile': mobile,
      'code': Constant.SMS_LOGIN
    };
  }

  toLogin() async{
    var acc = accCtrl.value.text.trim();
    var pwd = pwdCtrl.value.text.trim();
    if(acc.isEmpty || pwd.isEmpty) {
      Util.showToast('账号密码不对');
      return;
    }
    var data;
    if(kDebugMode) {
      data = {
        'm_name': 'j1bx2o1f34zc@icznn.com',
        'm_pwd': '123456',
      };
    }else {
      data = {
        'm_name': acc,
        'm_pwd': pwd,
      };
    }

    bool result = await LoginService.accountLogin(data);
    if(result) {
      SpUtil.putBool(Constant.IS_LOGIN,true);
      RouteUtil.toMain();
    }
  }

  void toForgetPwd() {
    Get.toNamed(AppRoutes.FORGET_PWD);
  }

  void toRegister() {
    Get.toNamed(AppRoutes.REGISTER);
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: MyInsets(horizontal: 15.w,top: Get.mediaQuery.padding.top.h),
      child: ListView(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText('登录',color: C.f131a22,size: 18.sp,),
                MyGestureDetector(
                    onTap: () {
                      controller.toRegister();
                    },
                    child: MyText('去注册',color: C.f999,size: 16.sp,),
                )
              ],
            ),
          ),
          122.h.spaceH,
          MyImg.assetImg('login/ic_login_logo.png', 194.w, 88.h),
          140.h.spaceH,
          Container(
            margin: MyInsets(bottom: 12.h),
            child: Obx(() {
              return Row( // curLoginType
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyGestureDetector(
                      onTap: () {
                        controller.curLoginType.value = controller.TYPE_CODE;
                      },
                      child: MyText('验证码',color: controller.curLoginType.value == controller.TYPE_CODE ? C.f131a22 : C.f999,size: 18.sp,)
                  ),
                  MyGestureDetector(
                      onTap: () {
                        controller.curLoginType.value = controller.TYPE_PWD;
                      },
                      child: MyText('密码',color: controller.curLoginType.value == controller.TYPE_PWD ? C.f131a22 : C.f999,size: 16.sp,)
                  ),
                ],
              );
            }),
          ),

          Obx(() {
            if(controller.curLoginType.value == controller.TYPE_CODE) {
              return MyCard(
                  child: Column(
                    children: [
                      _phoneLoginItem('请输入您的邮箱或手机号码',controller.accCtrl.value,),
                      24.h.spaceH,
                      _phoneLoginItem('请输入验证码',controller.pwdCtrl.value,showVerify: true),
                    ],
                  )
              );
            }
            return MyCard(
                child: Column(
                  children: [
                    _phoneLoginItem('请输入您的邮箱或手机号码',controller.accCtrl.value,),
                    24.h.spaceH,
                    _phoneLoginItem('请输入密码',controller.pwdCtrl.value,showPwd: true),
                  ],
                )
            );
          }),

          Obx(() {
            return Row(
              children: [
                Checkbox(value: controller.checkBox.value, onChanged: (v) {
                  controller.checkBox.value = v!;
                },activeColor: C.mainColor,),
                MyText('记住账号',color: C.f333),
                Spacer(),
                if(controller.curLoginType.value == controller.TYPE_PWD)
                MyButton(
                  color: C.whiteBg,
                  onTap: () {
                    controller.toForgetPwd();
                  },
                  child: MyText('忘记密码？'),
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
              controller.toLogin();
            },
            child: MyText('登录',color: C.f333,size: 16.sp,),
          )),
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
                    if(controller.accCtrl.value.text.isEmpty) {
                      Util.showToast('手机号不能为空');
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
