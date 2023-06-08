import 'package:flutter_rich_ex/bean/subscribe_node_bean.dart';
import 'package:flutter_rich_ex/dialog/custom_dialog.dart';
import 'package:flutter_rich_ex/service/ai/subscribe_node_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';

class AiSubscribeApplyNodeController extends BaseController {

  RxBool checked = false.obs;

  RxList<SubscribeNodeBean> nodeList = <SubscribeNodeBean>[].obs;
  Rx<SubscribeNodeBean> curBean = SubscribeNodeBean(jiedianId: -1).obs;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() async{
    var res = await SubscribeNodeService.getList();
    nodeList.addAll(res);
  }

  void toCheckSubscribe() async{
    var confirm = await Get.dialog(CustomDialog(
      title: '申请节点',
      content: '确定升级为${curBean.value.jiedianName??''}吗?申请节点的费用会直接\n从您的钱包账户直接划扣。',
      type: DialogType.FORWARD,
      rightText: '确定',
      leftText: '取消',
    ));
    if(confirm !=null && confirm) {
      var res = await SubscribeNodeService.applyNode(curBean.value.jiedianId);
      if(res) {
        Get.back();
      }
    }
  }

}
class AiSubscribeApplyNodePage extends StatelessWidget {

  AiSubscribeApplyNodePage({Key? key}) : super(key: key);

  late AiSubscribeApplyNodeController controller ;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiSubscribeApplyNodeController());
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar('申请节点'),
      body: Stack(
        children: [
          Obx(() => _body()),
          Positioned(
              left: 12.w,
              right: 12.w,
              bottom: 45.h,
              child: Obx(() => _btn())
          )
        ],
      ),
    );
  }

  _body() {
    return ListView.builder(itemBuilder: (ctx,index) {
      SubscribeNodeBean bean = controller.nodeList[index];
      return Obx(() {
        bool isSel = controller.curBean.value == bean;
        return MyGestureDetector(
          onTap: () {
            controller.curBean.value = bean;
          },
          child: Stack(
            children: [
              Container(
                margin: MyInsets(bottom: 20.h),
                padding: MyInsets(left: 12.h,vertical: 8.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border:  Border.all(
                        color: isSel ? C.mainColor : C.transparent,
                        width: 1
                    ),
                    color: C.ff8f8f8
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyImg.assetImg('home/ai/ic_level_list_${bean.jiedianId??1}.png', 90.w, 66.h),
                        MyText(bean.jiedianName??'',size: 16.sp,weight: FontWeight.w500,)
                      ],
                    ),
                    40.w.spaceW,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText('${bean.jiedianAmount??''}USDT  ${bean.totalNodeQuantity??''}个',color: C.f5f5f5f,size: 14.sp,),
                        MyText('赠送 ${bean.giveLevelName??''}  ${bean.dayAwardAmount??''}USDT/天',color: C.f5f5f5f,size: 14.sp,lineHeight: 1.8),
                        MyText('全网分红${bean.feeFenhongPer??''}%',color: C.f5f5f5f,size: 14.sp,lineHeight: 1.8),
                      ],
                    )
                  ],
                ),
              ),
              if(isSel)
                Positioned(
                  right: 0,
                  bottom: 20,
                  child: MyImg.assetImg('home/ai/ic_list_check.png', 34.w, 34.h),
                )
            ],
          ),
        );
      });
    },itemCount: controller.nodeList.length,padding: MyInsets(horizontal: 15.w,vertical: 30.h),);
  }


  _btn() {
    return MyButton(
      textColor: controller.curBean.value.jiedianId != -1 ? C.white : C.f333,
      height: 44.h,
      width: Get.width - 24.w,
      text: '确定',
      round: 22.0,
      color: controller.curBean.value.jiedianId != -1 ? C.mainColor : C.fe3e3e3,
      onTap: () {
        controller.toCheckSubscribe();
      },
    );
  }

  _infoItem(String left,String right) {
    return Padding(
      padding: MyInsets(bottom: 5.h),
      child: Row(
        children: [
          MyText(left,size: 15.sp,color: C.f5f5f5f,),
          30.w.spaceW,
          MyText(right,size: 18.sp,color: C.f333,bold: true,),
        ],
      ),
    );
  }
}
