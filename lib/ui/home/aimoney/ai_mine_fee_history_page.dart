import 'package:flutter_rich_ex/bean/ai_mine_detail_bean.dart';
import 'package:flutter_rich_ex/service/ai/ai_mine_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AiMineFeeHistoryController extends BaseController {

  late String type;
  RxList<DetailListBean> beanList = <DetailListBean>[].obs;
  int pageIndex = 1;
  final RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  RxBool hasNoData = false.obs;

  @override
  void onReady() {
    super.onReady();
    type = Get.arguments['type'];
    getData();
  }

  getData() async{
    var query = {
      'page_no': pageIndex,
      'period': '',
    };

    if(pageIndex == 1) {
      beanList.clear();
      refreshController.resetNoData();
    }

    var res = await AiMineService.getTypeList(type, query);
    beanList.addAll(res);
    hasNoData.value = res.isEmpty;
  }

}
class AiMineFeeHistoryPage extends StatelessWidget with RefreshHost{

  AiMineFeeHistoryPage({Key? key}) : super(key: key);

  late AiMineFeeHistoryController controller ;

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
    controller = Get.put(AiMineFeeHistoryController());
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar('收益明细'.tr),
      body: _body(),
    );
  }

  _body1() {
    return Obx(() => _list());
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
              child: Obx(() {
                if(controller.beanList.isEmpty) {
                  return EmptyView();
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
                              MyText(controller.type,color: C.f131a22,),
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
          )
        ],
      ),
    );
  }


  _list() {
    return ListView.builder(itemBuilder: (ctx,index) {
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
                  MyText(controller.type,color: C.f131a22,),
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
