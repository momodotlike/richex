import 'package:flutter_rich_ex/ui/dialog/share_face_dialog.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class InviteFriendController extends BaseController {

  @override
  void onReady() {
    super.onReady();
  }

  toShowDialog(String e) {
    if(e == '面对面分享'.tr) {
      Get.dialog(ShareFaceDialog());
    }else if(e =='复制链接'.tr) {

    }else {

    }
  }
}

class InviteFriendPage extends StatelessWidget {
  InviteFriendPage({Key? key}) : super(key: key);
  late InviteFriendController controller;
  @override
  Widget build(BuildContext context) {
    controller = Get.put(InviteFriendController());
    return Scaffold(
      appBar: MyAppBar('邀请好友'.tr),
      body: _body(),
    );
  }

  _body() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/home/invite/bg_invite.png'),fit: BoxFit.fill),
      ),
      child: Column(
        children: [
          32.h.spaceH,
          MyText('邀请好友注册下载'.tr,size: 32.sp,bold: true,),
          17.h.spaceH,
          MyText('一起轻松交易数字货币'.tr,size: 18.sp,),
          28.h.spaceH,
          Container(
            height: 320.h,
            width: 300.w,
            decoration: BoxDecoration(
              color: C.white,
              borderRadius: BorderRadius.circular(18)
            ),
            child: Column(
              children: [
                16.h.spaceH,
                MyText('累计邀请人数'.tr),
                16.h.spaceH,
                MyText('2001',size: 30.sp,),
                16.h.spaceH,
                Container(
                  padding: MyInsets(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText('我的邀请码'.tr),
                      16.h.spaceH,
                      Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: C.ff8f8f8,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        padding: MyInsets(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText('UUBu7GF'),
                            MyImg.assetImg('home/invite/ic_invite_copy.png', 14.w, 14.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                20.h.spaceH,
                Container(
                  padding: MyInsets(horizontal: 30.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText('我的专属邀请链接'.tr),
                      16.h.spaceH,
                      Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: C.ff8f8f8,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        padding: MyInsets(horizontal: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText('https://chatgpt.yb02.d_…'),
                            MyImg.assetImg('home/invite/ic_invite_copy.png', 14.w, 14.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            height: 120.h,
            color: C.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...[
                  {'name': '面对面分享'.tr,'link': 'ic_invite_share.png'},
                  {'name': '复制链接'.tr,'link': 'ic_invite_link.png'},
                  {'name': '邀请海报'.tr,'link': 'ic_invite_link.png'},
                ].map((e) {
                  return MyGestureDetector(
                    onTap: () => controller.toShowDialog(e['name']??''),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyImg.assetImg('home/invite/${e['link']}', 48.w, 48.h),
                          13.h.spaceH,
                          MyText('${e['name']}')
                        ],
                      ),
                    ),
                  );
                }).toList()
              ],
            ),
          )

        ],
      ),
    );
  }
}
