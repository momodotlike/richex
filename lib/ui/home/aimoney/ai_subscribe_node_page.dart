import 'package:flutter_rich_ex/bean/node_detail_bean.dart';
import 'package:flutter_rich_ex/bean/subscribe_node_bean.dart';
import 'package:flutter_rich_ex/service/ai/subscribe_node_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AiSubscribeNodeController extends BaseController {

  RxList<SubscribeNodeBean> nodeList = <SubscribeNodeBean>[].obs;

  Rx<NodeDetailBean> detailBean = NodeDetailBean().obs;
  int pageIndex = 1;
  final RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  RxBool hasNoData = false.obs;

  @override
  void onReady() {
    super.onReady();
    getDetail();
    getData();
  }

  getDetail() async{
    var detail = await SubscribeNodeService.getNodeDetail();
    if(detail !=null) {
      detailBean.value = detail;
    }
  }

  getData() async{
    if(pageIndex == 1) {
      nodeList.clear();
      refreshController.resetNoData();
    }
    var query = {
      'page_no': pageIndex,
    };
    List<SubscribeNodeBean> res = await SubscribeNodeService.getBuyList(query);
    nodeList.addAll(res);
    hasNoData.value = res.isEmpty;
  }

}
class AiSubscribeNodePage extends StatelessWidget with RefreshHost{

  AiSubscribeNodePage({Key? key}) : super(key: key);

  late AiSubscribeNodeController controller ;

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
    controller = Get.put(AiSubscribeNodeController());
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar('节点'.tr),
      body: Container(
        padding: MyInsets(horizontal: 15.w),
        child: _body(),
        // child: Column(
        //   children: [
        //     Obx(() => _infoCard()),
        //     _flagTitle(),
        //     Expanded(child: _body(),)
        //   ],
        // ),
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
            child: _flagTitle(),
          ),
          SliverToBoxAdapter(
              child: Obx(() {
                if(controller.nodeList.isEmpty) {
                  return EmptyView();
                }
                return ListView.builder(itemBuilder: (ctx,index) {
                  SubscribeNodeBean bean = controller.nodeList[index];
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
                          _item(bean.jiedianName??'',color: C.f999,),
                          _item(bean.totalBonus??'',color: C.f999,),
                          _item(bean.dayQuntity??'',color: C.f999,),
                        ],
                      )
                  );
                },itemCount: controller.nodeList.length,
                  shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                  padding: MyInsets(bottom: 20.w),
                );
              })
          )
        ],
      ),
    );
  }

  _infoCard() {
    NodeDetailBean detail = controller.detailBean.value;
    return MyCard(
      height: 180.h,
      padding: MyInsets(all: 0.w),
      child: Stack(
        children: [
          MyImg.assetImg('home/ai/bg_mine_top.png', double.infinity, 170.h,fit: BoxFit.fill,),
          Padding(
            padding: MyInsets(horizontal: 18.w,vertical: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MyImg.assetImg('home/ai/ic_level_${detail.jiedianId??1}.png', 134.w, 98.h),
                    // GestureDetector(
                    //   child: MyImg.assetImg('home/ai/ic_level_${detail.jiedianId??1}.png', 134.w, 98.h),
                    //   onTap: ()  {
                    //     Get.toNamed(AppRoutes.AI_SUBSCRIBE_APPLY_NODE);
                    //   },
                    // ),
                    42.w.spaceW,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(detail.jiedianName??'',color: C.black,size: 15.sp,),
                        6.h.spaceH,
                        MyText( '运行天数'.tr + ':${detail.dayQuntity??''}' + '天'.tr,color: C.f5f5f5f,size: 15.sp,),
                      ],
                    )
                  ],
                ),
                5.h.spaceH,
                Row(
                  children: [
                    _bannerItem('昨日返佣（USDT）'.tr,detail.bonus??'' ),
                    Container(
                      height: 30.h,
                      width: 1.w,
                      color: C.white,
                      margin: MyInsets(horizontal: 13.w),
                    ),
                    _bannerItem('累计返佣（USDT）'.tr,detail.totalBonus??''),
                  ],
                )
              ],
            ),
          )
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
          MyText('节点详情'.tr,color: C.black,size: 16.sp,bold: true,),
          12.h.spaceH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item('节点名称'.tr,bgColor: C.ff0f0f0,color: C.f999,),
              _item('节点级别'.tr,bgColor: C.ff0f0f0,color: C.f999,),
              _item('节点收益'.tr,bgColor: C.ff0f0f0,color: C.f999,),
              _item('运行天数'.tr,bgColor: C.ff0f0f0,color: C.f999,),
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

  _bannerItem(String t,String b) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyText(t,color: C.f5f5f5f,size: 16.sp,),
            4.h.spaceH,
            MyText(b,color: C.f131a22,size: 18.sp,bold: true,),
          ],
        )
    );
  }

}
