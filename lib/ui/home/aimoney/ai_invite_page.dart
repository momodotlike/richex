import 'package:flutter_rich_ex/bean/invite_bean.dart';
import 'package:flutter_rich_ex/event/event.dart';
import 'package:flutter_rich_ex/service/ai/invest_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AiInviteController extends BaseController {

  RxString curTab = '邀请记录'.tr.obs;
  List<StreamSubscription> subscriptions = [];
  RxString inviteCount = '0'.obs;
  RxList<InviteBean> beanList = <InviteBean>[].obs;
  int pageIndex = 1;

  final RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  RxBool hasNoData = false.obs;

  @override
  void onClose() {
    super.onClose();
    subscriptions.forEach((element) {
      element?.cancel();
    });
  }

  @override
  void onReady() {
    super.onReady();
    final s1 = eventBus.on<RefreshAiTabEvent>().listen((event) async {
      if(event.name == '邀请'.tr) {
        pageIndex = 1;
        getData();
      }
    });
    subscriptions.add(s1);
    getData();
  }

  getData() async{
    var query = {
      'page_no': pageIndex,
    };
    var res = await InvestService.getInviteList(query);
    if(res !=null && res['code'] == Constant.code200) {
      List<InviteBean> list = [];
      inviteCount.value = res['data_count'].toString();
      if(res['data'] !=null) {
        res['data']?.forEach((element) {
          InviteBean bean = InviteBean.fromJson(element);
          list.add(bean);
        });
      }

      if(pageIndex == 1) {
        beanList.clear();
        refreshController.resetNoData();
      }
      beanList.addAll(list);
      hasNoData.value = list.isEmpty;
    }
  }

}
class AiInvitePage extends StatelessWidget with RefreshHost{

  AiInvitePage({Key? key}) : super(key: key);

  late AiInviteController controller ;

  @override
  void onLoading() async {
    super.onLoading();
    controller.pageIndex  ++ ;
    await controller.getData();
    controller.refreshController.loadComplete();
    if (controller.hasNoData.isTrue) {
      controller.refreshController.loadNoData();
    }
  }

  @override
  void onRefresh() async {
    super.onRefresh();
    controller.pageIndex = 1;
    await controller.getData();
    controller.refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiInviteController());
    return Scaffold(
      backgroundColor: C.white,
      body: Container(
        padding: MyInsets(horizontal: 14.w,top: 20.h),
        child: _body(),
      ),
    );
  }

  _body() {
    return SmartRefresh(
      host: this,
      enablePullDown: true,
      enablePullUp: true,
      controller: controller.refreshController,
      scrollController: controller.scrollController,
      child: CustomScrollView(
        controller: controller.scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: _bannerInfo(),
          ),
          SliverToBoxAdapter(
            child: _person(),
          ),
          SliverToBoxAdapter(
            child: _flagTitle(),
          ),
          SliverToBoxAdapter(
              child: Obx(() {
                if(controller.beanList.isEmpty) {
                  return EmptyView();
                }
                return ListView.builder(itemBuilder: (ctx,index) {
                  InviteBean bean = controller.beanList[index];
                  return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 0.5,color: C.divider)
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _item(bean.phone??'',color: C.f999,),
                          _item(bean.levelName??'',color: C.f999,),
                          _item(bean.createtime?.split(' ').first??'',color: C.f999,),
                        ],
                      )
                  );
                },itemCount: controller.beanList.length,
                  shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                  padding: MyInsets(all: 0.w),
                );
              })
          )
        ],
      ),
    );
  }

  _body1() {
    return ListView(
      padding: MyInsets(horizontal: 14.w,top: 20.h),
      children: [
        _bannerInfo(),
        _person(),
        _flagTitle(),
        Obx(() => _list()),
      ],
    );
  }

  _bannerInfo() {
    return MyCard(
      height: 120.h,
      padding: MyInsets(all: 0.w),
      child: Stack(
        children: [
          MyImg.assetImg('home/ai/bg_banner_2.jpg', double.infinity, 130.h,fit: BoxFit.fill,),
          Container(
            padding: MyInsets(left: 27.w,top: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText('邀请好友'.tr,color: C.f247f30,size: 18.sp,bold: true,),
                8.h.spaceH,
                MyText('一起轻松交易数字货币'.tr,color: C.f552e15,size: 16.sp,bold: true,),
              ],
            ),
          )
        ],
      ),
      // child: Swiper(
      //   itemBuilder: (BuildContext context, int index) {
      //     return GestureDetector(
      //       child: Stack(
      //         children: [
      //           MyImg.assetImg('home/ai/bg_banner_2.jpg', double.infinity, 130.h,fit: BoxFit.fill,),
      //           Container(
      //             padding: MyInsets(left: 27.w,top: 24.h),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 MyText('邀请好友',color: C.f247f30,size: 18.sp,bold: true,),
      //                 8.h.spaceH,
      //                 MyText('一起轻松交易数字货币',color: C.f552e15,size: 16.sp,bold: true,),
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //       onTap: () {
      //         // controller.toBannerDetail(bean);
      //       },
      //     );
      //   },
      //   autoplay: 2 > 1,
      //   autoplayDelay: 3000,
      //   itemCount: 2,
      //   pagination: SwiperPagination(
      //       builder: DotSwiperPaginationBuilder(
      //           size: 8.0,
      //           activeSize: 8.0,
      //           activeColor: C.mainColor
      //       ),
      //       margin: MyInsets(bottom: 5.h)
      //   ),
      //   fade: 1.0,
      // ),
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
          MyText('累计邀请好友'.tr,size: 15.sp,),
          10.w.spaceW,
          Obx(() => MyText('${controller.inviteCount.value}' + '名'.tr,bold: true,size: 18.sp,))
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
                child: MyText('邀请记录'.tr,color: C.black,size: 14.sp,bold: true,),
              ),
              MyGestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.AI_INVITE_HISTORY);
                },
                child: MyText('查看更多'.tr,color: C.black,size: 14.sp,),
              )
            ],
          ),
          12.h.spaceH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item('被邀请人'.tr,bgColor: C.ff0f0f0,color: C.f999,),
              _item('等级'.tr,bgColor: C.ff0f0f0,color: C.f999,),
              _item('注册时间'.tr,bgColor: C.ff0f0f0,color: C.f999,),
            ],
          )
        ],
      ),
    );
  }

  _list() {
    if(controller.beanList.isEmpty) {
      return EmptyView();
    }
    return ListView.builder(itemBuilder: (ctx,index) {
      InviteBean bean = controller.beanList[index];
      return Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5,color: C.divider)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item(bean.phone??'',color: C.f999,),
              _item(bean.levelName??'',color: C.f999,),
              _item(bean.createtime?.split(' ').first??'',color: C.f999,),
            ],
          )
      );
    },itemCount: controller.beanList.length,
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
