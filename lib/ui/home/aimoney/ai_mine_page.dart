import 'package:flutter_rich_ex/bean/ai_mine_detail_bean.dart';
import 'package:flutter_rich_ex/bean/aimine_invest_his_bean.dart';
import 'package:flutter_rich_ex/event/event.dart';
import 'package:flutter_rich_ex/service/ai/ai_mine_service.dart';
import 'package:flutter_rich_ex/ui/home/ai_money_page.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AiMineController extends BaseController {

  RxString curTab = '收益明细'.tr.obs;
  RxBool showMoney = true.obs;
  String starMoney = '***';

  Rx<AiMineDetailBean> detailBean = AiMineDetailBean().obs;
  RxList<DetailListBean> beanList = <DetailListBean>[].obs;
  List<String> titleList = [];

  RxList<AiMineInvestHisBean> hisList = <AiMineInvestHisBean>[].obs;

  List<StreamSubscription> subscriptions = [];

  AiMoneyController aiMainLogic = Get.find();

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
    final s1 = eventBus.on<RefreshAiMineNavEvent>().listen((event) async {
      print('eee${event}');
      curTab.value = '投资记录'.tr;
      pageIndex == 1;
      getData();
    });
    final s2 = eventBus.on<RefreshAiTabEvent>().listen((event) async {
      if(event.name == '我的'.tr) {
        pageIndex == 1;
        getData();
      }
    });
    subscriptions.add(s1);
    subscriptions.add(s2);
    getData();
  }

  // tuijian  推荐收益
// weight  分红收益
// zulin  租赁收益
// jiedian  节点收益
// share  分享收益
// team  团队收益

  getData() async{
    var res = await AiMineService.getDetail();
    if(res !=null) {
      detailBean.value = res;
      var tempBean = detailBean.value;
      beanList.clear();
      // 推荐
      if(tempBean.tuijian !=null) {
        titleList.add('推荐收益'.tr);
        beanList.add(tempBean.tuijian!);
      }
      // 分红
      if(tempBean.weight !=null) {
        titleList.add('分红收益'.tr);
        beanList.add(tempBean.weight!);
      }
      // 租赁
      if(tempBean.zulin !=null) {
        titleList.add('租赁收益'.tr);
        beanList.add(tempBean.zulin!);
      }
      // 节点
      if(tempBean.jiedian !=null) {
        titleList.add('节点收益'.tr);
        beanList.add(tempBean.jiedian!);
      }
      // 分享
      if(tempBean.share !=null) {
        titleList.add('分享收益'.tr);
        beanList.add(tempBean.share!);
      }
      if(tempBean.team !=null) {
        // 团队
        titleList.add('团队收益'.tr);
        beanList.add(tempBean.team!);
      }
    }

    getHisList();
  }

  getHisList() async{
    // 投资记录
    var query = {
      'page_no': pageIndex,
    };
    if(pageIndex == 1) {
      hisList.clear();
      refreshController.resetNoData();
    }
    var history = await AiMineService.getHistoryList(query);
    hisList.addAll(history);
    hasNoData.value = history.isEmpty;
  }


  void toDetailList(String title) {
    Get.toNamed(AppRoutes.AI_MINE_FEE_LIST,arguments: {'type': title});
  }

}
class AiMinePage extends StatelessWidget with RefreshHost{

  AiMinePage({Key? key}) : super(key: key);

  late AiMineController controller ;

  @override
  void onLoading() async {
    super.onLoading();

    if(controller.curTab.value == '收益明细'.tr) {
      controller.refreshController.loadComplete();
      controller.refreshController.loadNoData();
    }else {
      controller.pageIndex  ++ ;
      await controller.getHisList();
      controller.refreshController.loadComplete();
      if (controller.hasNoData.isTrue) {
        controller.refreshController.loadNoData();
      }
    }
  }

