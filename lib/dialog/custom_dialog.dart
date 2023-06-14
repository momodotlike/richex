import 'package:flutter/material.dart';
import 'package:flutter_rich_ex/style/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

enum DialogType {
  FORWARD,
  BASE,
  CUSTOM,
}

class CustomDialog extends StatelessWidget {

  const CustomDialog({
    Key? key,
    this.title,
    this.url,
    this.content,
    this.contentWidget,
    this.type = DialogType.BASE,
    this.rightText,
    this.leftText,
  }) : super(key: key);
  final String? title;
  final String? url;
  final String? content;
  final Widget? contentWidget;
  final DialogType type;
  final String? rightText;
  final String? leftText;

  static var c_979797_opacity50p = Color(0xFF979797).withOpacity(0.5);
  static var ts_333333_16sp = TextStyle(fontSize: 18.sp,color: Color(0xff131A22));
  static var ts_333333_14sp = TextStyle(fontSize: 14.sp,color: Color(0xff131A22),height: 1.8);
  static const c_FFFFFF = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: 320.w,
            color: Color(0xFFFFFFFF),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if(type == DialogType.CUSTOM)
                  contentWidget!,
                if (type == DialogType.FORWARD)
                  Column(
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(25.w, 18.h, 0, 19.h),
                        child: Text(
                          title ?? '',
                          style: ts_333333_16sp,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 25.w),
                          Expanded(child: Text(
                            content ?? '',
                            style: ts_333333_14sp,
                          ))
                        ],
                      ),
                    ],
                  ),
                if (type == DialogType.BASE)
                  Padding(
                    padding: EdgeInsets.only(top: 22.h, left: 8.w, right: 8.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            title ?? '',
                            style: TextStyle(color: Color(0xff333333),fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                SizedBox(
                  height: 21.h,
                ),
                // Divider(
                //   color: c_979797_opacity50p,
                //   height: 0.5.h,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _button(
                      bgColor: c_FFFFFF,
                      text: leftText ?? '取消',
                      textStyle: TextStyle(color: C.f959595,fontSize: 16.sp),
                      onTap: () {
                        Get.back(result: false);
                      },
                    ),
                    // Container(
                    //   color: c_979797_opacity50p,
                    //   width: 0.5.w,
                    //   height: 46.h,
                    // ),
                    _button(
                      bgColor: C.white,
                      text: rightText ?? '确认'.tr,
                      textStyle: TextStyle(color: C.fa3ff74,fontSize: 16.sp),
                      onTap: () {
                        Get.back(result: true);
                      },
                    ),
                    SizedBox(width: 22),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _button({
    required Color bgColor,
    required String text,
    required TextStyle textStyle,
    Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(6),
          color: bgColor,
        ),
        height: 46.h,
        width: 80.w,
        alignment: Alignment.center,
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
