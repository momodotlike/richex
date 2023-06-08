import 'package:flutter_rich_ex/api/dio_util.dart';
import 'package:flutter_rich_ex/bean/invest_bean.dart';
import 'package:flutter_rich_ex/bean/user_info_bean.dart';
import 'package:flutter_rich_ex/util/export.dart';

class InvestService {

  // 智能理财列表
  static getList() async{
    try {
      var res = await DioUtil.request(API.leaseList);
      print('res===$res');
      if(res !=null) {
        InvestBean bean = InvestBean.fromJson(res);
        return bean;
      }
      return null;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }

  // 理财详情
  static getDetail(id) async{
    try {
      var res = await DioUtil.request(API.leaseDetail,query: {'zulin_id': '$id'});
      print('res===$res');
      if(res !=null) {
        InvestBean bean = InvestBean.fromJson(res);
        print('ddddd${bean.zulin}');
        return bean;
      }
      return null;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }

  // 申购
  static subscribeAction(query) async{
    try {
      var res = await DioUtil.request(API.leaseDetail,query: query,isH5: true);
      if(res !=null && res['code'] == Constant.code200) {
        return true;
      }
      Util.showToast('${res['msg']??''}');
      return false;
    }catch(e) {
      print('报错了$e');
      return false;
    }
  }


}