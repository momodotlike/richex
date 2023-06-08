import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class MyDivider extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  const MyDivider({Key? key,this.height,this.width,this.color,this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height ?? 0.5,
      width: width ?? Get.width,
      color: color ?? C.divider,
    );
  }
}
