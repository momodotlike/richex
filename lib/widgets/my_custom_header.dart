import 'package:flutter/material.dart'
    hide RefreshIndicator, RefreshIndicatorState;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// direction that icon should place to the text
enum IconPosition { left, right, top, bottom }

/// wrap child in outside,mostly use in add background color and padding
typedef Widget OuterBuilder(Widget child);

///the most common indicator,combine with a text and a icon
///
/// See also:
///
/// [MyCustomFooter]
class MyCustomHeader extends RefreshIndicator {
  final OuterBuilder? outerBuilder;

  final String? releaseText,
      idleText,
      refreshingText,
      completeText,
      failedText,
      canTwoLevelText;

  final Widget? releaseIcon,
      idleIcon,
      refreshingIcon,
      completeIcon,
      failedIcon,
      canTwoLevelIcon,
      twoLevelView;

  /// icon and text middle margin
  final double spacing;
  final IconPosition iconPos;

  final TextStyle textStyle;

  const MyCustomHeader({
    Key? key,
    RefreshStyle refreshStyle: RefreshStyle.Follow,
    double height: 80.0,
    Duration completeDuration: const Duration(milliseconds: 600),
    this.outerBuilder,
    this.textStyle: const TextStyle(color: Colors.grey),
    this.releaseText,
    this.refreshingText,
    this.canTwoLevelIcon,
    this.twoLevelView,
    this.canTwoLevelText,
    this.completeText,
    this.failedText,
    this.idleText,
    this.iconPos: IconPosition.left,
    this.spacing: 15.0,
    this.refreshingIcon,
    this.failedIcon: const Icon(Icons.error, color: Colors.grey),
    this.completeIcon: const SizedBox(width: 25.0, height: 25.0, child: CupertinoActivityIndicator()),
    this.idleIcon = const Icon(Icons.arrow_downward, color: Colors.grey),
    this.releaseIcon = const Icon(Icons.arrow_upward, color: Colors.grey),
  }) : super(
          key: key,
          refreshStyle: refreshStyle,
          completeDuration: completeDuration,
          height: height,
        );

  @override
  State createState() {
    // TODO: implement createState
    return _MyCustomHeaderState();
  }
}

class _MyCustomHeaderState extends RefreshIndicatorState<MyCustomHeader> {
  Widget _buildText(mode) {
    RefreshString strings =
        RefreshLocalizations.of(context)?.currentLocalization ??
            EnRefreshString();
    return Text(
        mode == RefreshStatus.canRefresh
            ? widget.releaseText ?? '松开立即刷新'.tr
            : mode == RefreshStatus.completed
                ? widget.completeText ?? '刷新完成'.tr
                : mode == RefreshStatus.failed
                    ? widget.failedText ?? '刷新失败，请重试'.tr
                    : mode == RefreshStatus.refreshing
                        ? widget.refreshingText ?? '正在刷新数据中...'.tr
                        : mode == RefreshStatus.idle
                            ? widget.idleText ?? '下拉可刷新'.tr
                            : mode == RefreshStatus.canTwoLevel
                                ? widget.canTwoLevelText ??
                                    strings.canTwoLevelText!
                                : "",
        style: widget.textStyle);
  }

  Widget _buildIcon(mode) {
    Widget? icon = mode == RefreshStatus.canRefresh
        ? widget.releaseIcon
        : mode == RefreshStatus.idle
            ? widget.idleIcon
            : mode == RefreshStatus.completed
                ? widget.completeIcon
                : mode == RefreshStatus.failed
                    ? widget.failedIcon
                    : mode == RefreshStatus.canTwoLevel
                        ? widget.canTwoLevelIcon
                        : mode == RefreshStatus.canTwoLevel
                            ? widget.canTwoLevelIcon
                            : mode == RefreshStatus.refreshing
                                ? widget.refreshingIcon ??
                                    const SizedBox(
                                      width: 25.0,
                                      height: 25.0,
                                      child: CupertinoActivityIndicator(),
                                    )
                                : widget.twoLevelView;
    return icon ?? Container();
  }

  @override
  bool needReverseAll() {
    // TODO: implement needReverseAll
    return false;
  }

  @override
  Widget buildContent(BuildContext context, RefreshStatus? mode) {
    // TODO: implement buildContent
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);
    final hour = DateTime.now().hour;
    final minute = DateTime.now().minute;

   final hourStr = hour < 10 ? '0$hour' : hour.toString();
   final minuteStr = minute < 10 ? '0$minute' : minute.toString();

