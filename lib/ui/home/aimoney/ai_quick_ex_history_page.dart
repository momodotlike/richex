import 'package:flutter_rich_ex/bean/exchange_history_bean.dart';
import 'package:flutter_rich_ex/service/ai/ai_quick_ex_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AiQuickExHistoryController extends BaseController {

  RxList<ExchangeHistoryBean> historyList = <ExchangeHistoryBean>[].obs;

  int pageIndex = 1;
  final RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  RxBool hasNoData = false.obs;

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  loadData() async{
    var query = {
      'page_no' : pageIndex,
    };
    if(pageIndex == 1) {
      historyList.clear();
      refreshController.resetNoData();
    }

    var res = await AiQuickExService.getHistory(query);
    if(res !=null) {
      res.forEach((element) {
        ExchangeHistoryBean bean = ExchangeHistoryBean.fromJson(element);
        historyList.add(bean);
      });
      hasNoData.value = res.isEmpty;
    }
  }
}

class AiQuickExHistoryPage extends StatelessWidget with RefreshHost{
  AiQuickExHistoryPage({Key? key}) : super(key: key);
  late AiQuickExHistoryController controller;

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
    controller = Get.put(AiQuickExHistoryController());
    return Scaffold(
      appBar: MyAppBar('闪兑记录'.tr),
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
              child: Obx(() {
                if(controller.historyList.isEmpty) {
                  return EmptyView();
                }
                return ListView.builder(itemBuilder: (ctx,index) {
                  return _item(index);
                },itemCount: controller.historyList.length,
                  padding: MyInsets(horizontal: 14.w,bottom: 12.h),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
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
    if(controller.historyList.isEmpty) {
      return EmptyView();
    }
    return ListView.builder(itemBuilder: (ctx,index) {
      return _item(index);
    },itemCount: controller.historyList.length,
      padding: MyInsets(horizontal: 14.w,bottom: 12.h),
    );
  }

  _item(int index) {
    ExchangeHistoryBean bean = controller.historyList[index];
    return MyCard(
      bg: C.ff5f5f5f,
      margin: MyInsets(bottom: 12.h),
      padding: MyInsets(all: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _detailItem('支付/数量'.tr,'${bean.sourceCurrency??''}/${bean.sourceCurrencyAmount??'0'}'),
              _detailItem('得到/数量'.tr,'${bean.shanduiCurrency??''}/${bean.shanduiCurrencyAmount??'0'}'),
            ],
          ),
          11.h.spaceH,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _detailItem('手续费'.tr,bean.shanduiFee??''),
              _detailItem('时间'.tr,bean.shanduiTime??''),
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
              MyText(bot,color: C.f131a22,size: 16.sp,),
            ],
          ),
        )
    );
  }
}
