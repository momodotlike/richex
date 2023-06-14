import 'package:flutter_rich_ex/ui/tab/assets_page.dart';
import 'package:flutter_rich_ex/ui/tab/contract_page.dart';
import 'package:flutter_rich_ex/ui/tab/home_page.dart';
import 'package:flutter_rich_ex/ui/tab/market_page.dart';
import 'package:flutter_rich_ex/ui/tab/spots_page.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class MainController extends BaseController{

  RxInt pageIndex = 0.obs;

  var pageCtrl = PageController();

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  loadData() {
    SpUtil.putBool(Constant.isFirstEnter, true);
  }

  toCardDetail(String pagePath) {
    Get.toNamed(pagePath);
  }
}

class MainPage extends StatelessWidget{

  MainPage({Key? key}) : super(key: key);

  final MainController controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    List pages = [
      UiEntry.build("", "首页".tr, ['tabbar-0-0.png', 'tabbar-sel-0-0.png'], (s) => HomePage()),
      UiEntry.build("", "行情".tr, ['tabbar-0-1.png', 'tabbar-sel-0-1.png'], (s) => MarketPage()),
      UiEntry.build("", "现货".tr, ['tabbar-0-2.png', 'tabbar-sel-0-2.png'], (s) => SpotsPage()),
      UiEntry.build("", "合约".tr, ['tabbar-0-3.png', 'tabbar-sel-0-3.png'], (s) => ContractPage()),
      UiEntry.build("", "资产".tr, ['tabbar-0-4.png', 'tabbar-sel-0-4.png'],(s) => AssetsPage()),
    ];
    return Scaffold(
      body: Obx(() => Column(children: [
        Expanded(
          child: PageView.builder(itemBuilder: (ctx,index) {
            var e  = pages[index];
            var c = e.act(e.title) as Widget;
            return c;
          },itemCount: pages.length,
            onPageChanged: (i) {
              controller.pageIndex.value = i;
            },
            controller: controller.pageCtrl,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
        BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: pages
              .map((e) => BottomNavigationBarItem(
            label: e.title,
            backgroundColor: C.white,
            icon: MyImg.assetImg('tab/${e.image[0]}', 30.w, 30.h),
            activeIcon: MyImg.assetImg('tab/${e.image[1]}', 30.w, 30.h),
          ))
              .toList(growable: false),
          currentIndex: controller.pageIndex.value,
          backgroundColor: C.white,
          onTap: (index) {
            log('index===$index');
            if (index != controller.pageIndex.value) {
              controller.pageCtrl.jumpToPage(index);
              controller.pageIndex.value = index;
            }
          },
          unselectedItemColor: C.fccc,
          unselectedFontSize: 14,
          selectedItemColor: C.f1d2027,
        ),
      ])),
    );
  }
}
