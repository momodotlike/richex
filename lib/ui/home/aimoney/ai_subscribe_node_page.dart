import 'package:flutter_rich_ex/bean/node_detail_bean.dart';
import 'package:flutter_rich_ex/bean/subscribe_node_bean.dart';
import 'package:flutter_rich_ex/dialog/custom_dialog.dart';
import 'package:flutter_rich_ex/service/ai/subscribe_node_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';

class AiSubscribeNodeController extends BaseController {

  RxList<SubscribeNodeBean> nodeList = <SubscribeNodeBean>[].obs;

  Rx<NodeDetailBean> detailBean = NodeDetailBean().obs;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() async{
    var detail = await SubscribeNodeService.getNodeDetail();
    if(detail !=null) {
      detailBean.value = detail;
    }

    var query = {
      'page_no': '1',
      'pageSize': '10',
    };
    var res = await SubscribeNodeService.getBuyList(query);
    nodeList.addAll(res);
  }

}
class AiSubscribeNodePage extends StatelessWidget {

  AiSubscribeNodePage({Key? key}) : super(key: key);

  late AiSubscribeNodeController controller ;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiSubscribeNodeController());
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar('节点'),
      body: _body(),
    );
  }

  _body() {
    return ListView(
      padding: MyInsets(horizontal: 14.w,top: 20.h),
      children: [
        Obx(() => _infoCard()),
        _flagTitle(),
        Obx(() => _list()),
      ],
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
                        MyText('运行天数:${detail.dayQuntity??''}天',color: C.f5f5f5f,size: 15.sp,),
                      ],
                    )
                  ],
                ),
                5.h.spaceH,
                Row(
                  children: [
                    _bannerItem('昨日返佣（USDT）',detail.bonus??'' ),
                    Container(
                      height: 30.h,
                      width: 1.w,
                      color: C.white,
                      margin: MyInsets(horizontal: 13.w),
                    ),
                    _bannerItem('累计返佣（USDT）',detail.totalBonus??''),
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
          MyText('节点详情',color: C.black,size: 16.sp,bold: true,),
          12.h.spaceH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item('节点名称',bgColor: C.ff0f0f0,color: C.f999,),
              _item('节点级别',bgColor: C.ff0f0f0,color: C.f999,),
              _item('节点收益',bgColor: C.ff0f0f0,color: C.f999,),
              _item('运行天数',bgColor: C.ff0f0f0,color: C.f999,),
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

  _list() {
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
      padding: MyInsets(all: 0.w),
    );
  }
}
