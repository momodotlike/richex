import 'package:flutter/material.dart';
import 'package:flutter_rich_ex/base/base_controller.dart';
import 'package:flutter_rich_ex/style/themes.dart';
import 'package:flutter_rich_ex/util/extension.dart';
import 'package:flutter_rich_ex/widgets/my_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FilterProductController extends BaseController {

  RxList<String> categoryList = ['All','Mobile','Fax to Email','GCF','IDD',
    'Conference','SMS','IPLC / DIA / MPLS','Office 365','Broadband','Fixed Line','Air Purifier'].obs;

  RxList<String> checkedList = <String>[].obs;
}

class FilterProductDialog extends StatelessWidget {

  FilterProductDialog({Key? key}) : super(key: key);
  late FilterProductController controller;

  @override
  Widget build(BuildContext context) {
    controller = Get.put(FilterProductController());

    return Container(
      margin: MyInsets(top: 44.h),
      decoration: BoxDecoration(
        color: C.white,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      padding: MyInsets(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.h.spaceH,
          IconButton(onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back,color: C.mainColor,size: 20,),
              alignment: Alignment.centerLeft,
              padding: MyInsets(all: 0.w),
          ),
          12.h.spaceH,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText('Product Category',bold: true,size: 16.sp,color: C.mainColor,),
              MyText('Reset',bold: true,size: 14.sp,color: C.black,),
            ],
          ),
          _list(),
          Spacer(),
          MyButton(
            text: 'Apply',
            textColor: C.white,
            height: 52.h,
            round: 10.0,
            color: C.mainColor,
          ),
          30.h.spaceH,
        ],
      ),
    );
  }

  _list() {
    return ListView.builder(itemBuilder: (ctx,index) {
      String str = controller.categoryList[index];
      return Container(
        height: 46.h,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: C.black,width: 1)
            )
        ),
        child: Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(str,weight: FontWeight.w600,color: controller.checkedList.contains(str) ? C.mainColor : null,),
            SizedBox(
              height: 20.h,
              width: 20.w,
              child: Checkbox(
                value: controller.checkedList.contains(str), onChanged: (v){
                if(controller.checkedList.contains(str)) {
                  controller.checkedList.remove(str);
                }else {
                  controller.checkedList.add(str);
                }
              },
                // shape: const CircleBorder(),
                activeColor: C.priColor,
              ),
            )
          ],
        )),
      );
    },itemCount: controller.categoryList.length,shrinkWrap: true,);
  }
}
