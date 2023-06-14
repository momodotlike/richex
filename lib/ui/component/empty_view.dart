import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class EmptyView extends StatelessWidget {
  final double? marginTop;
  const EmptyView({Key? key,this.marginTop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300.h,
        width: 400.w,
        alignment: Alignment.center,
        margin: MyInsets(top: marginTop?? 100.h),
        child: Column(
          children: [
            MyImg.assetImg('common/ic_empty.png', 170.w, 82.h),
            23.h.spaceH,
            MyText('暂无数据'.tr,color: C.f5f5f5f,size: 16.sp,)
          ],
        ),
      ),
    );
  }
}
