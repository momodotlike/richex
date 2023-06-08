
import 'package:flutter_rich_ex/util/event_bus.dart';

/// The global [EventBus] object.
EventBus eventBus = EventBus();

class RefreshTaskBean {
  RefreshTaskBean();
}

enum GoodEventType { add, edit, delete }

class GoodEvent {
  GoodEventType type;
  Map? goodInfo;
  GoodEvent(this.type, this.goodInfo);
}

class UserEvent {}

class RefreshDrawer {}

// 主题切换刷新数据
class RefreshThemeEvent {

}

// 切换底部tab
class RefreshAiMineNavEvent {
  int? index;
  RefreshAiMineNavEvent({this.index});
}

// 刷新用户信息
class RefreshUserInfo {
  RefreshUserInfo();
}

// 切换主页tab引起的搜索栏显示问题
class RefreshSearchBar {
  RefreshSearchBar();
}

// 首页onResume检查剪切板
class RefreshBoardEvent {
  RefreshBoardEvent();
}

// 刷新购物车数量
class RefreshCartCountEvent {
  RefreshCartCountEvent();
}
// 刷新讯息tab
class RefreshMessageEvent {
  RefreshMessageEvent();
}

// 重新進入刷新首頁數據
class RefreshHomeDataEvent {
  RefreshHomeDataEvent();
}