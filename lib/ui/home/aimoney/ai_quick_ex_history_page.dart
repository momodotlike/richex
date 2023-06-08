import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiQuickExHistoryController extends BaseController {

  @override
  void onReady() {
    super.onReady();
  }
}

class AiQuickExHistoryPage extends StatelessWidget {
  AiQuickExHistoryPage({Key? key}) : super(key: key);
  late AiQuickExHistoryController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiQuickExHistoryController());
    return Scaffold(
      appBar: MyAppBar('闪兑记录'),
      backgroundColor: C.white,
      body: _body(),
    );
  }

  _body() {
    return ListView.builder(itemBuilder: (ctx,index) {
      return _item(index);
    },itemCount: 20,padding: MyInsets(horizontal: 14.w,bottom: 12.h),);
  }

  _item(int index) {
    return MyCard(
      bg: C.ff5f5f5f,
      margin: MyInsets(bottom: 12.h),
      padding: MyInsets(all: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _detailItem('支付/数量','AIC/675.15'),
              _detailItem('得到/数量','USDT/673.17'),
            ],
          ),
          11.h.spaceH,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _detailItem('手续费','X.XX'),
              _detailItem('时间','2023/05/28 13:21:21'),
            ],
          ),
        ],
      ),
    );
  }

  _detailItem(String top,String bot) {
    return Expanded(
        child: Container(
          margin: MyInsets(left: 0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(top,color: C.f959595,size: 13.sp,),
              5.h.spaceH,
              MyText(bot,color: C.f131a22,size: 16.sp,),
            ],
          ),
        )
    );
  }
}
