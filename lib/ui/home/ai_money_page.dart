import 'package:flutter_rich_ex/ui/home/aimoney/ai_invest_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_invite_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_mine_page.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiMoneyController extends BaseController {

  RxString curTab = '投资'.obs;
  final String TYPE_INVEST = '投资';
  final String TYPE_MINE = '我的';
  final String TYPE_INVITE = '邀请';

  @override
  void onReady() {
    super.onReady();
  }
}

class AiMoneyPage extends StatelessWidget {
  AiMoneyPage({Key? key}) : super(key: key);
  late AiMoneyController controller;

  
  @override
  Widget build(BuildContext context) {
    controller = Get.put(AiMoneyController());
    return Scaffold(
      appBar: MyAppBar('AI理财'),
      body: _body(),
    );
  }

  _body() {
    return Container(
      child: Column(
        children: [
          Expanded(child: _bodyContent()),
          _bottomNav()
        ],
      ),
    );
  }

  _bodyContent() {
    return Obx(() {
      if(controller.curTab.value == controller.TYPE_INVEST) {
        return AiInvestPage();
      }else if(controller.curTab.value == controller.TYPE_INVITE) {
        return AiInvitePage();
      }else if(controller.curTab.value == controller.TYPE_MINE) {
        return AiMinePage();
      }
      return Container(
        color: C.mainColor,
        alignment: Alignment.center,
        child: MyText(controller.curTab.value),
      );
    });
  }

  _bottomNav() {
    return Container(
      height: 80.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ...[
            {'ic': 'ic_invest.png','ic_sel': 'ic_invest_sel.png','name': '投资'},
            {'ic': 'ic_invite.png','ic_sel': 'ic_invite_sel.png','name': '邀请'},
            {'ic': 'ic_mine.png','ic_sel': 'ic_mine_sel.png','name': '我的'},
          ].map((e) => Obx(() {
            var isSel = controller.curTab.value == e['name'];
            return GestureDetector(
              onTap: () {
                controller.curTab.value = e['name']??'';
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 28.h,
                      width: 28.w,
                      margin: MyInsets(bottom: 4.h),
                      child: MyImg.assetImg('home/ai/${isSel ? e['ic_sel'] : e['ic']}', 28.w, 28.h),
                    ),
                    MyText(e['name']??'',color: isSel ? C.f1d2027 : C.fccc,size: 12.sp,)
                  ],
                ),
              ),
            );
          })).toList()
        ],
      ),
    );
  }
}
