import 'package:flutter_rich_ex/api/dio_util.dart';
import 'package:flutter_rich_ex/util/export.dart';

class CommonService {

  // 协议相关
  static getHtmlContent(id) async {
    //205：用户服务协议；
    var url = API.baseUrl + '/n/news/$id';
    var htmlContent = '';
    try {
      var res = await DioUtil.requestOld(url,isH5: true);
      if (res['state'] == 1) {
        htmlContent = res["data"]["a_content_en"];
      }else {

      }
      return htmlContent;
    }catch(e) {
      print('出错===$e');
      return '';
    }
  }
}