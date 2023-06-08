import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiAssetController extends BaseController {

  RxBool showMoney = true.obs;
  String starMoney = '***';

  @override
  void onReady() {
    super.onReady();
  }
}

class AiAssetPage extends StatelessWidget {
  AiAssetPage({Key? key}) : super(key: key);
  late AiAssetController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiAssetController());

    return Scaffold(
      appBar: MyAppBar('AIT资产'),
      backgroundColor: C.white,
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: [
        _headInfo(),
        _list()
      ],
    );
  }

  _headInfo() {
    return Container(
      padding: MyInsets(horizontal: 14.w,bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardInfo(),
          Container(
            margin: MyInsets(top: 16.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: C.mainColor,
                  width: 3
                )
              )
            ),
            child: MyText('账单明细',size: 16.sp,color: C.f131a22,bold: true,),
          )
        ],
      ),
    );
  }

  _cardInfo() {
    return MyCard(
      height: 228.h,
      padding: MyInsets(all: 0.w),
      child: Stack(
        children: [
          MyImg.assetImg('home/ai/bg_mine_top.png', double.infinity, 228.h,fit: BoxFit.fill,),
          Obx(() {
            bool show = controller.showMoney.isTrue;
            return Padding(
              padding: MyInsets(horizontal: 18.w,vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MyText('AIT钱包余额',color: C.white,size: 16.sp,),
                      8.w.spaceW,
                      MyGestureDetector(
                        onTap: () => controller.showMoney.value = !controller.showMoney.value,
                        child: MyImg.assetImg('login/${show ? 'ic_eye_open': 'ic_eye_close'}.png', 24.w, 24.h,color: C.white),
                      ),
                      Spacer(),
                      MyText('提示：1AIT=1USDT',color: C.white,size: 10.sp,),
                    ],
                  ),
                  10.h.spaceH,
                  MyText(show ? '3421.2431' : controller.starMoney,size: 36.sp,bold: true,color: C.white,),
                  16.h.spaceH,
                  Row(
                    children: [
                      _bannerItem('总收益(AIT)',show ? '100.0000' : controller.starMoney),
                      _bannerItem('昨日收益（AIT）',show ? '100.0000' : controller.starMoney),
                    ],
                  ),
                  10.h.spaceH,
                  Row(
                    children: [
                      _bannerItem('剩余总量(AIT)',show ? '100,070.0000' : controller.starMoney),
                      _bannerItem('销毁数量（AIT）',show ? '100.0000' : controller.starMoney),
                    ],
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }

  _bannerItem(String t,String b) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(t,color: C.white,size: 16.sp,),
            4.h.spaceH,
            MyText(b,color: C.white,size: 20.sp,bold: true,),
          ],
        )
    );
  }

  _list() {
    return Expanded(
        child: ListView.builder(itemBuilder: (ctx,index) {
          return Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: C.divider,width: 0.5)
              )
            ),
            padding: MyInsets(vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText('币币交易',color: C.f131a22,),
                    5.h.spaceH,
                    MyText('2023/05/28 13:21:21',color: C.f5f5f5f,size: 11.sp,),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyText('-21.12',color: C.f131a22,),
                    5.h.spaceH,
                    MyText('已确认',color: C.f5f5f5f,size: 11.sp,),
                  ],
                ),
              ],
            ),
          );
        },itemCount: 20,padding: MyInsets(horizontal: 14.w),)
    );
  }
}

