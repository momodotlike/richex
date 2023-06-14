import 'package:flutter_rich_ex/bean/ait_list_bean.dart';
import 'package:flutter_rich_ex/service/ai/ai_aic_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiCheckController extends BaseController {

  RxBool checkBox = false.obs;
  int pageIndex = 1;
  RxList<AitListBean> aicList = <AitListBean>[].obs;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() async{
    var query = {'page_no': pageIndex};
    if(pageIndex == 1) {
      aicList.clear();
    }
    var res = await AiAicService.getAicList(query);
    if(res !=null) {
      res.forEach((element) {
        AitListBean bean = AitListBean.fromJson(element);
        aicList.add(bean);
      });
    }
  }
}

class AiCheckPage extends StatelessWidget {
  AiCheckPage({Key? key}) : super(key: key);
  late AiCheckController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiCheckController());

    return Scaffold(
      appBar: MyAppBar('AIC账单'.tr),
      backgroundColor: C.white,
      body: _body(),
    );
  }

  _body() {
    return Column(
      children: [
        // _filter(),
        Obx(() {
          if(controller.aicList.isEmpty) {
            return EmptyView(marginTop: 300.h,);
          }
          return _list();
        }),
      ],
    );
  }

  _filter() {
    return Container(
      padding: MyInsets(horizontal: 14.w,bottom: 24.h),
      child: Row(
        children: [
          MyButton(
            width: 120.w,
            height: 30.h,
            margin: MyInsets(right: 30.w),
            padding: MyInsets(left: 10.w),
            round: 17.0,
            onTap: () {

            },
            color: C.fefefef,
            child: Row(
              children: [
                MyText('全部月份'.tr,),
                Icon(Icons.keyboard_arrow_down_rounded,size: 20.w,)
              ],
            )
          ),
          MyButton(
            width: 120.w,
            height: 30.h,
            round: 17.0,
            padding: MyInsets(left: 10.w),
            onTap: () {

            },
            color: C.fefefef,
            child: Row(
              children: [
                MyText('收入/支出'.tr,),
                Icon(Icons.keyboard_arrow_down_rounded,size: 20.w,)
              ],
            )
          )
        ],
      ),
    );
  }
  _list() {
    return Expanded(
        child: ListView.builder(itemBuilder: (ctx,index) {
          AitListBean bean = controller.aicList[index];
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
        },itemCount: controller.aicList.length,padding: MyInsets(horizontal: 14.w),)
    );
  }
}

