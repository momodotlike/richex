import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rich_ex/service/common_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class HtmlContentController extends BaseController {

  RxString title = ''.obs;
  RxString htmlContent = ''.obs;

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  loadData() async{
    var id = Get.arguments['id'];
    title.value = Get.arguments['title'];
    htmlContent.value =  await CommonService.getHtmlContent(id);
  }
}

class HtmlContentPage extends StatelessWidget {

  HtmlContentPage({Key? key}) : super(key: key);
  late HtmlContentController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(HtmlContentController());
    return Scaffold(
      appBar: MyAppBar('',
        centerTitle: Obx(() => MyText(controller.title.value,size: 18.sp)),
      ),
      body: _body(),
    );
  }

  _body() {
    return Obx(() => SingleChildScrollView(
      child: Html(
        data: controller.htmlContent.value,
      ),
    ));
  }
}
