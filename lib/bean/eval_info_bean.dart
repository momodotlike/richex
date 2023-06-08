class EvalInfoBean {
  int? id;
  String? name;
  String? price;
  String? otherPrice;
  String? imageId;
  int? categoryId;
  int? isRecommend;
  int? isHot;
  int? type;
  String? imgUrl;
  List<EvalGoodsSpecList>? goodsSpecList;
  String? categoryName;

  EvalInfoBean(
      {this.id,
        this.name,
        this.price,
        this.otherPrice,
        this.imageId,
        this.categoryId,
        this.isRecommend,
        this.isHot,
        this.type,
        this.imgUrl,
        this.goodsSpecList,
        this.categoryName});

  EvalInfoBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    otherPrice = json['other_price'];
    imageId = json['image_id'];
    categoryId = json['category_id'];
    isRecommend = json['is_recommend'];
    isHot = json['is_hot'];
    type = json['type'];
    imgUrl = json['img_url'];
    if (json['goods_spec_list'] != null) {
      goodsSpecList = [];
      json['goods_spec_list'].forEach((v) {
        goodsSpecList?.add(EvalGoodsSpecList.fromJson(v));
      });
    }
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['other_price'] = this.otherPrice;
    data['image_id'] = this.imageId;
    data['category_id'] = this.categoryId;
    data['is_recommend'] = this.isRecommend;
    data['is_hot'] = this.isHot;
    data['type'] = this.type;
    data['img_url'] = this.imgUrl;
    if (this.goodsSpecList != null) {
      data['goods_spec_list'] =
          this.goodsSpecList?.map((v) => v.toJson()).toList();
    }
    data['category_name'] = this.categoryName;
    return data;
  }
}

class EvalGoodsSpecList {
  int? id;
  int? specConfigId;
  String? specName;
  int? specType;
  int? sort;
  int? goodsId;
  bool? showClick;
  List<EvalGoodsItems>? items;

  EvalGoodsSpecList(
      {this.id,
        this.specConfigId,
        this.specName,
        this.specType,
        this.sort,
        this.goodsId,
        this.showClick,
        this.items});

  EvalGoodsSpecList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specConfigId = json['spec_config_id'];
    specName = json['spec_name'];
    specType = json['spec_type'];
    sort = json['sort'];
    goodsId = json['goods_id'];
    showClick = json['showClick'] ?? false;
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(EvalGoodsItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['spec_config_id'] = this.specConfigId;
    data['spec_name'] = this.specName;
    data['spec_type'] = this.specType;
    data['sort'] = this.sort;
    data['goods_id'] = this.goodsId;
    data['showClick'] = this.showClick;
    if (this.items != null) {
      data['items'] = this.items?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EvalGoodsItems {
  int? specValueConfigId;
  int? specConfigId;
  int? specValueId;
  String? specValueName;
  int? sort;
  String? value;

  EvalGoodsItems(
      {this.specValueConfigId,
        this.specConfigId,
        this.specValueId,
        this.specValueName,
        this.sort,
        this.value});

  EvalGoodsItems.fromJson(Map<String, dynamic> json) {
    specValueConfigId = json['spec_value_config_id'];
    specConfigId = json['spec_config_id'];
    specValueId = json['spec_value_id'];
    specValueName = json['spec_value_name'];
    sort = json['sort'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spec_value_config_id'] = this.specValueConfigId;
    data['spec_config_id'] = this.specConfigId;
    data['spec_value_id'] = this.specValueId;
    data['spec_value_name'] = this.specValueName;
    data['sort'] = this.sort;
    data['value'] = this.value;
    return data;
  }
}