  @override
  void onRefresh() async {
    super.onRefresh();
    controller.pageIndex = 1;
    await controller.getHisList();
    controller.refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiMineController());
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
            child: Obx(() => _bannerInfo()),
          ),
          SliverToBoxAdapter(
            child: _navTab(),
          ),
          SliverToBoxAdapter(
              child: Obx(() {
                if(controller.curTab.value == '收益明细'.tr) {
                  if(controller.beanList.isEmpty) {
                    return const EmptyView();
                  }
                  return ListView.builder(itemBuilder: (ctx,index) {
                    DetailListBean bean = controller.beanList[index];
                    return _listDetailItem(index,bean);
                  },itemCount: controller.beanList.length,
                    shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                    padding: MyInsets(all: 0.w),
                  );
                }else {
                  if(controller.hisList.isEmpty) {
                    return const EmptyView();
                  }
                  return ListView.builder(itemBuilder: (ctx,index) {
                    return _listHistoryItem(index);
                  },itemCount: controller.hisList.length,
                    shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                    padding: MyInsets(all: 0.w),
                  );
                }
              })
          )
        ],
      ),
    );
  }


  _bannerInfo() {
    var detailBean = controller.detailBean.value;
    return MyCard(
      height: 170.h,
      padding: MyInsets(all: 0.w),
      child: Stack(
        children: [
          MyImg.assetImg('home/ai/bg_mine_top.png', double.infinity, 170.h,fit: BoxFit.fill,),
          Obx(() {
            bool show = controller.showMoney.isTrue;
            return Padding(
              padding: MyInsets(horizontal: 18.w,vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      MyText('理财账户估值'.tr,color: C.white,size: 16.sp,),
                      8.w.spaceW,
                      MyGestureDetector(
                        onTap: () => controller.showMoney.value = !controller.showMoney.value,
                        child: MyImg.assetImg('login/${show ? 'ic_eye_open': 'ic_eye_close'}.png', 24.w, 24.h,color: C.white),
                      ),
                    ],
                  ),
                  10.h.spaceH,
                  MyText(show ? detailBean.valuation??'' : controller.starMoney,size: 36.sp,bold: true,color: C.white,),
                  16.h.spaceH,
                  Row(
                    children: [
                      _bannerItem('理财⾦额（USDT）'.tr,show ? detailBean.amount??'' : controller.starMoney),
                      Container(
                        height: 32.h,
                        width: 1.w,
                        color: C.white,
                        margin: MyInsets(horizontal: 13.w),
                      ),
                      _bannerItem('收益（AIT）'.tr,show ? detailBean.income??'' : controller.starMoney),
                    ],
                  )
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

  _navTab() {
    return Container(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...[
            {'txt': '收益明细'.tr,},
            {'txt': '投资记录'.tr,},
          ].map((e) {
            return MyGestureDetector(
                onTap: () {
                  controller.curTab.value = e['txt']??'';
                  controller.pageIndex == 1;
                  controller.getData();
                },
                child: Obx(() => Container(
                  padding: MyInsets(horizontal: 6.w,vertical: 4.h),
                  margin: MyInsets(right: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(e['txt']??'',color: controller.curTab.value == e['txt'] ? C.f131a22 : C.f5f5f5f,size: 16.sp, bold: controller.curTab.value == e['txt']),
                      Container(
                        height: 2.h,
                        margin: MyInsets(top: 4.h),
                        width: 60.w,
                        color: controller.curTab.value == e['txt'] ? C.mainColor : C.white,
                      )
                    ],
                  ),
                ))
            );
          }).toList()
        ],
      ),
    );
  }

  _list() {
    if(controller.curTab.value == '收益明细') {
      if(controller.beanList.isEmpty) {
        return const EmptyView();
      }
      return ListView.builder(itemBuilder: (ctx,index) {
        DetailListBean bean = controller.beanList[index];
        return _listDetailItem(index,bean);
      },itemCount: controller.beanList.length,
        shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
        padding: MyInsets(all: 0.w),
      );
    }else {
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
                  if(controller.hisList.isEmpty) {
                    return const EmptyView();
                  }
                  return ListView.builder(itemBuilder: (ctx,index) {
                    return _listHistoryItem(index);
                  },itemCount: controller.hisList.length,
                    shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
                    padding: MyInsets(all: 0.w),
                  );
                })
            )
          ],
        ),
      );
    }
  }

  _listDetailItem(int index,DetailListBean bean) {
    var title = controller.titleList[index];
    return MyCard(
      bg: C.ff8fff4,
      margin: MyInsets(bottom: 12.h),
      padding: MyInsets(all: 12.w),
      onTap: () {
        controller.toDetailList(title);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _detailItem('收益名称'.tr,title),
              _detailItem('当前收益'.tr,bean.bonus??''),
              _detailItem('收益时间'.tr,Util.formatTime('${bean.period??''}')),
            ],
          ),
        ],
      ),
    );
  }

  _listHistoryItem(int index) {
    AiMineInvestHisBean hisBean = controller.hisList[index];
    return MyCard(
      bg: C.ff8fff4,
      margin: MyInsets(bottom: 12.h),
      padding: MyInsets(all: 12.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _detailItem('币种'.tr,'USDT'),
              _detailItem('当前利率'.tr,hisBean.lastPer??''),
              _detailItem('总收益'.tr,hisBean.totalBonus??''),
            ],
          ),
          11.h.spaceH,
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _detailItem('本金'.tr,'${hisBean.touziAmount??''}'),
              _detailItem('起息日'.tr,hisBean.beginDay??''),
              _detailItem('状态'.tr,hisBean.statusVal??''),
            ],
          ),
        ],
      ),
    );
  }

  _detailItem(String top,String bot) {
    return Expanded(
        child: Container(
          margin: MyInsets(left: 0),
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
