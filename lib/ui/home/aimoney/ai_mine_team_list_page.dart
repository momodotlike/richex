import 'package:flutter_rich_ex/bean/ai_mine_detail_bean.dart';
import 'package:flutter_rich_ex/service/ai/ai_mine_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AiMineTeamListController extends BaseController {

  RxList<DetailListBean> beanList = <DetailListBean>[].obs;
  RxList<String> navList = <String>[].obs;
  RxString curNavStr = '推荐收益'.tr.obs;

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
    navList.add('推荐收益'.tr);
    navList.add('分红收益'.tr);
    navList.add('租赁收益'.tr);
    navList.add('节点收益'.tr);
    navList.add('分享收益'.tr);
    navList.add('团队收益'.tr);
    await loadData();
  }

  loadData() async{
    var query = {
      'page_no': pageIndex,
      'period': '',
    };
    // tuijian  推荐收益
    // weight  分红收益
    // zulin  租赁收益
    // jiedian  节点收益
    // share  分享收益
    // team  团队收益

    if(pageIndex == 1) {
      beanList.clear();
      refreshController.resetNoData();
    }

    var res = await AiMineService.getTypeList(curNavStr.value, query);
    beanList.addAll(res);
    hasNoData.value = res.isEmpty;
  }

}
class AiMineTeamListPage extends StatelessWidget with RefreshHost{

  AiMineTeamListPage({Key? key}) : super(key: key);

  late AiMineTeamListController controller ;

  @override
  void onLoading() async {
    super.onLoading();
    controller.pageIndex  ++ ;
    await controller.loadData();
    controller.refreshController.loadComplete();
    if (controller.hasNoData.isTrue) {
      controller.refreshController.loadNoData();
    }
  }

  @override
  void onRefresh() async {
    super.onRefresh();
    controller.pageIndex = 1;
    await controller.loadData();
    controller.refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiMineTeamListController());
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar('我的收益明细'.tr),
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
            child: Obx(() => _navHead()),
          ),
          SliverToBoxAdapter(
              child: Obx(() {
                if(controller.beanList.isEmpty) {
                  return EmptyView(marginTop: 200.h,);
                }
                return  ListView.builder(itemBuilder: (ctx,index) {
                  DetailListBean bean = controller.beanList[index];
                  return Container(
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(width: 0.5,color: C.divider)
                          )
                      ),
                      padding: MyInsets(vertical: 10.h,horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(controller.curNavStr.value,color: C.f131a22,),
                              5.h.spaceH,
                              MyText(bean.statTime??'',color: C.f5f5f5f,size: 11.sp,),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              MyText('+${bean.bonus??''}',color: C.f131a22,),
                              5.h.spaceH,
                              MyText(bean.isSend??'',color: C.f5f5f5f,size: 11.sp,),
                            ],
                          ),
                        ],
                      )
                  );
                },itemCount: controller.beanList.length,
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
        Obx(() => _navHead()),
        Obx(() => _list()),
      ],
    );
  }

  _navHead() {
    return Container(
      height: 30.h,
      padding: MyInsets(horizontal: 15.w),
      child: ListView.builder(itemBuilder: (ctx,index) {
        String navStr = controller.navList[index];
        return Obx(() {
          return GestureDetector(
            onTap: () async{
              controller.curNavStr.value = navStr;
              controller.pageIndex = 1;
              await controller.getData();
            },
            child: Container(
                margin: MyInsets(right: 15.w),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1,color: controller.curNavStr.value == navStr ? C.mainColor : C.white)
                    )
                ),
                child: MyText(navStr,color: controller.curNavStr.value == navStr ? C.f131a22 : C.f959595,bold: controller.curNavStr.value == navStr,)
            ),
          );
        });
      },itemCount: controller.navList.length,
        // shrinkWrap: true,
        padding: MyInsets(all: 0.w),
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  _list() {
    if(controller.beanList.isEmpty) {
      return EmptyView(marginTop: 200.h,);
    }
    return  ListView.builder(itemBuilder: (ctx,index) {
      DetailListBean bean = controller.beanList[index];
      return Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(width: 0.5,color: C.divider)
              )
          ),
          padding: MyInsets(vertical: 10.h,horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(controller.curNavStr.value,color: C.f131a22,),
                  5.h.spaceH,
                  MyText(bean.statTime??'',color: C.f5f5f5f,size: 11.sp,),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  MyText('+${bean.bonus??''}',color: C.f131a22,),
                  5.h.spaceH,
                  MyText(bean.isSend??'',color: C.f5f5f5f,size: 11.sp,),
                ],
              ),
            ],
          )
      );
    },itemCount: controller.beanList.length,
      shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
      padding: MyInsets(all: 0.w),
    );
  }


}
