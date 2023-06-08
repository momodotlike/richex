import 'package:flutter_rich_ex/bean/ai_mine_detail_bean.dart';
import 'package:flutter_rich_ex/service/ai/ai_mine_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiMineFeeHistoryController extends BaseController {

  late String type;
  RxList<DetailListBean> beanList = <DetailListBean>[].obs;

  @override
  void onReady() {
    super.onReady();
    type = Get.arguments['type'];
    getData();
  }

  getData() async{
    var query = {
      'page_no': '1',
      'pageSize': '10',
      'period': '',
    };
    var res = await AiMineService.getTypeList(type, query);
    if(res !=null) {
      beanList.addAll(res);
    }
  }

}
class AiMineFeeHistoryPage extends StatelessWidget {

  AiMineFeeHistoryPage({Key? key}) : super(key: key);

  late AiMineFeeHistoryController controller ;
  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiMineFeeHistoryController());
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar('收益明细'),
      body: _body(),
    );
  }

  _body() {
    return Obx(() => _list());
  }


  _list() {
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
