import 'package:flutter_rich_ex/bean/ait_list_bean.dart';
import 'package:flutter_rich_ex/service/ai/ai_aic_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AiAssetController extends BaseController {

  RxBool showMoney = true.obs;
  String starMoney = '***';
  var aitDetail = {}.obs;
  RxList<AitListBean> aitList = <AitListBean>[].obs;

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
    var res = await AiAicService.getAitDetail();
    if(res !=null) {
      aitDetail.value = res;
    }
    getList();
  }

  getList() async{
    var query = {
      'page_no' : pageIndex,
    };
    if(pageIndex == 1) {
      aitList.clear();
      refreshController.resetNoData();
    }
    var res = await AiAicService.getAitList(query);
    if(res !=null) {
      res.forEach((element) {
        AitListBean bean = AitListBean.fromJson(element);
        aitList.add(bean);
      });
      hasNoData.value = res.isEmpty;
    }
  }

}

class AiAssetPage extends StatelessWidget with RefreshHost{
  AiAssetPage({Key? key}) : super(key: key);
  late AiAssetController controller;

  @override
  void onLoading() async {
    super.onLoading();
    controller.pageIndex  ++ ;
    await controller.getList();
    controller.refreshController.loadComplete();
    if (controller.hasNoData.isTrue) {
      controller.refreshController.loadNoData();
    }
  }

  @override
  void onRefresh() async {
    super.onRefresh();
    controller.pageIndex = 1;
    await controller.getList();
    controller.refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiAssetController());

    return Scaffold(
      appBar: MyAppBar('AIT资产'.tr),
      backgroundColor: C.white,
      body: _body(),
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
            child: _headInfo(),
          ),
          SliverToBoxAdapter(
              child: Obx(() {
                if(controller.aitList.isEmpty) {
                  return EmptyView();
                }
                return ListView.builder(itemBuilder: (ctx,index) {
                  AitListBean bean = controller.aitList[index];
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
                            MyText(bean.procTypeVal??'',color: C.f131a22,),
                            5.h.spaceH,
                            MyText(bean.createTime??'',color: C.f5f5f5f,size: 11.sp,),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            MyText(bean.num??'',color: C.f131a22,),
                            5.h.spaceH,
                            MyText('已确认'.tr,color: C.f5f5f5f,size: 11.sp,),
                          ],
                        ),
                      ],
                    ),
                  );
                },itemCount: controller.aitList.length,padding: MyInsets(horizontal: 14.w),
                shrinkWrap: true,physics: NeverScrollableScrollPhysics(),);
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
    return Column(
      children: [
        _headInfo(),
        Obx(() {
          if(controller.aitList.isEmpty) {
            return EmptyView();
          }
          return _list();
        })
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
            child: MyText('账单明细'.tr,size: 16.sp,color: C.f131a22,bold: true,),
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
                      MyText('AIT钱包余额'.tr,color: C.white,size: 16.sp,),
                      8.w.spaceW,
                      MyGestureDetector(
                        onTap: () => controller.showMoney.value = !controller.showMoney.value,
                        child: MyImg.assetImg('login/${show ? 'ic_eye_open': 'ic_eye_close'}.png', 24.w, 24.h,color: C.white),
                      ),
                      Spacer(),
                      MyText('提示：1AIT=1USDT'.tr,color: C.white,size: 10.sp,),
                    ],
                  ),
                  10.h.spaceH,
                  MyText(show ? '${controller.aitDetail.value['total_balance']??''}' : controller.starMoney,size: 36.sp,bold: true,color: C.white,),
                  16.h.spaceH,
                  Row(
                    children: [
                      _bannerItem('总收益(AIT)'.tr,show ? '${controller.aitDetail.value['total_bonus']??''}' : controller.starMoney),
                      _bannerItem('昨日收益（AIT）'.tr,show ? '${controller.aitDetail.value['zuotian_bonus']??''}' : controller.starMoney),
                    ],
                  ),
                  10.h.spaceH,
                  Row(
                    children: [
                      _bannerItem('剩余总量(AIT)'.tr,show ? '${controller.aitDetail.value['shengyu_num']??''}' : controller.starMoney),
                      _bannerItem('销毁数量（AIT）'.tr,show ? '${controller.aitDetail.value['xiaohui_amount']??''}' : controller.starMoney),
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
          AitListBean bean = controller.aitList[index];
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
                    MyText(bean.procTypeVal??'',color: C.f131a22,),
                    5.h.spaceH,
                    MyText(bean.createTime??'',color: C.f5f5f5f,size: 11.sp,),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyText(bean.num??'',color: C.f131a22,),
                    5.h.spaceH,
                    MyText('已确认'.tr,color: C.f5f5f5f,size: 11.sp,),
                  ],
                ),
              ],
            ),
          );
        },itemCount: controller.aitList.length,padding: MyInsets(horizontal: 14.w),)
    );
  }
}

