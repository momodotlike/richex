export 'package:flutter/material.dart';
export 'package:flutter_rich_ex/router/app_pages.dart';
export 'package:flutter_rich_ex/util/sp_util.dart';
export 'package:flutter_rich_ex/util/util.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_rich_ex/base/base_controller.dart';
export 'package:flutter_rich_ex/style/my_imgs.dart';
export 'package:flutter_rich_ex/style/themes.dart';
export 'package:flutter_rich_ex/util/extension.dart';
export 'package:flutter_rich_ex/widgets/my_widgets.dart';
export 'package:flutter_rich_ex/util/text_util.dart';
export 'package:flutter_rich_ex/const/constant.dart';
export 'package:flutter_rich_ex/api/api.dart';
export 'package:flutter_rich_ex/const/config.dart';
export 'package:flutter_rich_ex/ui/component/my_divider.dart';
export 'package:flutter_rich_ex/ui/component/empty_view.dart';
export 'dart:async';
export 'package:flutter_rich_ex/util/pull_to_refresh.dart';

int _logId = 0;

void log(Object obj, {String? tag}) {
  int id = _logId++;
  String s1 = obj.toString();
  int max = 880;
  while (true) {
    String s2 = '';
    if (s1.length > max) {
      s2 = s1.substring(max);
      s1 = s1.substring(0, max);
      if (tag == '') tag = "$id";
    }
    s1 = "Log打印内容----" + (tag ?? "") + " " + s1;
    print(s1);
    if (s2 == '') break;
    s1 = s2;
  }
}

class UiEntry {
  dynamic id;
  dynamic title;
  dynamic image;
  Function? act;

  UiEntry({this.id, this.title, this.image, required this.act});

  UiEntry.build(this.id, this.title, this.image, [this.act]);
}

class Func {
  final Function src;

  Func(this.src);

  call([args]) => src.call(args);
}

//void showHud() {
//  _dismissHud?.cancel();
//  SVProgressHUD.show();
//  dismissHud(delay: 40000);
//}
//
//Timer _dismissHud;
//bool isEmpty(String s) => s==null || s.isEmpty;
//
//void dismissHud({int delay = 30,Function complete}) {
//  _dismissHud?.cancel();
//  if (delay == 0){
//    SVProgressHUD.dismiss();
//  }else {
//    _dismissHud = Timer(Duration(milliseconds: delay), () {
//      _dismissHud = null;
//      SVProgressHUD.dismiss();
//      if (complete != null){
//        complete();
//      }
//    });
//  }
//}
//
//void showHudInfo(String message, {double seconds = 1.5, Function complete}) {
//  if(isEmpty(message)) return;
//  _dismissHud?.cancel();
//  Future.delayed(Duration(milliseconds: 50),(){
//    SVProgressHUD.showInfo(status: message);
//  });
//  if (seconds != 0) {
//    dismissHud(delay: (seconds * 1000).floor(),complete: complete);
//  }
//}
//
//void showHudError(dynamic message, {double seconds = 1.5, Function complete}) {
//  if (message is Exception) {
//    var list = message.toString().split(":").map((e) => e.trim()).toList();
//    list.removeWhere((element) =>
//    element.contains("Exception") || element.contains("exception"));
//    message = list.join(":");
//  }
//  if (!(message is String)) {
//    message = message.toString();
//  }
//  _dismissHud?.cancel();
//  Future.delayed(Duration(milliseconds: 50),(){
//    SVProgressHUD.showError(status: message);
//  });
//  if (seconds != 0) {
//    dismissHud(delay: (seconds * 1000).floor(),complete: complete);
//  }
//
//}
//
//void showHudSuccess(String message, {double seconds = 1.5, Function complete}) {
//  _dismissHud?.cancel();
//  Future.delayed(Duration(milliseconds: 50),(){
//    SVProgressHUD.showSuccess(status: message);
//  });
//  if (seconds != 0) {
//    dismissHud(delay: (seconds * 1000).floor(),complete: complete);
//  }
//}

String clipAddress(String address, {int count = 8, int star = 3}) {
  if (address == null) {
    return "";
  }
  if (address.length < count * 2) {
    return address;
  }

  String starStr = "";
  for (int i = 0; i < star; i ++) {
    starStr += ".";
  }

  return "${address.substring(0, count)}"+starStr+"${address.substring(address.length - count, address.length)}";
}

typedef T LazyValue<T>();
T  resolve<T>(T error, LazyValue func){
  try{
    final data = func();
    if (data == null)
      return error;

    return data;
  }catch(ex){
    print("error ${ex.toString()}");
    return error;
  }
}
