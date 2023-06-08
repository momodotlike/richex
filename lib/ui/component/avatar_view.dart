import 'package:flutter/material.dart';
import 'package:flutter_rich_ex/style/my_imgs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvatarView extends StatelessWidget {
  final String? url;
  final double? w;
  final double? h;
  final double? round;
  final Function()? onTap;
  const AvatarView({Key? key,this.url,this.w,this.h,this.round,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyImg.netImg(url ?? MyImg.T, w??50.w, h??50.h,radius: round ?? 40,fit: BoxFit.cover),
    );
  }
}
