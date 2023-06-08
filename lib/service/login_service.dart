import 'package:flutter_rich_ex/api/dio_util.dart';
import 'package:flutter_rich_ex/util/export.dart';

class LoginService {

  // 账号密码登录
  static accountLogin(data) async{
    try {
      var res = await DioUtil.requestOld(API.PHONE_LOGIN,data: data,method: DioUtil.POST, isH5: true);
      print('res===$res');
      if(res !=null && res['state'] == Constant.code1) {
        print('res===$res');
        SpUtil.putString(Constant.token, res['data']);
        return true;
      }
      return false;
    }catch(e) {
      print('报错了$e');
      return false;
    }
  }

  // 发送验证码
  static sendCode({String? name,String? from}) async{
    try {
      var res = await DioUtil.requestOld(API.SEND_SMS + '$name' + '/$from', isH5: true);
      print('res===$res');
      return false;
    }catch(e) {
      print('报错了$e');
      return false;
    }
  }

  // 账号密码注册
  static accountRegister(data) async{
    try {
      var res = await DioUtil.requestOld(API.REGISTER,data: data,method: DioUtil.POST, isH5: true);
      print('res===$res');
      if(res !=null && res['state'] == Constant.code1) {
        print('res===$res');
        SpUtil.putString(Constant.token, res['data']);
        return true;
      }
      return false;
    }catch(e) {
      print('报错了$e');
      return false;
    }
  }
}