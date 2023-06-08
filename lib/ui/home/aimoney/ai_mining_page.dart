import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiMingController extends BaseController {

  RxBool checkBox = false.obs;

  @override
  void onReady() {
    super.onReady();
  }

  toMingSecret() {
    Get.toNamed(AppRoutes.AI_MING_SECRET);
  }
}

class AiMingPage extends StatelessWidget {
  AiMingPage({Key? key}) : super(key: key);
  late AiMingController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiMingController());

    return Scaffold(
      appBar: MyAppBar('AIC挖矿',actions: [
        MyButton(
          width: 60.w,
          height: 50.h,
          margin: MyInsets(right: 15.w),
          onTap: () {
            Get.toNamed(AppRoutes.AI_ASSET);
          },
          color: C.white,
          child: MyText('AIT资产',),
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
        _headInfo(),
        _lineInfo(),
        _actionInfo(),
      ],
    );
  }

  _headInfo() {
    return Container(
      child: Row(
        children: [
          _infoCard('账户余额 AIC','1856.97','交易','账单',showBtn: true),
          7.w.spaceW,
          _infoCard('销毁数量','3856.97','产出数量','2856.12'),
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
                            Get.toNamed(AppRoutes.AI_CHECK);
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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.h.spaceH,
          MyText('AIC价格涨幅',color: C.black,size: 16.sp,bold: true,),
          Container(
            margin: MyInsets(vertical: 8.h),
            height: 136.h,
            width: 326.w,
            color: C.mainColor,
          ),
          Row(
            children: [
              MyText('价格',color: C.black,size: 16.sp,bold: true,),
              MyText('24h涨幅比利',color: C.black,size: 16.sp,),
            ],
          ),
          30.h.spaceH,
        ],
      ),
    );
  }
  _actionInfo() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText('销毁挖矿',color: C.f5f5f5f,size: 18.sp,bold: true,),
              GestureDetector(
                onTap: () => controller.toMingSecret(),
                child: MyText('挖矿秘籍',color: C.f5f5f5f,size: 15.sp,),
              ),
            ],
          ),
          18.h.spaceH,
          MyTextField(
            hintText: '输入销毁数量',
            autofocus: false,
            contentPadding: MyInsets(vertical: 10.h,left: 12.w),
            suffixIcon: Container(
              width: 40.w,
              alignment: Alignment.centerRight,
              padding: MyInsets(right: 12.w),
              child: MyText('全部',color: C.mainColor,bold: true,),
            ),
          ),
          18.h.spaceH,
          MyText('账户余额:9999.9878 AIT',size: 15.sp,),
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
                MyText('勾选并同意',color: C.f333),
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
      textColor: C.f333,
      height: 44.h,
      width: Get.width - 24.w,
      text: '确认',
      round: 22.0,
      color: controller.checkBox.isTrue ? C.mainColor : C.fe3e3e3,
      onTap: () {
      },
    );
  }
}

