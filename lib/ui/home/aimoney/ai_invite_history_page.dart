import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';

class AiInviteHistoryController extends BaseController {

  RxString curTab = '邀请记录'.obs;

  @override
  void onReady() {
    super.onReady();
  }

}
class AiInviteHistoryPage extends StatelessWidget {

  AiInviteHistoryPage({Key? key}) : super(key: key);

  late AiInviteHistoryController controller ;
  @override
  Widget build(BuildContext context) {
    controller = AiInviteHistoryController();
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar('邀请记录'),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: ListView(
        padding: MyInsets(horizontal: 14.w,top: 20.h),
        children: [
          _person(),
          _flagTitle(),
          _list(),
        ],
      ),
    );
  }

  _person() {
    return Container(
      decoration: BoxDecoration(
        color: C.fefefef,
        borderRadius: BorderRadius.circular(25)
      ),
      padding: MyInsets(left: 16.w),
      height: 50.h,
      width: Get.width,
      child: Row(
        children: [
          MyText('累计邀请好友',size: 15.sp,),
          10.w.spaceW,
          MyText('1520名',bold: true,size: 18.sp,),
        ],
      ),
    );
  }
  _flagTitle() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          18.h.spaceH,
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: C.mainColor,width: 2)
                ),
            ),
            padding: MyInsets(bottom: 4.h),
            child: MyText('邀请记录',color: C.black,size: 14.sp,bold: true,),
          ),
          12.h.spaceH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item('被邀请人',bgColor: C.ff0f0f0,color: C.f999,),
              _item('等级',bgColor: C.ff0f0f0,color: C.f999,),
              _item('注册时间',bgColor: C.ff0f0f0,color: C.f999,),
            ],
          ),
        ],
      ),
    );
  }

  _list() {
    return  ListView.builder(itemBuilder: (ctx,index) {
      return Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5,color: C.divider)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item('123**871',color: C.f999,),
              _item('A7',color: C.f999,),
              _item('2023-05-29',color: C.f999,),
            ],
          )
      );
    },itemCount: 40,
      shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
      padding: MyInsets(all: 0.w),
    );
  }

  _item(String str,{Color? bgColor, Color? color}) {
    return Expanded(
        child: Container(
          color: bgColor ?? C.white,
          height: 33.h,
          alignment: Alignment.center,
          child: MyText(str,color: color ?? C.f999,),
        )
    );
  }
}
