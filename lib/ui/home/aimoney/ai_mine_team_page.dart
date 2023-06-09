import 'package:flutter_rich_ex/bean/aimine_team_bean.dart';
import 'package:flutter_rich_ex/bean/aimine_team_list_bean.dart';
import 'package:flutter_rich_ex/service/ai/team_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AiMineTeamController extends BaseController {

  Rx<AiMineTeamBean> detailBean = AiMineTeamBean().obs;
  RxList<AiMineTeamListBean> teamList = <AiMineTeamListBean>[].obs;

  int pageIndex = 1;
  final RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  RxBool hasNoData = false.obs;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() async{
    var res = await TeamService.getDetail();
    if(res !=null) {
      detailBean.value = res;
    }

    var query = {
      'page_no': pageIndex,
    };

    var tempList = await TeamService.getTeamList(query);
    teamList.addAll(tempList);
    hasNoData.value = tempList.isEmpty;
  }

}
class AiMineTeamPage extends StatelessWidget with RefreshHost{

  AiMineTeamPage({Key? key}) : super(key: key);

  late AiMineTeamController controller ;

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
    controller = Get.put(AiMineTeamController());
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar('我的团队'.tr),
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
            child: Obx(() => _infoCard()),
          ),
          SliverToBoxAdapter(
            child:  _incomeCard(),
          ),
          SliverToBoxAdapter(
            child:  _flagTitle(),
          ),
          SliverToBoxAdapter(
              child: Obx(() {
                if(controller.teamList.isEmpty) {
                  return EmptyView(marginTop: 50.h,);
                }
                return ListView.builder(itemBuilder: (ctx,index) {
                  AiMineTeamListBean listBean = controller.teamList[index];
                  return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 0.5,color: C.divider)
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _item(listBean.phone??'',color: C.f999,),
                          _item(listBean.jiedianName??'',color: C.f999,),
                          _item(listBean.levelName??'',color: C.f999,),
                        ],
                      )
                  );
                },itemCount: controller.teamList.length,
                  shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                  padding: MyInsets(all: 0.w),
                );
              })
          ),
          SliverToBoxAdapter(
            child: 30.h.spaceH,
          ),
        ],
      ),
    );
  }

  _body1() {
    return ListView(
      padding: MyInsets(horizontal: 14.w,top: 20.h),
      children: [
        Obx(() => _infoCard()),
        _incomeCard(),
        _flagTitle(),
        Obx(() => _list()),
      ],
    );
  }

  _infoCard() {
    var detail = controller.detailBean.value;
    return MyCard(
      height: 213.h,
      padding: MyInsets(all: 0.w),
      child: Stack(
        children: [
          MyImg.assetImg('home/ai/bg_mine_team.png', double.infinity, 213.h,fit: BoxFit.fill,),
          Padding(
            padding: MyInsets(horizontal: 18.w,vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: MyImg.assetImg('home/ai/ic_ai_mine_team_${detail.levelName??'A0'}.png', 60.w, 48.h),
                      onTap: ()  {
                        Get.toNamed(AppRoutes.AI_SUBSCRIBE_APPLY_NODE);
                      },
                    ),
                    35.w.spaceW,
                    MyText('当前级别'.tr +':${detail.levelName??''}',color: C.white,size: 16.sp,),
                  ],
                ),
                5.h.spaceH,
                Row(
                  children: [
                    _bannerItem('团队人数'.tr,detail.tjUserQuantity??'--'),
                    _bannerItem('有效用户人数'.tr,detail.tjValidUserQuantity??'--'),
                    _bannerItem('节点用户人数'.tr,detail.tjJiedianUserQuantity??'--'),
                  ],
                ),
                MyDivider(height: 2,color: C.white,margin: MyInsets(top: 10.h,bottom: 20.h),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _bannerItem('个人持有金额'.tr,detail.myAmount??'--',second: true),
                    _bannerItem('团队业绩'.tr,detail.teamAmount??'--',second: true),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _incomeCard() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          18.h.spaceH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText('我的收益'.tr,color: C.f131a22,size: 16.sp,bold: true,),
              MyGestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.AI_MINE_TEAM_LIST);
                },
                child: MyText('查看明细'.tr,color: C.f5f5f5f,size: 16.sp,),
              )
            ],
          ),
          12.h.spaceH,
          Obx(() => _incomeDetailItem()),
        ],
      ),
    );
  }

  _incomeDetailItem() {
    var detail = controller.detailBean.value;
    return MyCard(
      bg: C.ff8fff4,
      margin: MyInsets(bottom: 0.h),
      padding: MyInsets(all: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _detailItem('节点收益'.tr,detail.jiedianBonus??'--'),
              _detailItem('团队收益'.tr,detail.teamBonus??'--'),
              _detailItem('分享收益'.tr,detail.shareBonus??'--'),
            ],
          ),
          11.h.spaceH,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _detailItem('推荐收益'.tr,detail.tuijianBonus??'--'),
              _detailItem('分红收益'.tr,detail.weightBonus??'--'),
              _detailItem('租赁收益'.tr,detail.zulinBonus??'--'),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MyText(bot,color: C.f131a22,size: 15.sp,lineHeight: 1.4,),
                  Padding(
                    padding: MyInsets(left: 5.w,bottom: 4.h),
                    child: MyText('USDT',color: C.black,size: 10.sp,),
                  )
                ],
              ),
            ],
          ),
        )
    );
  }

  _flagTitle() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          18.h.spaceH,
          MyText('团队明细'.tr,color: C.black,size: 16.sp,bold: true,),
          12.h.spaceH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item('用户名称'.tr,bgColor: C.ff0f0f0,color: C.f999,),
              _item('节点级别'.tr,bgColor: C.ff0f0f0,color: C.f999,),
              _item('级别'.tr,bgColor: C.ff0f0f0,color: C.f999,),
            ],
          )
        ],
      ),
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

  _bannerItem(String t,String b,{bool second = false}) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(t,color: C.white,size: second ? 16.sp : 14.sp,),
            4.h.spaceH,
            if(!second)
            MyText(b,color: C.white,size: 20.sp,bold: true,),
            if(second)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(b,color: C.white,size: 20.sp,bold: true,),
                Padding(
                  padding: MyInsets(top: 4.h,left: 3.w),
                  child: MyText('usdt',color: C.white,size: 10.sp,),
                ),
              ],
            )
          ],
        )
    );
  }

  _list() {
    if(controller.teamList.isEmpty) {
      return EmptyView(marginTop: 50.h,);
    }
    return ListView.builder(itemBuilder: (ctx,index) {
      AiMineTeamListBean listBean = controller.teamList[index];
      return Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5,color: C.divider)
              )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item(listBean.phone??'',color: C.f999,),
              _item(listBean.jiedianName??'',color: C.f999,),
              _item(listBean.levelName??'',color: C.f999,),
            ],
          )
      );
    },itemCount: controller.teamList.length,
      shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
      padding: MyInsets(all: 0.w),
    );
  }


}
