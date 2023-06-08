import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_rich_ex/util/pull_to_refresh.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends BaseController {
  RxString curTab = '热门现货'.obs;
  RxBool isLogin = false.obs;
  RxString accountName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadSp();
  }

  loadSp() {
    isLogin.value = Config.isLogin();
    accountName.value = SpUtil.getString(Constant.accountName,defValue: '');
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  loadData() async{
  }

  void toLogin() {
    Get.toNamed(AppRoutes.LOGIN);
  }

}

class HomePage extends StatelessWidget with RefreshHost{
  HomePage({Key? key}) : super(key: key);
  final RefreshController refreshController = RefreshController();
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.white,
      body: _body(),
    );
  }

  _body() {
    return SmartRefresh(
      host: this,
      enablePullDown: false,
      enablePullUp: false,
      controller: refreshController,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _topBgInfo(),
          ),
          SliverToBoxAdapter(
            child: _headNav(),
          ),
          SliverToBoxAdapter(
            child: _highList(),
          ),
        ],
      ),
    );
  }

  _bannerInfo() {
    return MyCard(
      height: 130.h,
      // margin: MyInsets(horizontal: 15.w,bottom: 10.h),
      padding: MyInsets(all: 0.w),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            // child: MyImg.netImg(banner.img??'', double.infinity, 130.h,fit: BoxFit.cover,radius: 10.0),
            child: Stack(
              children: [
                MyImg.assetImg('home/ic_banner.png', double.infinity, 130.h,fit: BoxFit.fill,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText('周期 15 天',bold: true,size: 20.sp,color: C.f333,),
                        14.h.spaceH,
                        MyText('初级挖矿',color: C.f333,),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText('0.1 %',bold: true,size: 20.sp,color: C.f333,),
                        14.h.spaceH,
                        MyText('日收益率',color: C.f333,),
                      ],
                    ),
                  ],
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

  _topBgInfo() {
    return Container(
      height: 300.h + Get.mediaQuery.padding.top.h + 130.h, // 130 为banner高度
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/home/ic_float_bg.png'),fit: BoxFit.cover)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: MyInsets(horizontal: 15.w),
            child: Column(
              children: [
                Container(
                  height: 66.h,
                  child: Obx(() => _headInfo()),
                ),
                20.h.spaceH,
                Container(
                  height: 30.h,
                  padding: MyInsets(horizontal: 6.w),
                  decoration: BoxDecoration(
                      color: C.ff9f9f9.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(4)
                  ),
                  child: Row(
                    children: [
                      MyImg.icRing,
                      6.w.spaceW,
                      MyText('PLUTUSEX与帕劳政府合作公告',color: C.white,size: 12.sp,),
                      Spacer(),
                      MyImg.icMenu,
                    ],
                  ),
                ),
                26.h.spaceH,
                Container(
                  height: 130.h,
                  child: Stack(
                    children: [
                      MyImg.assetImg('home/ic_float_line.png', Get.width, 130.h),
                      Padding(
                        padding: MyInsets(horizontal: 15.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText('TRX/USDT',color: C.white,size: 20.sp,),
                                MyText('0.07384',color: C.white,size: 34.sp,bold: true,),
                                MyText('+0.49%',color: C.white,size: 18.sp,),
                              ],
                            ),
                            MyImg.icFloatUp,
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                20.h.spaceH,
              ],
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: C.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30)
              )
            ),
            padding: MyInsets(all: 15.w),
            child: _bannerInfo(),
          ),
        ],
      ),
    );
  }

  _headInfo() {
    return Container(
      height: 44.h,
      color: C.transparent,
      alignment: Alignment.bottomLeft,
      margin: MyInsets(top: Get.mediaQuery.padding.top.h),
      child: Row(
        children: [
          MyImg.icUserHead,
          8.w.spaceW,
          MyGestureDetector(
              onTap: () {
                // if(controller.isLogin.isTrue) return;
                controller.toLogin();
              },
              child: MyText(controller.isLogin.isTrue ? controller.accountName.value??'' : '登录/注册',size: 16.sp,color: C.white,)
          ),
          Spacer(),
          MyImg.icScan,
          10.w.spaceW,
          MyImg.icChatW,
          10.w.spaceW,
          MyImg.icMsg,
        ],
      ),
    );
  }

  _headNav() {
    return Container(
      color: C.white,
      margin: MyInsets(horizontal: 15.w),
      padding: MyInsets(all: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...[
            {'path': AppRoutes.AI_MONEY,'ic': 'home/ic_recharge.png','txt': '充币'},
            {'path': AppRoutes.AI_MONEY,'ic': 'home/ic_ai_money.png','txt': 'AI理财'},
            {'path': AppRoutes.INVITE_FRIEND,'ic': 'home/ic_home_invite.png','txt': '邀请好友'},
            {'path': AppRoutes.AI_MONEY,'ic': 'home/ic_help.png','txt': '帮助中心'},
          ].map((e) => MyGestureDetector(
              onTap: () => Get.toNamed(e['path']??''),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyImg.assetImg(e['ic']??'', 50.w, 50.w),
                    10.h.spaceH,
                    MyText('${e['txt']}',color: C.f131a22,size: 14.sp,)
                  ],
                ),
              )
          )).toList(),
        ],
      ),
    );
  }


  _highList() {
    return MyCard(
        padding: MyInsets(horizontal: 15.w,),
        child: Column(
          children: [
            Container(
              height: 54.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...[
                    {'txt': '热门现货',},
                    {'txt': '热门合约',},
                    {'txt': '涨幅榜',},
                    {'txt': '新币榜',},
                  ].map((e) {
                    return MyGestureDetector(
                        onTap: () {
                          controller.curTab.value = e['txt']??'';
                        },
                        child: Obx(() => Container(
                          padding: MyInsets(horizontal: 6.w,vertical: 4.h),
                          decoration: BoxDecoration(
                            color: controller.curTab.value == e['txt'] ? C.fdfffd6 : C.white,
                            borderRadius: BorderRadius.circular(16)
                          ),
                          margin: MyInsets(right: 18.w),
                          child: MyText(e['txt']??'',color: C.black,size: 14.sp,),
                        ))
                    );
                  }).toList()
                ],
              ),
            ),
            ListView.builder(itemBuilder: (ctx,index) {
              return Container(
                margin: MyInsets(bottom: 12.h),
                padding: MyInsets(all: 12.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText('BTCUSDT 永续',lineHeight: 1.6,color: C.f333,),
                        6.h.spaceH,
                        MyText('24h 额：¥143287.83',color: C.f999,size: 12.sp,),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText('28763.9',lineHeight: 1.6,color: C.f333,),
                        6.h.spaceH,
                        MyText('+0.75%',color: C.fa4ff74,size: 12.sp,),
                      ],
                    ),
                  ],
                ),
              );
            },itemCount: 4,
              shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
              padding: MyInsets(all: 0.w),
            )
          ],
        )
    );
  }
}
