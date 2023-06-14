import 'package:flutter/material.dart';
import 'package:flutter_rich_ex/style/my_imgs.dart';
import 'package:flutter_rich_ex/style/themes.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:flutter_rich_ex/widgets/my_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InfoDialog extends StatelessWidget {

  final String? title;
  final String? url;
  final String? content;
  final Widget? contentWidget;
  final String? rightText;
  final String? leftText;

  const InfoDialog({
    Key? key,
    this.title,
    this.url,
    this.content,
    this.contentWidget,
    this.rightText,
    this.leftText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 1),() {
      Get.back();
    });
    return Material(
      color: Colors.transparent,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: 170.w,
            color: const Color(0xFFFFFFFF),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                18.h.spaceH,
                MyImg.assetImg('common/ic_info_ok.png', 18.w, 18.h),
                15.h.spaceH,
                MyText(content??'',color: C.mainColor,size: 16.sp,),
                16.h.spaceH,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
