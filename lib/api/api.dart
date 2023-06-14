class API {

  // 接口文档：https://www.fjex.io/api-doc/
  // 370998292@qq.com  5211314a
  // 理财接口文档
  // https://doc.walletim.pro/web/#/16/997
  // 测试域名：https://lcapitest.fjex.io
  // 测试token：c80d1541b4fda19fdb1038369a546715
  // 临时邮箱 https://temp-mail.org/zh  'feyoyi1055@ratedane.com';
  // 网页端注册： https://www.fjex.io/h5/#/mobile/registerPage?inviteCode=XLJBa0p5
  static const String baseUrl = 'https://www.fjex.pro/';

  // ai理财域名[暂时]
  // static const String baseNewUrl = 'https://testlcapi.fjex.pro';
  static const String baseNewUrl = 'https://testlcapi.fjex.pro';
  // static const String baseNewUrl = 'https://testlcapi.fjex.io';

  // 获取客服二维码
  static const String CHATCODE = '/au/customerService';
  // app更新信息
  static const String APP_UPDATE = '/au/info/{type}'; // type = 1 android 2 = ios

  static const String PRE_LOGIN = 'm/memberLogin'; // type = 1 android 2 = ios

  // static const String LOGIN = 'm/login/verification/$account/$code?token=$token'; // type = 1 android 2 = ios


  // ----------------------------- 登录 -------------------------
  // 账号密码登录
  static const String PHONE_LOGIN = baseUrl + '/m/memberLogin';
  // 验证码登录
  static const String ACC_CODE_LOGIN = baseUrl + '/m/memberLogin';
  // 发送邮件/手机验证码
  static const String SEND_SMS = baseUrl + '/m/mail/';
  // 注册
  static const String REGISTER = baseUrl + '/m/member';

  // ----------------------------- ai理财 -------------------------
  // 是否实名
  static const String isRealName = baseNewUrl + '/api/authflag';
  // 租赁列表
  static const String leaseList = baseNewUrl + '/api/licai/list';
  // 租赁详情
  static const String leaseDetail = baseNewUrl + '/api/licai/detail';
  // 订阅
  static const String subscribeLease = baseNewUrl + '/api/licai/subscribe';

  // 节点列表
  static const String nodeList = baseNewUrl + '/api/jiedian/list';
  // 节点详情
  static const String nodeDetail = baseNewUrl + '/api/jiedian/detail';
  // 购买节点
  static const String buyNode = baseNewUrl + '/api/jiedian/subscribe';
  // 节点购买列表
  static const String nodeBuyList = baseNewUrl + '/api/jiedian/node_buy_list';

  // ai理财-我的
  static const String mineDetail = baseNewUrl + '/api/my/detail';
  // ai理财-我的团队
  static const String mineTeam = baseNewUrl + '/api/team/detail';
  // 团队明细
  static const String mineTeamList = baseNewUrl + '/api/team/team_list';
  // ai-我的-投资记录
  static const String mineInvestHistory = baseNewUrl + '/api/my/touzi_list';
  //我的收益明细
  static const String feeCate1 = baseNewUrl + '/api/my/tuijian_list';
  static const String feeCate2 = baseNewUrl + '/api/my/weight_list';
  static const String feeCate3 = baseNewUrl + '/api/my/zulin_list';
  static const String feeCate4 = baseNewUrl + '/api/my/jiedian_list';
  static const String feeCate5 = baseNewUrl + '/api/my/share_list';
  static const String feeCate6 = baseNewUrl + '/api/my/team_list';

  // aic挖矿
  static const String aicDetail = baseNewUrl + '/api/wakuang/aic_detail';
  // ait详情 【顶部】
  static const String aitDetail = baseNewUrl + '/api/wakuang/ait_detail';
  static const String aitList = baseNewUrl + '/api/wakuang/ait_account_list';
  // aic 账单列表
  static const String aicAccountList = baseNewUrl + '/api/wakuang/aic_account_list';
  // aic价格涨幅图标内容
  static const String aicPriceRank = baseNewUrl + '/api/wakuang/aic_list';
  // 销毁ait
  static const String destroyAIT = baseNewUrl + '/api/wakuang/xiaohui';
  // 邀请列表
  static const String inviteList = baseNewUrl + '/api/team/zhitui_list';

  // 兑换
  static const String exchangeList = baseNewUrl + '/api/exchange/exchange_list';
  // 闪兑详情
  static const String exchangeDetail = baseNewUrl + '/api/exchange/detail';
  // 闪兑
  static const String exchangeAction = baseNewUrl + '/api/exchange/exchange';

}