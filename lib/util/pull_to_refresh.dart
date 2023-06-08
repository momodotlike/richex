import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_rich_ex/widgets/my_custom_header.dart';

SmartRefresh({
  Key? key,
  RefreshHost? host,
  RefreshEcho? echo,
  RefreshController? controller,
  onRefresh,
  onLoading,
  child,
  header,
  footer,
  enablePullDown = true,
  enablePullUp = false,
  enableTwoLevel = false,
  onTwoLevel,
  dragStartBehavior,
  primary,
  cacheExtent,
  semanticChildCount,
  reverse,
  physics,
  scrollDirection,
  scrollController,
}) =>
    SmartRefresher(
      key: key,
//      controller: controller ?? host?.refreshCtrl,
      controller: controller ?? RefreshController(),
      onRefresh: onRefresh ?? (echo ?? host)?.onRefresh,
      onLoading: onLoading ?? (echo ?? host)?.onLoading,
      header: header ?? const MyCustomHeader(),
      footer: footer ?? const MyCustomFooter(),
      child: child,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      enableTwoLevel: enableTwoLevel,
      onTwoLevel: onTwoLevel,
      dragStartBehavior: dragStartBehavior,
      primary: primary,
      cacheExtent: cacheExtent,
      semanticChildCount: semanticChildCount,
      reverse: reverse,
      physics: physics,
      scrollDirection: scrollDirection,
      scrollController: scrollController,
    );

mixin RefreshEcho {
  void onRefresh() {}

  void onLoading() {}
}

mixin RefreshCtrl {
  void finishRefresh([RefreshState? state]) {}
}

mixin RefreshHost implements RefreshEcho, RefreshCtrl {
  final RefreshController _refreshCtrl = RefreshController();

  RefreshController? get refreshCtrl => _refreshCtrl;

  void onRefresh() {}

  void onLoading() {}

  void finishRefresh([RefreshState? state]) {
    if (state == null) {
      refreshCtrl?.refreshCompleted(resetFooterState: true);
      refreshCtrl?.loadComplete();
      return;
    }
    switch (state) {
      case RefreshState.done:
        refreshCtrl?.refreshCompleted(resetFooterState: true);
        break;
      case RefreshState.failed:
        refreshCtrl?.refreshFailed();
        break;
      case RefreshState.doneLoad:
        refreshCtrl?.loadComplete();
        break;
      case RefreshState.failedLoad:
        refreshCtrl?.loadFailed();
        break;
      case RefreshState.noDataLoad:
        refreshCtrl?.loadNoData();
        break;
    }
  }
}

enum RefreshState {
  done,
  failed,
  doneLoad,
  failedLoad,
  noDataLoad,
}
