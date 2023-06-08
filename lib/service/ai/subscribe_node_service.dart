import 'package:flutter_rich_ex/api/dio_util.dart';
import 'package:flutter_rich_ex/bean/invest_bean.dart';
import 'package:flutter_rich_ex/bean/node_detail_bean.dart';
import 'package:flutter_rich_ex/bean/subscribe_node_bean.dart';
import 'package:flutter_rich_ex/bean/user_info_bean.dart';
import 'package:flutter_rich_ex/util/export.dart';

class SubscribeNodeService {

  // 节点列表
  static getList() async{
    List<SubscribeNodeBean> beans = [];
    try {
      var res = await DioUtil.request(API.nodeList);
      print('res===$res');
      if(res !=null) {
        res.forEach((element) {
          SubscribeNodeBean bean = SubscribeNodeBean.fromJson(element);
          beans.add(bean);
        });
        return beans;
      }
      return beans;
    }catch(e) {
      print('报错了$e');
      return beans;
    }
  }

  // 节点购买列表
  static getBuyList(query) async{
    List<SubscribeNodeBean> beans = [];
    try {
      var res = await DioUtil.request(API.nodeBuyList,query: query);
      print('res===$res');
      if(res !=null) {
        res.forEach((element) {
          SubscribeNodeBean bean = SubscribeNodeBean.fromJson(element);
          beans.add(bean);
        });
        return beans;
      }
      return beans;
    }catch(e) {
      print('报错了$e');
      return beans;
    }
  }

  // 节点详情
  static getNodeDetail() async{
    try {
      var res = await DioUtil.request(API.nodeDetail);
      print('res===$res');
      if(res !=null) {
        NodeDetailBean bean = NodeDetailBean.fromJson(res);
        return bean;
      }
      return null;
    }catch(e) {
      print('报错了$e');
      return null;
    }
  }

  // 申请节点
  static applyNode(id) async{
    try {
      var res = await DioUtil.request(API.buyNode,query: {'jiedian_id': id},isH5: true,method: DioUtil.POST);
      if(res!=null && res['code'] == Constant.code200) {
        return true;
      }
      Util.showToast(res['msg']);
      return false;
    }catch(e) {
      print('报错了$e');
      return false;
    }
  }


}