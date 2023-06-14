import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_rich_ex/router/routes.dart';
import 'package:flutter_rich_ex/util/export.dart';

class DioUtil {

  static const String API_PREFIX = '';
  static const int CONNECT_TIMEOUT = 33000;
  static const int RECEIVE_TIMEOUT = 33000;

  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';

  static Future<dynamic> request(String url,{data, method,query,isH5}) async {
    data = data ?? {};

    method = method ?? 'GET';
    isH5 = isH5 ?? false;
    try{
      data.forEach((key, value) {
        if (url.contains(key)) {
          url = url.replaceAll(':$key', value.toString());
        }
      });
    }catch(e){
      print('requests params $data $query $url');
      data = data;
    }

    String token = SpUtil.getString(Constant.contactToken,defValue: '');
    String language = SpUtil.getString(Constant.language,defValue: 'en');
    print('当前token=====$token');
    if (token == null || token == "") {
      token = 'app';
    }
    String base64token = 'UEVQUEFFWF9UT0tFTg==';
    var headers = {
      'token': token,
      'loginsource': '',
      'longitude': '',
      'latitude': '',
      'ip': '',
      'language': language,
      'curtimestamp': '',
      'curtimestamp': '',
      String.fromCharCodes(base64Decode(base64token)):token,
    };

    BaseOptions option = BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        headers: headers,
        responseType: ResponseType.plain);
    Dio dio = Dio(option);
    var result;
    print('requests params $data $query $url');
    try {
      Response response;
      if(query!=null){
        Map<String,dynamic> queryParams = {};
        queryParams.addAll(query);
        response = await dio.request(url, queryParameters: queryParams,options:  Options(method: method));
      }else {
        response = await dio.request(url, data: data,options:  Options(method: method));
      }

      print('dioUtil 请求，参数：${data}query: $query =url: $url');
      if(isH5) {
        return json.decode(response.data);
      }
      result = json.decode(response.data);
      int code = result['code']; // status: true 返回成功
      if(code == Constant.code200) {
        return result['data'];
      }else if(code == Constant.code401) {
        Util.showToast(result['msg']);
        RouteUtil.cleanUserInfo();
        return null;
      }else {
        Util.showToast(result['msg']);
        return null;
      }
    } on DioError catch (e) {
      Util.showToast('net error');
      print('错误信息:$url ---- $e');
      if(e == DioErrorType.receiveTimeout) {
        Util.showToast('net timeout');
      }
      // var netBool = await RouteUtil.checkNetState();
      // if(!netBool) {
      //   await RouteUtil.showCheckNetDialog();
      // }
    }
    return result;
  }

  static Future<dynamic> requestOld(String url,{data, method,query,isH5}) async {
    data = data ?? {};

    method = method ?? 'GET';
    isH5 = isH5 ?? false;
    try{
      data.forEach((key, value) {
        if (url.contains(key)) {
          url = url.replaceAll(':$key', value.toString());
        }
      });
    }catch(e){
      print('requests params $data $query $url');
      data = data;
    }
    String token = SpUtil.getString(Constant.contactToken,defValue: '');
    String language = SpUtil.getString(Constant.language,defValue: 'en');
    if (token == null || token == "") {
      token = 'app';
    }
    String base64token = 'UEVQUEFFWF9UT0tFTg==';
    var headers = {
      'token': token,
      'loginsource': '',
      'longitude': '',
      'latitude': '',
      'ip': '',
      'language': language,
      'curtimestamp': '',
      String.fromCharCodes(base64Decode(base64token)):token,
    };
    BaseOptions option = BaseOptions(
        baseUrl: API_PREFIX,
        connectTimeout: CONNECT_TIMEOUT,
        receiveTimeout: RECEIVE_TIMEOUT,
        headers: headers,
        responseType: ResponseType.plain);
    Dio dio = Dio(option);
    var result;
    // var headers = {'token': "c80d1541b4fda19fdb1038369a546715",'loginsource': '','longitude': '','latitude': '','ip': '','curtimestamp': ''};
    print('requests params $data $query $url');
    try {
      Response response;
      if(query!=null){
        Map<String,dynamic> queryParams = {};
        queryParams.addAll(query);
        response = await dio.request(url, queryParameters: queryParams,options:  Options(method: method));
      }else {
        response = await dio.request(url, data: data,options:  Options(method: method));
      }

      print('dioUtil 请求，参数：${data}query: $query =url: $url');
      if(isH5) {
        return json.decode(response.data);
      }
      result = json.decode(response.data);
      int state = result['state']; // status: true 返回成功
      if(state == Constant.code1) {
        return result['data'];
      }else if(state == Constant.code401) {
        Util.showToast(result['msg']);
        RouteUtil.cleanUserInfo();
        return null;
      }else {
        Util.showToast(result['msg']);
        return null;
      }
    } on DioError catch (e) {
      Util.showToast('net error');
      if(e == DioErrorType.receiveTimeout) {
        Util.showToast('net timeout');
      }
      // var netBool = await RouteUtil.checkNetState();
      // if(!netBool) {
      //   await RouteUtil.showCheckNetDialog();
      // }
    }
    return result;
  }

  static Future postForm(String url,params,{String method = 'POST'}) async{
    var formData = FormData.fromMap(params);
    print('formData: $url ====${formData.toString()}');
    String token = SpUtil.getString(Constant.contactToken);
    var response = await Dio(BaseOptions(contentType: 'multipart/form-data', method: method,headers: {'Authorization': "Bearer $token",'Accept-Language': 'zh-cn'})).request(url, data: formData);
    print('rrrr$response');
    return response.data;
  }

  static Future postFile(String url,File file) async{
    if (file !=null) {
      print( 'filePath   ----------------------------------     $file    ');
      String filePath = file.path;
      var name = filePath.substring(filePath.lastIndexOf("/") + 1, filePath.length);
      print("postFile ----------------------------------       $filePath");
      print("postFile ----------------------------------               $name");
      String token = SpUtil.getString(Constant.token);
      Map<String ,dynamic> map = {};
      map["token"]= token;
      map["file"] = await MultipartFile.fromFile(file.path,filename: name);
      FormData formData = FormData.fromMap(map);
      var response = await  Dio(BaseOptions(contentType: 'multipart/form-data', method: 'POST')).request(url, data: formData);
      return response.data;
    }
  }

  // 下载apk
  static Future download(
      String url, {
        required String cachePath,
        CancelToken? cancelToken,
        Function(int count, int total)? onProgress,
      }) {
    return Dio().download(
      url,
      cachePath,
      cancelToken: cancelToken,
      onReceiveProgress: onProgress,
    );
  }

}





