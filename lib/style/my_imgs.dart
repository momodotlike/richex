import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyImg {
  static String T = 'https://img-nos.yiyouliao.com/inforec-20210428-be9fdfa0de810d5be054c7007aef0f1a.jpg';

  static String Y = 'https://img13.360buyimg.com/n2/jfs/t3103/6/8321543154/149737/abe8883e/58c3b1ccN5287fd43.jpg';

  /// 获取本地图片路径
  static String getImgPath(String imgPath) {
    return 'assets/images/$imgPath';
  }

  /// 加载本地图片
  static Image assetImg(
    String path,
    double? w,
    double? h, {
    BoxFit fit = BoxFit.scaleDown,
    Color? color,
  }) {
    return Image.asset(
      'assets/images/$path',
      width: w,
      height: h,
      fit: fit,
      color: color,
    );
  }

  static Image image(
    String name, {
    String? path,
    double? w,
    double? h,
    BoxFit fit = BoxFit.fill,
  }) {
    return Image.asset(
      path == null ? 'assets/images/$name' : 'assets/images/$path/$name',
      width: w,
      height: h,
      fit: fit,
    );
  }

  /// 加载网络图片
  static netImg(String s, double w, double h,
      {bool local = false,
      String oriPath = 'common/ic_default_placehold.png',
      bool isHead = false,
      BoxFit fit = BoxFit.scaleDown,
      bool hasPlace = true,
      BorderRadius borderRadius = BorderRadius.zero,
      double radius = 0,
      EdgeInsetsGeometry? margin,
      }) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: (borderRadius == BorderRadius.zero) ? BorderRadius.circular(radius) : borderRadius,
        child: CachedNetworkImage(
          imageUrl: s,
          fit: fit,
          width: w,
          height: h,
          placeholder: (context, url) {
            return SizedBox(
              height: h,
              width: w,
              child: hasPlace ? assetImg(oriPath, w, h,fit: BoxFit.cover) : const SizedBox(),
            );
          },
          errorWidget: (context, url, obj) {
            return SizedBox(
              height: h,
              width: w,
              child: hasPlace ? assetImg(oriPath, w, h,fit: BoxFit.cover) : Container(height: h, width: w, color: Colors.grey[200]),
            );
          },
        ),
      ),
    );
  }

  // home
  static Image icDot = assetImg('home/ic_home_dot.jpg', 18, 18);
  static Image icUserHead = assetImg('home/ic_user_profile.png', 32, 32);
  static Image icMsg = assetImg('home/ic_msg.png', 24, 24);
  static Image icChatW = assetImg('home/ic_chat_w.png', 24, 24);
  static Image icScan = assetImg('home/ic_scan_w.png', 24, 24);
  static Image icRing = assetImg('home/ic_ring.png', 20, 20);
  static Image icMenu = assetImg('home/ic_menu.png', 14, 14);
  static Image icFloatUp = assetImg('home/ic_up.png', 30, 30);

  // login
  static Image icArrDown = assetImg('login/ic_arr_down.png', 12.w, 6.h);
  static Image icQues = assetImg('login/ic_question.png', 15.w, 15.h);

}
