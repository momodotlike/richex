import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class ChoseTypeCoinSheet extends StatelessWidget {
  const ChoseTypeCoinSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.h,
      margin: MyInsets(horizontal: 10.w,bottom: 24.h),
      child: Column(
        children: [

          MyButton(
            color: C.white,
            height: 44.h,
            round: 13.0,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(13),
              topLeft: Radius.circular(13),
            ),
            child: MyText('选择币种',color: C.f959595,size: 14.sp,),
          ),
          ...['AIC','AIT'].map((e) => MyButton(
            color: C.white,
            height: 56.h,
            borderRadius: e == 'AIT' ?  const BorderRadius.only(
              bottomRight: Radius.circular(13),
              bottomLeft: Radius.circular(13),
            ): const BorderRadius.all(Radius.circular(0)),
            // border: Border(
            //   bottom: BorderSide(color: C.divider,width: 1)
            // ),
            onTap: () => Get.back(result: e),
            child: MyText(e,bold: true,color: C.f333,size: 20.sp,),
          ),).toList(),
          8.h.spaceH,
          MyButton(
            color: C.white,
            height: 56.h,
            round: 13.0,
            onTap: () => Get.back(),
            child: MyText('取消',bold: true,color: C.f959595,size: 20.sp,),
          ),
        ],
      ),
    );
  }
}
