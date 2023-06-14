import 'package:flutter/services.dart';
import 'package:flutter_rich_ex/router/routes.dart';
import 'package:flutter_rich_ex/service/login_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyDialogController extends BaseController {

  TextEditingController ctrl = TextEditingController();

  @override
  void onReady() {
    super.onReady();
  }

  toLogin() async{
    var code = ctrl.text.trim();
    var accountName = SpUtil.getString(Constant.accountName,defValue: '');
    var loginRes = await LoginService.login(code: code, account: accountName);
    if(loginRes) {
      RouteUtil.toMain();
    }
  }
}

class VerifyDialog extends StatelessWidget {
  final String account;
  VerifyDialog({Key? key, required this.account}) : super(key: key);
  late VerifyDialogController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(VerifyDialogController());
    return Center(
      child: Container(
        margin: const MyInsets(horizontal: 30),
        height: 300.h,
        width: 300.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: C.white,
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50.h,
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close,size: 25.w,),
                  ),
                ),
                Container(
                  height: 40.h,
                  alignment: Alignment.topCenter,
                  child: MyText('验证码验证',size: 28.sp,bold: true,),
                ),
                Container(
                  margin: MyInsets(top: 9.h,bottom: 16.h,horizontal: 15.w),
                  child: MyText('本次操作需要短信验证,验证码会发送至您的注册账号$account',lineHeight: 1.6,),
                ),
                Container(
                  height: 35.h,
                  width: 270.w,
                  margin: MyInsets(bottom: 24.h),
                  child: PinCodeTextField(
                    appContext: Get.context!,
                    length: 6,
                    blinkWhenObscuring: false,
                    animationType: AnimationType.fade,
                    backgroundColor: C.white,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 35.h,
                      fieldWidth: 35.w,
                      activeColor: C.mainColor,
                      selectedColor: C.mainColor,
                      inactiveColor: C.f333,
                      borderWidth: 1,
                      activeFillColor: Colors.black12,
                      selectedFillColor: Colors.black12,
                    ),
                    cursorColor: C.mainColor,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: false,
                    textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.normal),
                    controller: controller.ctrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onCompleted: (v) {
                      Util.stopInput();
                    },
                    onChanged: (value) {

                    },
                    beforeTextPaste: (text) {
                      debugPrint("Allowing to paste $text");
                      return true;
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: MyButton(
                    color: C.mainColor,
                    alignment: Alignment.center,
                    width: 270.w,
                    height: 50.h,
                    round: 30.0,
                    onTap: () {
                      controller.toLogin();
                    },
                    child: MyText('确认'.tr,bold: true,size: 16.sp,align: TextAlign.center,color: C.white,),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
