import 'package:flutter_rich_ex/api/dio_util.dart';
import 'package:flutter_rich_ex/util/export.dart';

class AiQuickExService {

  // 记录
  static getHistory(query) async{
    try {
      var res = await DioUtil.request(API.exchangeList,query: query);
      print('返回内容===$res');
      return res;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }
  // 详情
  static getDetail() async{
    try {
      var res = await DioUtil.request(API.exchangeDetail);
      print('返回内容===$res');
      return res;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }
  // 闪兑操作
  static exchangeAction(query) async{
    try {
      var res = await DioUtil.request(API.exchangeAction,query: query,method: DioUtil.POST,isH5: true);
      print('返回内容===$res');
      return res;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }
}