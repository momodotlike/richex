import 'package:flutter_rich_ex/api/dio_util.dart';
import 'package:flutter_rich_ex/bean/user_info_bean.dart';
import 'package:flutter_rich_ex/util/export.dart';

class UserService {

  // 账号密码登录
  static loginPre(data) async{
    try {
      var res = await DioUtil.request(API.PRE_LOGIN,data: data);
      print('res===$res');
      if(res !=null) {
        SpUtil.putString(Constant.token, res);
      }
      return res !=null;
    }catch(e) {
      print('eee$e');
      return false;
    }
  }

  // 是否实名认证
  static isRealName() async{
    try {
      var res = await DioUtil.request(API.isRealName);
      print('res===$res');
      if(res !=null) {
        return res;
      }
      return null;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }
}