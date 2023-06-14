import 'package:flutter_rich_ex/bean/invest_bean.dart';
import 'package:flutter_rich_ex/bean/subscribe_node_bean.dart';
import 'package:flutter_rich_ex/event/event.dart';
import 'package:flutter_rich_ex/service/ai/invest_service.dart';
import 'package:flutter_rich_ex/service/ai/subscribe_node_service.dart';
import 'package:flutter_rich_ex/ui/home/ai_money_page.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';

class AiInvestController extends BaseController {

  RxString curTab = '智能理财'.tr.obs;
  RxList<ZulinBean> investList = <ZulinBean>[].obs;

  RxBool hasBuyNode = false.obs;
  List<StreamSubscription> subscriptions = [];

  AiMoneyController aiMainLogic = Get.find();

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
      if(event.name == '投资'.tr) {
        getData();
      }
    });
    subscriptions.add(s1);
  }


  @override
  void onInit() {
    super.onInit();
    getData();
  }

  getData() async{
    var res = await InvestService.getList();
    print('res===$res');
    if(res !=null) {
      InvestBean bean = res;
      investList.clear();
      investList.addAll(bean.zulinList??[]);
      hasBuyNode.value = num.parse('${bean.jiedian}') > 0;
    }
  }

  void toSubscribe(String id) async{
    var res = Get.toNamed(AppRoutes.AI_SUBSCRIBE,arguments: {'id': id});
    if(res !=null) {
      aiMainLogic.curTab.value = aiMainLogic.TYPE_MINE;
      eventBus.fire(RefreshAiMineNavEvent());
    }
  }
}
class AiInvestPage extends StatelessWidget {

  AiInvestPage({Key? key}) : super(key: key);

  late AiInvestController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiInvestController());
    return Scaffold(
      backgroundColor: C.white,
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: MyInsets(horizontal: 14.w,top: 20.h),
      children: [
        _bannerInfo(),
        _headNav(),
        _navTab(),
        _list(),
      ],
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
                  child: MyText('您身边的\n智能理财专家'.tr,size: 22.sp,bold: true,color: C.white,lineHeight: 1.8,),
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

  _headNav() {
    return Container(
      color: C.white,
      margin: MyInsets(top: 20.h),
      padding: MyInsets(all: 15.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...[
            {'path': AppRoutes.AI_SUBSCRIBE_NODE,'ic': 'home/ai/ic_invest_nav_0.png','txt': '节点'.tr},
            {'path': AppRoutes.AI_MING,'ic': 'home/ai/ic_invest_nav_1.png','txt': 'AIC挖矿'.tr},
            {'path': AppRoutes.AI_QUICK_EXCHANGE,'ic': 'home/ai/ic_invest_nav_2.png','txt': '闪兑'.tr},
            {'path': AppRoutes.AI_MINE_TEAM,'ic': 'home/ai/ic_invest_nav_3.png','txt': '团队'.tr},
            {'path': AppRoutes.AI_MONEY,'ic': 'home/ai/ic_invest_nav_4.png','txt': '客服'.tr},
          ].map((e) => MyGestureDetector(
              onTap: () async{
                if(e['path'] == AppRoutes.AI_SUBSCRIBE_NODE) {
                  if(controller.hasBuyNode.isTrue) {
                    await Get.toNamed(AppRoutes.AI_SUBSCRIBE_NODE);
                  }else {
                    await Get.toNamed(AppRoutes.AI_SUBSCRIBE_APPLY_NODE);
                  }
                  controller.getData();
                }else {
                  Get.toNamed(e['path']??'');
                }
              },
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

  _navTab() {
    return Container(
      height: 50.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...[
            {'txt': '智能理财'.tr,},
            // {'txt': '定期理财',},
          ].map((e) {
            return MyGestureDetector(
                onTap: () {
                  controller.curTab.value = e['txt']??'';
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
    return Obx(() {
      if(controller.investList.isEmpty) {
        return EmptyView();
      }
      return ListView.builder(itemBuilder: (ctx,index) {
        ZulinBean bean = controller.investList[index];
        return MyCard(
          bg: C.ff8fff4,
          margin: MyInsets(bottom: 12.h),
          padding: MyInsets(all: 12.w),
          border: Border.all(color: C.mainColor,width: 0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyImg.assetImg('home/ai/ic_invest_list_usdt.png', 64.w, 64.h),
                  20.w.spaceW,
                  Expanded(
                    child: SizedBox(
                      height: 85.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MyText('最大利率'.tr,color: C.f5f5f5f,),
                              MyText('预计年化'.tr,color: C.f5f5f5f,),
                              MyText('申购限额'.tr,color: C.f5f5f5f,),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText('${bean.maxPer??''} %',color: C.f333,bold: true,size: 18.sp,),
                              MyText('${bean.nianhuaPer??''}%',color: C.f333,bold: true,size: 18.sp,),
                              MyText('${bean.minZulinAmount??''}-${bean.maxZulinAmount??''}',color: C.f333,bold: true,size: 18.sp,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // if(controller.hasBuyNode.isTrue)
              MyButton(
                text: '申购'.tr,
                textColor: C.white,
                height: 33.h,
                width: Get.width - 64.w,
                round: 9.0,
                margin: MyInsets(top: 20.h,bottom: 3.h),
                onTap: () {
                  controller.toSubscribe('${bean.zulinId}');
                },
              )
            ],
          ),
        );
      },itemCount: controller.investList.length,
        shrinkWrap: true,physics: const NeverScrollableScrollPhysics(),
        padding: MyInsets(all: 0.w),
      );
    });
  }
}
