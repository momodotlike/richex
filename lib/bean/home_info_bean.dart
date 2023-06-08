import 'package:flutter_rich_ex/bean/eval_info_bean.dart';
import 'package:flutter_rich_ex/bean/store_info_bean.dart';

class HomeInfoBean {
  List<BannerInfo>? banner;
  List<EvalInfoBean>? recoveryList;
  List<StoreInfoBean>? stores;

  HomeInfoBean({this.banner, this.recoveryList, this.stores});

  HomeInfoBean.fromJson(Map<String, dynamic> json) {
    if (json['banner'] != null) {
      banner = [];
      json['banner'].forEach((v) {
        banner?.add( BannerInfo.fromJson(v));
      });
    }
    if (json['recovery_list'] != null) {
      recoveryList = [];
      json['recovery_list'].forEach((v) {
        recoveryList?.add(EvalInfoBean.fromJson(v));
      });
    }
    if (json['stores'] != null) {
      stores = [];
      json['stores'].forEach((v) {
        stores?.add(StoreInfoBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.banner != null) {
      data['banner'] = this.banner?.map((v) => v.toJson()).toList();
    }
    if (this.recoveryList != null) {
      data['recovery_list'] = this.recoveryList?.map((v) => v.toJson()).toList();
    }
    if (this.stores != null) {
      data['stores'] = this.stores?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerInfo {
  int? id;
  String? name;
  String? img;
  String? val;
  String? imgUrl;
  String? url;

  BannerInfo({this.id, this.name, this.img, this.val, this.imgUrl, this.url});

  BannerInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    val = json['val'];
    imgUrl = json['img_url'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['img'] = this.img;
    data['val'] = this.val;
    data['img_url'] = this.imgUrl;
    data['url'] = this.url;
    return data;
  }
}
