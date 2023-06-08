import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_rich_ex/util/util.dart';
import 'package:permission_handler/permission_handler.dart';

/// return值: nil代表拒绝且不去设置， false代表拒绝且去设置，true代表已经接受

/// 麦克风权限
Future<bool?> requestMicrophonePermission({
  BuildContext? context,
  String? titleDesc,
  String? settingContent,
}) async {
  return requestPermissions(
    Permission.microphone,
    context: context,
    titleDesc: titleDesc,
    settingContent: settingContent,
  );
}

/// 相册权限
Future<bool?> requestPhotosPermission({
  BuildContext? context,
  String? titleDesc,
  String? settingContent,
}) async {
  return requestPermissions(
    Platform.isIOS ? Permission.photos : Permission.storage,
    context: context,
    titleDesc: titleDesc,
    settingContent: settingContent,
  );
}

/// 相机权限
Future<bool?> requestCameraPermission({
  BuildContext? context,
  String? titleDesc,
  String? settingContent,
}) async {
  return requestPermissions(
    Permission.camera,
    context: context,
    titleDesc: '"益捐"想访问您的相机',
    settingContent: settingContent,
  );
}

/// 存储权限
Future<bool?> requestStoragePermission({
  BuildContext? context,
  String? titleDesc,
  String? settingContent,
}) async {
  if (Platform.isIOS) {
    return false;
  } else
    return requestPermissions(
      Permission.storage,
      context: context,
      titleDesc: titleDesc,
      settingContent: settingContent,
    );
}

/// 位置权限
Future<bool?> requestLocationPermission({
  BuildContext? context,
  String? titleDesc,
  String? settingContent,
}) async {
  return requestPermissions(
    Permission.location,
    context: context,
    titleDesc: titleDesc,
    settingContent: settingContent,
  );
}

/// 检查存储权限
Future<bool> checkRequestStoragePermission() async {
  final status = await Permission.storage.request();
  return isSuccessPermission(status);
}

/// 检查相机权限
Future<bool> checkRequestCameraPermission() async {
  final status = await Permission.camera.status;
  return isSuccessPermission(status);
}

/// 检查相册权限
Future<bool> checkRequestPhotosPermission() async {
  final status = await Permission.photos.request();
  return isSuccessPermission(status);
}

/// 检查位置权限
Future<bool> checkRequestLocationPermission() async {
  final status = await Permission.location.request();
  return isSuccessPermission(status);
}

/// 检查相机权限
Future<bool> checkCameraPermission() async {
  final status = await Permission.camera.status;
  return isSuccessPermission(status);
}

/// 检查麦克风权限
Future<bool> checkMicrophonePermission() async {
  final status = await Permission.microphone.status;
  return isSuccessPermission(status);
}

Future<bool?> requestPermissions(
  Permission permission, {
  BuildContext? context,
  bool? isShowDescDialog = false,
  bool? isShowDeniedDialog = false,
  String? titleDesc = '',
  String? contentDesc = '',
  String? deniedDesc = '',
  String? settingContent = '',
}) async {
  final isDeniedPermissionResult = await permission.status;
  return isDeniedPermissionResult.isDenied || isDeniedPermissionResult.isPermanentlyDenied
      ? await requestPermissionResult(
          permission: permission,
          context: context,
          isShowDeniedDialog: isShowDeniedDialog,
          titleDesc: titleDesc,
          contentDesc: contentDesc,
          deniedDesc: deniedDesc,
          settingContent: settingContent,
        )
      : true;
}

bool isSuccessPermission(PermissionStatus status) {
  return status.isGranted || status.isLimited;
}

String getPermissionContent(
  Permission permission, {
  String? contentDesc,
}) {
  var content = '';
  switch (permission.value) {
    case 1:
      content = contentDesc ?? '请允许有朋获取你的相机权限，用于上传头像、确认个人形象和拍摄聚会情况';
      break;
    case 3:
      content = contentDesc ?? '请允许有朋获取你的地理位置权限，仅用于个人资料完善';
      break;
    case 7:
      content = contentDesc ?? '请允许有朋获取你的麦克风权限，仅用于确认声音状态、聚会聊天';
      break;
    case 9:
      content = contentDesc ?? '请允许有朋获取你的相册权限，仅用于上传头像、个人资料封面。';
      break;
    case 15:
      content = contentDesc ?? '请允许有朋获取你的存储权限，仅用于上传头像、个人资料封面与更新安装包';
      break;
  }
  return content;
}

String getPermissionTitle(
  Permission permission, {
  String? titleDesc,
  bool isFirstRequest = true,
}) {
  var title = '';
  switch (permission.value) {
    case 1:
      title = '相机';
      break;
    case 3:
      title = '位置';
      break;
    case 7:
      title = '麦克风';
      break;
    case 9:
      title = '相册';
      break;
    case 15:
      title = '存储权限';
      break;
  }
  return titleDesc ?? (isFirstRequest ? '“有朋”想访问你的$title' : '“有朋”需要访问你的$title');
}

String getPermissionSettingsContent(
  Permission permission, {
  String? contentDesc,
}) {
  var content = '';
  switch (permission.value) {
    case 1:
      content = contentDesc ?? '相机权限用于头像、确认个人形象和拍摄聚会情况，请允许有朋获取你的相机权限';
      break;
    case 3:
      content = contentDesc ?? '获取地理位置权限用于个人资料完善和动态补充，请允许有朋获取你的地理位置权限';
      break;
    case 7:
      content = contentDesc ?? '麦克风权限用于确认声音状态、聚会聊天，请允许有朋获取你的麦克风权限';
      break;
    case 9:
      content = contentDesc ?? '相册权限用于上传头像、个人资料封面，请允许有朋获取你的相册权限';
      break;
    case 15:
      content = contentDesc ?? '存储权限用于上传头像、个人资料封面与更新安装包，请允许有朋获取你的存储权限';
      break;
  }
  return content;
}

/// return值 nil代表拒绝且不去设置， false代表拒绝且去设置，true代表已经接受
Future<bool?> requestPermissionResult({
  BuildContext? context,
  required Permission permission,
  bool? isShowDeniedDialog = false,
  String? titleDesc,
  String? contentDesc,
  String? deniedDesc,
  String? settingContent,
}) async {
  // 非首次拒绝后，弹出权限说明

  final status = await permission.request();

  /// Android 禁止再次提示 去设置弹窗
  if (status == PermissionStatus.permanentlyDenied) {
    return await showPermissionDescDialog(
      context: context,
      title: titleDesc ?? getPermissionTitle(permission),
      content: getPermissionSettingsContent(
        permission,
        contentDesc: settingContent,
      ),
    );
  } else if (status == PermissionStatus.denied) {
    if (Platform.isIOS || deniedDesc == null || deniedDesc.isEmpty) {
      return await showPermissionDescDialog(
        context: context,
        title: titleDesc ?? getPermissionTitle(permission),
        content: getPermissionSettingsContent(
          permission,
          contentDesc: settingContent,
        ),
      );
    } else {
      Util.showToast(deniedDesc);
    }
  }
  return isSuccessPermission(status);
}

Future<bool?> showPermissionDescDialog({
  BuildContext? context,
  String? title,
  String? content,
}) async {
  // final ret = await showConfirmDialog(
  //   title: title,
  //   content: content ?? '',
  //   cancelText: '我再想想',
  //   confirmText: '立即打开',
  //   barrierDismissible: false,
  // );
  // if (ret == true) {
  //   unawaited(openAppSettings());
  //   return false;
  // }
  return null;
}
