import 'package:flutter_rich_ex/api/dio_util.dart';
import 'package:flutter_rich_ex/bean/ai_mine_detail_bean.dart';
import 'package:flutter_rich_ex/bean/aimine_invest_his_bean.dart';
import 'package:flutter_rich_ex/bean/invest_bean.dart';
import 'package:flutter_rich_ex/bean/user_info_bean.dart';
import 'package:flutter_rich_ex/util/export.dart';
import 'package:get/get.dart';

class AiMineService {

  // 详情
  static getDetail() async{

    var res = await DioUtil.request(API.mineDetail);
    print('res===$res');
    if(res !=null) {
      AiMineDetailBean bean = AiMineDetailBean.fromJson(res);
      return bean;
    }
    return null;

    // try {
    //   var res = await DioUtil.request(API.mineDetail);
    //   print('res===$res');
    //   if(res !=null) {
    //     AiMineDetailBean bean = AiMineDetailBean.fromJson(res);
    //     return bean;
    //   }
    //   return null;
    // }catch(e) {
    //   print('报错了$e');
    //   return null;
    // }
  }

  // 投资记录
  static getHistoryList(query) async{
    List<AiMineInvestHisBean> hisList = [];
    try {
      var res = await DioUtil.request(API.mineInvestHistory,query: query);
      print('reee$res');
      if(res !=null) {
        res.forEach((element) {
          AiMineInvestHisBean bean = AiMineInvestHisBean.fromJson(element);
          hisList.add(bean);
        });
        return hisList;
      }
    }catch(e) {
      print('e===出错$e');
      return hisList;
    }
  }

  // 各类收益列表
  static getTypeList(type,query) async{
    var url;
    if(type == '推荐收益'.tr) {
      url = API.feeCate1;
    }else if(type == '分红收益'.tr) {
      url = API.feeCate2;
    }else if(type == '租赁收益'.tr) {
      url = API.feeCate3;
    }else if(type == '节点收益'.tr) {
      url = API.feeCate4;
    }else if(type == '分享收益'.tr) {
      url = API.feeCate5;
    }else if(type == '团队收益'.tr) {
      url = API.feeCate6;
    }

    List<DetailListBean> list = [];
    try {
      var res = await DioUtil.request(url,query: query);
      if(res !=null) {
        res.forEach((element) {
          DetailListBean bean = DetailListBean.fromJson(element);
          list.add(bean);
        });
      }
      return list;
    }catch(e) {
      print('出错了=$e');
      return list;
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