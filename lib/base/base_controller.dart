import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController with WidgetsBindingObserver{


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('当前生命周期==== $state');
    switch (state) {
      case AppLifecycleState.resumed:
        // onResumed();
        break;
      case AppLifecycleState.inactive:
        // onInactive();
        break;
      case AppLifecycleState.paused:
        // onPaused();
        break;
      case AppLifecycleState.detached:
        // onDetached();
        break;
    }
  }

  // void onResumed();
  //
  // void onPaused();
  //
  // void onInactive();
  //
  // void onDetached();

}
