class CategoryBean {
  int? id;
  int? parentId;
  String? name;
  int? typeId;
  String? imageId;
  int? status;
  List<GoodsChild>? child;
  List<GoodsList>? goodsList;
  String? imageUrl;

  CategoryBean(
      {this.id,
        this.parentId,
        this.name,
        this.typeId,
        this.imageId,
        this.status,
        this.child,
        this.goodsList,
        this.imageUrl});

  CategoryBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    typeId = json['type_id'];
    imageId = json['image_id'];
    status = json['status'];
    if (json['child'] != null) {
      child = [];
      json['child'].forEach((v) {
        child?.add(GoodsChild.fromJson(v));
      });
    }
    if (json['goods_list'] != null) {
      goodsList = [];
      json['goods_list'].forEach((v) {
        goodsList?.add(GoodsList.fromJson(v));
      });
    }
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['type_id'] = this.typeId;
    data['image_id'] = this.imageId;
    data['status'] = this.status;
    if (this.child != null) {
      data['child'] = this.child?.map((v) => v.toJson()).toList();
    }
    if (this.goodsList != null) {
      data['goods_list'] = this.goodsList?.map((v) => v.toJson()).toList();
    }
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class GoodsChild {
  int? id;
  int? parentId;
  String? name;
  int? typeId;
  int? sort;
  String? imageId;
  int? status;
  List<GoodsList>? goodsList;
  String? imageUrl;

  GoodsChild(
      {this.id,
        this.parentId,
        this.name,
        this.typeId,
        this.sort,
        this.imageId,
        this.status,
        this.goodsList,
        this.imageUrl});

  GoodsChild.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    typeId = json['type_id'];
    sort = json['sort'];
    imageId = json['image_id'];
    status = json['status'];
    if (json['goods_list'] != null) {
      goodsList = [];
      json['goods_list'].forEach((v) {
        goodsList?.add( GoodsList.fromJson(v));
      });
    }
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['name'] = this.name;
    data['type_id'] = this.typeId;
    data['sort'] = this.sort;
    data['image_id'] = this.imageId;
    data['status'] = this.status;
    if (this.goodsList != null) {
      data['goods_list'] = this.goodsList?.map((v) => v.toJson()).toList();
    }
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class GoodsList {
  int? id;
  String? name;
  String? price;
  String? otherPrice;
  int? categoryId;
  int? status;
  int? type;
  String? imgUrl;

  GoodsList(
      {this.id,
        this.name,
        this.price,
        this.otherPrice,
        this.categoryId,
        this.status,
        this.type,
        this.imgUrl});

  GoodsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    otherPrice = json['other_price'];
    categoryId = json['category_id'];
    status = json['status'];
    type = json['type'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['other_price'] = this.otherPrice;
    data['category_id'] = this.categoryId;
    data['status'] = this.status;
    data['type'] = this.type;
    data['img_url'] = this.imgUrl;
    return data;
  }
}
