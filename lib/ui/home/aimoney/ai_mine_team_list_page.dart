import 'package:flutter_rich_ex/bean/ai_mine_detail_bean.dart';
import 'package:flutter_rich_ex/bean/aimine_team_bean.dart';
import 'package:flutter_rich_ex/bean/aimine_team_list_bean.dart';
import 'package:flutter_rich_ex/service/ai/ai_mine_service.dart';
import 'package:flutter_rich_ex/service/ai/team_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiMineTeamListController extends BaseController {

  RxList<DetailListBean> beanList = <DetailListBean>[].obs;
  RxList<String> navList = <String>[].obs;
  RxString curNavStr = '推荐收益'.obs;

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  getData() async{
    navList.add('推荐收益');
    navList.add('团队收益');
    navList.add('个人收益');
    navList.add('分享收益');
    navList.add('分红收益');
    navList.add('贡献收益');
    await loadData();
  }

  loadData() async{
    var query = {
      'page_no': '1',
      'pageSize': '10',
      'period': '',
    };
    // tuijian  推荐收益
    // weight  分红收益
    // zulin  租赁收益
    // jiedian  节点收益
    // share  分享收益
    // team  团队收益
    var res = await AiMineService.getTypeList(curNavStr.value, query);
    beanList.clear();
    if(res !=null) {
      beanList.addAll(res);
    }
  }

}
class AiMineTeamListPage extends StatelessWidget {

  AiMineTeamListPage({Key? key}) : super(key: key);

  late AiMineTeamListController controller ;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiMineTeamListController());
    return Scaffold(
      backgroundColor: C.white,
      appBar: MyAppBar('我的收益明细'),
      body: _body(),
    );
  }

  _body() {
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
      child: ListView.builder(itemBuilder: (ctx,index) {
        String navStr = controller.navList[index];
        return Obx(() {
          return GestureDetector(
            onTap: () {
              controller.curNavStr.value = navStr;
              controller.loadData();
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
