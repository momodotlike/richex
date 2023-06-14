import 'package:flutter_rich_ex/router/route_auth_middleware.dart';
import 'package:flutter_rich_ex/ui/common/html_content_page.dart';
import 'package:flutter_rich_ex/ui/home/ai_money_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_asset_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_check_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_invite_history_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_mine_fee_history_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_mine_team_list_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_mine_team_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_mining_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_mining_secret_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_quick_ex_history_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_quick_exchange_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_rule_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_subscribe_apply_node_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_subscribe_node_page.dart';
import 'package:flutter_rich_ex/ui/home/aimoney/ai_subscribe_page.dart';
import 'package:flutter_rich_ex/ui/home/invite_friend_page.dart';
import 'package:flutter_rich_ex/ui/login/area_code_page.dart';
import 'package:flutter_rich_ex/ui/login/forget_pwd_page.dart';
import 'package:flutter_rich_ex/ui/login/login_page.dart';
import 'package:flutter_rich_ex/ui/login/register_page.dart';
import 'package:flutter_rich_ex/ui/main_page.dart';
import 'package:flutter_rich_ex/ui/splash_page.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.SPLASH;
  static final List<GetPage> routes = [

    // 启动页
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashPage(),
    ),

    // 登录页
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginPage(),
    ),

    // 首页
    GetPage(
      name: AppRoutes.MAIN,
      // middlewares: [RouteAuthMiddleware()],
      page: () => MainPage(),
    ),

    // 忘记密码
    GetPage(
      name: AppRoutes.FORGET_PWD,
      // middlewares: [RouteAuthMiddleware()],
      page: () => ForgetPwdPage(),
    ),
    // 忘记密码
    GetPage(
      name: AppRoutes.REGISTER,
      // middlewares: [RouteAuthMiddleware()],
      page: () => RegisterPage(),
    ),
    // 地区选项
    GetPage(
      name: AppRoutes.AREA_CODE,
      // middlewares: [RouteAuthMiddleware()],
      page: () => AreaCodePage(),
      fullscreenDialog: true,
    ),
    // ai理财
    GetPage(
      name: AppRoutes.AI_MONEY,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiMoneyPage(),
    ),
    // 申购
    GetPage(
      name: AppRoutes.AI_SUBSCRIBE,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiSubscribePage(),
    ),
    // 节点列表
    GetPage(
      name: AppRoutes.AI_SUBSCRIBE_NODE,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiSubscribeNodePage(),
    ),
    // 申请节点
    GetPage(
      name: AppRoutes.AI_SUBSCRIBE_APPLY_NODE,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiSubscribeApplyNodePage(),
    ),
    // 闪兑
    GetPage(
      name: AppRoutes.AI_QUICK_EXCHANGE,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiQuickExchangePage(),
    ),
    // 闪兑记录
    GetPage(
      name: AppRoutes.AI_QUICK_EX_HISTORY,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiQuickExHistoryPage(),
    ),
    // AIC挖矿
    GetPage(
      name: AppRoutes.AI_MING,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiMingPage(),
    ),
    // 挖矿秘籍
    GetPage(
      name: AppRoutes.AI_MING_SECRET,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiMingSecretPage(),
    ),
    // aic账单
    GetPage(
      name: AppRoutes.AI_CHECK,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiCheckPage(),
    ),
    // ait 资产
    GetPage(
      name: AppRoutes.AI_ASSET,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiAssetPage(),
    ),
    // 我的团队
    GetPage(
      name: AppRoutes.AI_MINE_TEAM,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiMineTeamPage(),
    ),
    // ai理财-邀请记录
    GetPage(
      name: AppRoutes.AI_INVITE_HISTORY,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiInviteHistoryPage(),
    ),
    // 邀请好友-海报
    GetPage(
      name: AppRoutes.INVITE_FRIEND,
      middlewares: [RouteAuthMiddleware()],
      page: () => InviteFriendPage(),
    ),
    // 邀请好友-海报
    GetPage(
      name: AppRoutes.AI_RULE,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiRulePage(),
    ),
    // ai理财-我的-收益明细
    GetPage(
      name: AppRoutes.AI_MINE_FEE_LIST,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiMineFeeHistoryPage(),
    ),
    // ai理财-我的-收益明细
    GetPage(
      name: AppRoutes.AI_MINE_TEAM_LIST,
      middlewares: [RouteAuthMiddleware()],
      page: () => AiMineTeamListPage(),
    ),
    // h5内容
    GetPage(
      name: AppRoutes.HTML_CONTENT,
      page: () => HtmlContentPage(),
    ),

  ];

}
