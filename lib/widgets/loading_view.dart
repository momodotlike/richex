import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingView {
  static final LoadingView singleton = LoadingView._();

  factory LoadingView() => singleton;

  LoadingView._();

  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  bool _isVisible = false;

  Future<T> wrap<T>({required Future<T> Function() asyncFunction}) async {
    show();
    T data;
    try {
      data = await asyncFunction();
    } on Exception catch (_) {
      rethrow;
    } finally {
      dismiss();
    }
    return data;
  }

  void show() async {
    if (_isVisible) return;
    _overlayState = Overlay.of(Get.overlayContext!);
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: const Center(
          child: SizedBox(
            width: 25.0,
            height: 25.0,
            child: CupertinoActivityIndicator(),
          ),
        ),
      ),
    );
    _isVisible = true;
    _overlayState?.insert(_overlayEntry!);
  }

  dismiss() async {
    if (!_isVisible) return;
    _isVisible = false;
    _overlayEntry?.remove();
  }
}
