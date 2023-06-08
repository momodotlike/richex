import 'package:flutter/material.dart';
import 'package:flutter_rich_ex/base/base_controller.dart';
import 'package:flutter_rich_ex/style/themes.dart';
import 'package:flutter_rich_ex/util/extension.dart';
import 'package:flutter_rich_ex/widgets/my_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ShareFaceController extends BaseController {

}

class ShareFaceDialog extends StatelessWidget {

  ShareFaceDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: MyInsets(top: 44.h),
        decoration: BoxDecoration(
          color: C.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        padding: MyInsets(horizontal: 15.w),
        height: 280.h,
        width: 280.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            15.h.spaceH,
            GestureDetector(
              onTap: () => Get.back(),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.close,size: 26.sp,),
              ),
            ),

            Container(
              height: 160.h,
              width: 160.w,
              color: C.mainColor,
              margin: MyInsets(bottom: 14.h,top: 20.h),
            ),
            MyText('面对面分享',size: 18.sp,bold: true,)
          ],
        ),
      ),
    );
  }
}
