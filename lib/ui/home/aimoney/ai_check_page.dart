import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiCheckController extends BaseController {

  RxBool checkBox = false.obs;

  @override
  void onReady() {
    super.onReady();
  }
}

class AiCheckPage extends StatelessWidget {
  AiCheckPage({Key? key}) : super(key: key);
  late AiCheckController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiCheckController());

    return Scaffold(
      appBar: MyAppBar('AIC账单'),
      backgroundColor: C.white,
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: [
        _filter(),
        _list()
      ],
    );
  }

  _filter() {
    return Container(
      padding: MyInsets(horizontal: 14.w,bottom: 24.h),
      child: Row(
        children: [
          MyButton(
            width: 120.w,
            height: 30.h,
            margin: MyInsets(right: 30.w),
            padding: MyInsets(left: 10.w),
            round: 17.0,
            onTap: () {

            },
            color: C.fefefef,
            child: Row(
              children: [
                MyText('全部月份',),
                Icon(Icons.keyboard_arrow_down_rounded,size: 20.w,)
              ],
            )
          ),
          MyButton(
            width: 120.w,
            height: 30.h,
            round: 17.0,
            padding: MyInsets(left: 10.w),
            onTap: () {

            },
            color: C.fefefef,
            child: Row(
              children: [
                MyText('收入/支出',),
                Icon(Icons.keyboard_arrow_down_rounded,size: 20.w,)
              ],
            )
          )
        ],
      ),
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

