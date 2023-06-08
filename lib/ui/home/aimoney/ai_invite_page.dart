import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';

class AiInviteController extends BaseController {

  RxString curTab = '邀请记录'.obs;

  @override
  void onReady() {
    super.onReady();
  }

}
class AiInvitePage extends StatelessWidget {

  AiInvitePage({Key? key}) : super(key: key);

  late AiInviteController controller ;
  @override
  Widget build(BuildContext context) {
    controller = AiInviteController();
    return Scaffold(
      backgroundColor: C.white,
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: ListView(
        padding: MyInsets(horizontal: 14.w,top: 20.h),
        children: [
          _bannerInfo(),
          _person(),
          _flagTitle(),
          _list(),
        ],
      ),
    );
  }

  _bannerInfo() {
    return MyCard(
      height: 120.h,
      padding: MyInsets(all: 0.w),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Stack(
              children: [
                MyImg.assetImg('home/ic_banner.png', double.infinity, 130.h,fit: BoxFit.fill,),
                Padding(
                  padding: MyInsets(left: 27.w,vertical: 14.h),
                  child: MyText('暂定的banner',size: 22.sp,bold: true,color: C.white,lineHeight: 1.8,),
                )
              ],
            ),
            onTap: () {
              // controller.toBannerDetail(bean);
            },
          );
        },
        autoplay: 2 > 1,
        autoplayDelay: 3000,
        itemCount: 2,
        pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
                size: 8.0,
                activeSize: 8.0,
                activeColor: C.mainColor
            ),
            margin: MyInsets(bottom: 5.h)
        ),
        fade: 1.0,
      ),
    );
  }

  _person() {
    return Container(
      decoration: BoxDecoration(
        color: C.fefefef,
        borderRadius: BorderRadius.circular(25)
      ),
      margin: MyInsets(top: 11.h),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: C.mainColor,width: 2)
                  )
                ),
                padding: MyInsets(bottom: 4.h),
                child: MyText('邀请记录',color: C.black,size: 14.sp,bold: true,),
              ),
              MyGestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.AI_INVITE_HISTORY);
                },
                child: MyText('查看更多',color: C.black,size: 14.sp,),
              )
            ],
          ),
          12.h.spaceH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item('被邀请人',bgColor: C.ff0f0f0,color: C.f999,),
              _item('等级',bgColor: C.ff0f0f0,color: C.f999,),
              _item('注册时间',bgColor: C.ff0f0f0,color: C.f999,),
            ],
          )
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
