import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rich_ex/bean/user_info_bean.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Util {

  static UserInfoBean userInfo() {
    var res = SpUtil.getObj(Constant.userInfo, (v) => UserInfoBean.fromJson(v)) ?? UserInfoBean(id: -1);
    print('缓存的用户信息${res.toJson()}');
    return res;
  }

  static void showToast(String text) {
    if(text.trim().isEmpty) return;
    EasyLoading.showToast(text);
  }

  static stopInput() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  // 20230306 ---> 2023/03/06
  static String formatTime(String str,{String line = '/'}) {
    var year = str.substring(0,4);
    var month = str.substring(4,6);
    var day = str.substring(6,8);
    return '$year$line$month$line$day';
  }

  static void launchApp(int type,String code) {
    try {
      switch (type) {
        case 0: // whatsapp
          launchUrl(Uri.parse('whatsapp://send?phone=$code'),mode: LaunchMode.externalApplication);
          break;
        case 1: // phone
          launchUrl(Uri.parse('tel:$code'),mode: LaunchMode.externalApplication);
          break;
        case 2: // sms
          launchUrl(Uri.parse('sms:$code'),mode: LaunchMode.externalApplication);
          break;
        case 3:
          launchUrl(Uri.parse('$type'),mode: LaunchMode.externalApplication);
          break;
        default:
          break;
      }
    }catch (e) {
      print('e--$e');
      showToast('打開出錯，請稍後重試');
    }
  }

  static Future<bool> getPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
      return true;
    } else {
      status = await permission.request();
      if (!status.isGranted) openAppSettings();
      return status.isGranted;
    }
  }

  static Future<String> createTempFile({
    required String dir,
    required String fileName,
  }) async {
    var path =(Platform.isIOS ? await getTemporaryDirectory() : await getExternalStorageDirectory())?.path;
    File file = File('$path/$dir/$fileName');
    if (!(await file.exists())) {
      file.create(recursive: true);
    }
    return '$path/$dir/$fileName';
  }

  static copyData(String s) {
    Clipboard.setData(ClipboardData(text: s));
    showToast('复制成功');
  }
}