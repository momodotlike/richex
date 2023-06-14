import 'package:flutter_rich_ex/api/dio_util.dart';
import 'package:flutter_rich_ex/bean/ai_mine_detail_bean.dart';
import 'package:flutter_rich_ex/bean/aic_bean.dart';
import 'package:flutter_rich_ex/bean/aimine_invest_his_bean.dart';
import 'package:flutter_rich_ex/bean/invest_bean.dart';
import 'package:flutter_rich_ex/bean/user_info_bean.dart';
import 'package:flutter_rich_ex/util/export.dart';

class AiAicService {

  // aic 详情
  static getAicDetail() async{
    try {
      var res = await DioUtil.request(API.aicDetail);
      if(res !=null) {
        AicBean bean = AicBean.fromJson(res);
        return bean;
      }
      return null;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }
  // ait详情
  static getAitDetail() async{
    try {
      var res = await DioUtil.request(API.aitDetail);
      print('ait返回内容');
      return res;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }

  // ait 账单明细
  static getAitList(query) async{
    try {
      var res = await DioUtil.request(API.aitList,query: query);
      return res;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }
  // aic 账单明细
  static getAicList(query) async{
    try {
      var res = await DioUtil.request(API.aicAccountList,query: query);
      return res;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }

  // 销毁ait
  static destroyAIT(query) async{
    try {
      var res = await DioUtil.request(API.destroyAIT,query: query,method: DioUtil.POST,isH5: true);
      return res;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }

  // aic图标信息
  static aicRank(query) async{
    try {
      var res = await DioUtil.request(API.aicPriceRank,query: query,isH5: true);
      return res;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }



}