    final rootWidget = SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textWidget,
               Text('${'最後更新：今天'.tr}$hourStr:$minuteStr', style: const TextStyle(color: Colors.grey, fontSize: 13))
            ],
          )
        ],
      ),
    );

    List<Widget> children = <Widget>[rootWidget];

    final Widget container = Wrap(
      spacing: widget.spacing,
      textDirection: widget.iconPos == IconPosition.left
          ? TextDirection.ltr
          : TextDirection.rtl,
      direction: widget.iconPos == IconPosition.bottom ||
              widget.iconPos == IconPosition.top
          ? Axis.vertical
          : Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      verticalDirection: widget.iconPos == IconPosition.bottom
          ? VerticalDirection.up
          : VerticalDirection.down,
      alignment: WrapAlignment.center,
      children: children,
    );
    return widget.outerBuilder != null
        ? widget.outerBuilder!(container)
        : Container(
            child: Center(child: container),
            height: widget.height,
          );
  }
}

///the most common indicator,combine with a text and a icon
///
// See also:
//
// [MyCustomHeader]
class MyCustomFooter extends LoadIndicator {
  final String? idleText, loadingText, noDataText, failedText, canLoadingText;

  /// a builder for re wrap child,If you need to change the boxExtent or background,padding etc.you need outerBuilder to reWrap child
  /// example:
  /// ```dart
  /// outerBuilder:(child){
  ///    return Container(
  ///       color:Colors.red,
  ///       child:child
  ///    );
  /// }
  /// ````
  /// In this example,it will help to add backgroundColor in indicator
  final OuterBuilder? outerBuilder;

  final Widget? idleIcon, loadingIcon, noMoreIcon, failedIcon, canLoadingIcon;

  /// icon and text middle margin
  final double spacing;

  final IconPosition iconPos;

  final TextStyle textStyle;

  /// notice that ,this attrs only works for LoadStyle.ShowWhenLoading
  final Duration completeDuration;

  const MyCustomFooter({
    Key? key,
    VoidCallback? onClick,
    LoadStyle loadStyle: LoadStyle.ShowAlways,
    double height: 60.0,
    this.outerBuilder,
    this.textStyle: const TextStyle(color: Colors.grey),
    this.loadingText,
    this.noDataText,
    this.noMoreIcon,
    this.idleText,
    this.failedText,
    this.canLoadingText,
    this.failedIcon: const Icon(Icons.error, color: Colors.grey),
    this.iconPos: IconPosition.left,
    this.spacing: 15.0,
    this.completeDuration: const Duration(milliseconds: 300),
    this.loadingIcon,
    this.canLoadingIcon: const Icon(Icons.arrow_downward, color: Colors.grey),
    this.idleIcon = const Icon(Icons.arrow_upward, color: Colors.grey),
  }) : super(
          key: key,
          loadStyle: loadStyle,
          height: height,
          onClick: onClick,
        );

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _MyCustomFooterState();
  }
}

class _MyCustomFooterState extends LoadIndicatorState<MyCustomFooter> {
  Widget _buildText(LoadStatus? mode) {
    RefreshString strings =
        RefreshLocalizations.of(context)?.currentLocalization ??
            EnRefreshString();
    return Text(
        mode == LoadStatus.loading
            ? widget.loadingText ?? '正在加载更多的数据...'.tr
            : LoadStatus.noMore == mode
                ? widget.noDataText ?? '已经全部加载完毕'.tr
                : LoadStatus.failed == mode
                    ? widget.failedText ?? '加载失败...'.tr
                    : LoadStatus.canLoading == mode
                        ? widget.canLoadingText ?? '松开立即加载更多'.tr
                        : widget.idleText ?? '上拉可以加载更多'.tr,
        style: widget.textStyle);
  }

  Widget _buildIcon(LoadStatus? mode) {
    Widget? icon = mode == LoadStatus.loading
        ? widget.loadingIcon ??
        const SizedBox(width: 25.0, height: 25.0, child: CupertinoActivityIndicator())
        : mode == LoadStatus.noMore
            ? widget.noMoreIcon
            : mode == LoadStatus.failed
                ? widget.failedIcon
                : mode == LoadStatus.canLoading
                    ? widget.canLoadingIcon
                    : widget.idleIcon;
    return icon ?? Container();
  }

  @override
  Future endLoading() {
    // TODO: implement endLoading
    return Future.delayed(widget.completeDuration);
  }

  @override
  Widget buildContent(BuildContext context, LoadStatus? mode) {
    Widget textWidget = _buildText(mode);
    Widget iconWidget = _buildIcon(mode);

    List<Widget> children = <Widget>[iconWidget, textWidget];

    final Widget container = Wrap(
      spacing: widget.spacing,
      textDirection: widget.iconPos == IconPosition.left
          ? TextDirection.ltr
          : TextDirection.rtl,
      direction: widget.iconPos == IconPosition.bottom ||
              widget.iconPos == IconPosition.top
          ? Axis.vertical
          : Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      verticalDirection: widget.iconPos == IconPosition.bottom
          ? VerticalDirection.up
          : VerticalDirection.down,
      alignment: WrapAlignment.center,
      children: children,
    );
    return widget.outerBuilder != null
        ? widget.outerBuilder!(container)
        : Container(
            height: widget.height,
            child: Center(
              child: container,
            ),
          );
  }
}
