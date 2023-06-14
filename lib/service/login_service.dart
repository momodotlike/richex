import 'package:flutter_rich_ex/api/dio_util.dart';
import 'package:flutter_rich_ex/bean/user_info_bean.dart';
import 'package:flutter_rich_ex/util/export.dart';

class LoginService {

  // 获取验证码
  static getVerifyCode(String account,String codeType) async{
    String url = API.baseUrl + 'm/mail/736d842d80de418cba2961e561da4779/9785/$account/$codeType?type=app';
    var res = await DioUtil.requestOld(url,isH5: true);
    return res;
  }

  // 注册
  static register(data) async{
    String url = API.baseUrl + 'm/member';
    var res = await DioUtil.requestOld(url,isH5: true,method: DioUtil.POST,data: data);
    return res;
  }

  // 登录前获取token
  static preLogin(params) async {
    String url = API.baseUrl + 'm/memberLogin';
    var res = await DioUtil.requestOld(url,data: params,isH5: true,method: DioUtil.POST);
    print('返回内容===$res');
    if (res !=null && res['state'] == 1) {
      var token = res['data'];
      if(token is String) {
        SpUtil.putBool(Constant.IS_LOGIN,false);
        SpUtil.putString(Constant.tokenPre, token);
        return true;
      }else {
        UserInfoBean info = UserInfoBean.fromJson(res['data']);
        SpUtil.putObject(Constant.userInfo, info);
        SpUtil.putString(Constant.contactToken, info.contactToken??'');
        SpUtil.putBool(Constant.IS_LOGIN, true);
        return true;
      }
    }
    return false;
  }

  // 最终的登录
  static login({required String code,required String account}) async {
    var token = SpUtil.getString(Constant.tokenPre,defValue: '');
    var url = API.baseUrl + 'm/login/verification/$account/$code?token=$token';
    try {
      var res = await DioUtil.requestOld(url,isH5: true);
      print('登录内容这里返回用户信息资料=====$res');
      if (res['state'] == 1) {
        UserInfoBean info = UserInfoBean.fromJson(res['data']);
        SpUtil.putObject(Constant.userInfo, info);
        SpUtil.putString(Constant.contactToken, info.contactToken??'');
        SpUtil.putBool(Constant.IS_LOGIN, true);
        return true;
      }else {
        return false;
      }
    }catch(e) {
      print('出错===$e');
      return false;
    }
  }
}