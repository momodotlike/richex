import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter_rich_ex/bean/area_code_info.dart';
import 'package:flutter_rich_ex/router/routes.dart';
import 'package:flutter_rich_ex/service/user_service.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_rich_ex/util/timer_util.dart';
import 'package:get/get.dart';

class AreaCodeController extends BaseController {

  TextEditingController ctrl = TextEditingController();

  RxList<String> areaList = <String>[].obs;

  @override
  void onReady() {
    super.onReady();
    initData();
  }

  initData() {
    areaList.add('美国');
    areaList.add('韩国');
    areaList.add('中国');
    areaList.add('利比亚');
    areaList.add('马来西亚');
    areaList.add('马尔代夫');
  }
}

class AreaCodePage extends StatelessWidget {
  AreaCodePage({Key? key}) : super(key: key);
  final AreaCodeController controller = Get.put(AreaCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar('',showDivider: false,leftShow: false,bC: C.whiteBg,),
      body: Container(
        decoration: BoxDecoration(
          color: C.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20)
          )
        ),
        child: Column(
          children: [
            _searchArea(),
            Expanded(child: Obx(() => _body())),
          ],
        ),
      ),
    );
  }

  _body() {
    return Container(
      padding: MyInsets(horizontal: 15.w),
      child: ListView.builder(itemBuilder: (ctx,index) {
        var bean = controller.areaList[index];
        return MyGestureDetector(
          onTap: () {
            Get.back(result: '+852');
          },
          child: Container(
            height: 49.h,
            padding: MyInsets(horizontal: 13.w),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: C.divider,width: 0.5.h)
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(bean),
                MyText('+86'),
              ],
            ),
          ),
        );
      },itemCount: controller.areaList.length,padding: MyInsets(all: 0.w),)
    );
  }

  _searchArea() {
    BorderRadius borderRadius = BorderRadius.circular(24);
    return Container(
      height: 40.h,
      margin: MyInsets(top: 12.h,bottom: 22.h),
      padding: MyInsets(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(child: TextField(
            decoration: InputDecoration(
                hintText: '请选择国家或者地区',
                hintStyle: TextStyle(color: C.f999,fontSize: 14.sp),
                contentPadding: const MyInsets(vertical: 13, left: 12),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: C.ff6f6f6,width: 1),
                  borderRadius: borderRadius,
                ),
                fillColor: C.ff6f6f6,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: C.ff6f6f6,width: 1),
                  borderRadius: borderRadius,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: C.ff6f6f6,width: 1),
                    borderRadius: borderRadius
                ),
                prefixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                    size: 20,
                    color: C.f9e9e9e,
                  ),
                  onPressed: () {
                  },
                ),
            ),
            controller: controller.ctrl,
          )),
          14.w.spaceW,
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: MyText('取消',color: C.f999,),
          )
        ],
      ),
    );
  }
}
