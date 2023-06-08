class ProductInfoBean {
  int? id;
  String? name;
  String? price;
  String? imageId;
  int? typeId;
  int? sort;
  int? status;
  int? isHot;
  String? specId;
  String? imgUrl;

  ProductInfoBean(
      {this.id,
        this.name,
        this.price,
        this.imageId,
        this.typeId,
        this.sort,
        this.status,
        this.isHot,
        this.specId,
        this.imgUrl});

  ProductInfoBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imageId = json['image_id'];
    typeId = json['type_id'];
    sort = json['sort'];
    status = json['status'];
    isHot = json['is_hot'];
    specId = json['spec_id'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image_id'] = this.imageId;
    data['type_id'] = this.typeId;
    data['sort'] = this.sort;
    data['status'] = this.status;
    data['is_hot'] = this.isHot;
    data['spec_id'] = this.specId;
    data['img_url'] = this.imgUrl;
    return data;
  }
}
