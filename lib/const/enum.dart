enum VerifyCodeType { reg, login, forgot, check }

enum AssetsType { bibi, fabi, heyue, zhucang }

enum AlertDialogType { cancel, confirm }

enum BbRecordType { recharge, withdraw, lock }

enum FbRecordType {
  all,
  buy,
  sell,
  into,
  rollOut,
}

enum OtcTradeType {
  buy,
  sell,
}

enum DelegateType { current, history }

// 账户类型
enum AccountType {
  bb, // 币币
  fb, // 法币
  qc, // 全仓
  zc // 逐仓
}
