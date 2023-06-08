import 'package:flutter_rich_ex/api/dio_util.dart';
import 'package:flutter_rich_ex/bean/aimine_team_bean.dart';
import 'package:flutter_rich_ex/bean/aimine_team_list_bean.dart';
import 'package:flutter_rich_ex/bean/invest_bean.dart';
import 'package:flutter_rich_ex/bean/user_info_bean.dart';
import 'package:flutter_rich_ex/util/export.dart';

class TeamService {

  // 团队详情
  static getDetail() async{
    try {
      var res = await DioUtil.request(API.mineTeam);
      print('res===$res');
      if(res !=null) {
        AiMineTeamBean bean = AiMineTeamBean.fromJson(res);
        return bean;
      }
      return null;
    }catch(e) {
      print('报错了getDetail$e');
      return null;
    }
  }

  // 团队明细
  static getTeamList(query) async{
    List<AiMineTeamListBean> list = [];
    try {
      var res = await DioUtil.request(API.mineTeamList,query: query);
      if(res !=null) {
        res.forEach((element) {
          AiMineTeamListBean bean = AiMineTeamListBean.fromJson(element);
          list.add(bean);
        });
        return list;
      }
      return list;
    }catch(e) {
      print('报错了$e');
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