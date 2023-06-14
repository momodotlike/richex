class UserInfoBean {
  int? id;
  String? uid;
  int? areaCode;
  String? mName;
  String? smsCode;
  String? smsCodeTime;
  String? mPwd;
  String? mSecurityPwd;
  String? regTime;
  String? lastLoginIp;
  String? lastLoginTime;
  String? lastModPwdTime;
  int? authGrade;
  int? mStatus;
  int? apiStatus;
  int? introduceMId;
  String? inviteCode;
  String? mNickName;
  String? googleAuthKey;
  String? validateCode;
  String? mNameHidden;
  String? googleAuthCode;
  String? oldGoogleAuthCode;
  String? tradeCommission;
  String? authToken;
  String? token;
  int? apiLimit;
  String? phone;
  String? contactToken;
  int? isValid;
  String? interStandard;

  UserInfoBean(
      {this.id,
        this.uid,
        this.areaCode,
        this.mName,
        this.smsCode,
        this.smsCodeTime,
        this.mPwd,
        this.mSecurityPwd,
        this.regTime,
        this.lastLoginIp,
        this.lastLoginTime,
        this.lastModPwdTime,
        this.authGrade,
        this.mStatus,
        this.apiStatus,
        this.introduceMId,
        this.inviteCode,
        this.mNickName,
        this.googleAuthKey,
        this.validateCode,
        this.mNameHidden,
        this.googleAuthCode,
        this.oldGoogleAuthCode,
        this.tradeCommission,
        this.authToken,
        this.token,
        this.apiLimit,
        this.phone,
        this.contactToken,
        this.isValid,
        this.interStandard});

  UserInfoBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    areaCode = json['area_code'];
    mName = json['m_name'];
    smsCode = json['sms_code'];
    smsCodeTime = json['sms_code_time'];
    mPwd = json['m_pwd'];
    mSecurityPwd = json['m_security_pwd'];
    regTime = json['reg_time'];
    lastLoginIp = json['last_login_ip'];
    lastLoginTime = json['last_login_time'];
    lastModPwdTime = json['last_mod_pwd_time'];
    authGrade = json['auth_grade'];
    mStatus = json['m_status'];
    apiStatus = json['api_status'];
    introduceMId = json['introduce_m_id'];
    inviteCode = json['invite_code'];
    mNickName = json['m_nick_name'];
    googleAuthKey = json['google_auth_key'];
    validateCode = json['validateCode'];
    mNameHidden = json['m_name_hidden'];
    googleAuthCode = json['google_auth_code'];
    oldGoogleAuthCode = json['old_google_auth_code'];
    tradeCommission = '${json['trade_commission']}';
    authToken = json['authToken'];
    token = json['token'];
    apiLimit = json['api_limit'];
    phone = json['phone'];
    contactToken = json['contactToken'];
    isValid = json['isValid'];
    interStandard = json['inter_standard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['area_code'] = this.areaCode;
    data['m_name'] = this.mName;
    data['sms_code'] = this.smsCode;
    data['sms_code_time'] = this.smsCodeTime;
    data['m_pwd'] = this.mPwd;
    data['m_security_pwd'] = this.mSecurityPwd;
    data['reg_time'] = this.regTime;
    data['last_login_ip'] = this.lastLoginIp;
    data['last_login_time'] = this.lastLoginTime;
    data['last_mod_pwd_time'] = this.lastModPwdTime;
    data['auth_grade'] = this.authGrade;
    data['m_status'] = this.mStatus;
    data['api_status'] = this.apiStatus;
    data['introduce_m_id'] = this.introduceMId;
    data['invite_code'] = this.inviteCode;
    data['m_nick_name'] = this.mNickName;
    data['google_auth_key'] = this.googleAuthKey;
    data['validateCode'] = this.validateCode;
    data['m_name_hidden'] = this.mNameHidden;
    data['google_auth_code'] = this.googleAuthCode;
    data['old_google_auth_code'] = this.oldGoogleAuthCode;
    data['trade_commission'] = this.tradeCommission;
    data['authToken'] = this.authToken;
    data['token'] = this.token;
    data['api_limit'] = this.apiLimit;
    data['phone'] = this.phone;
    data['contactToken'] = this.contactToken;
    data['isValid'] = this.isValid;
    data['inter_standard'] = this.interStandard;
    return data;
  }
}
