class CheckModelBean {
  String? id;
  String? name;
  String? price;
  String? imageId;
  int? typeId;
  int? status;
  int? isHot;
  String? specId;
  String? imgUrl;
  String? attribute;

  CheckModelBean(
      {this.id,
        this.name,
        this.price,
        this.imageId,
        this.typeId,
        this.status,
        this.isHot,
        this.specId,
        this.imgUrl,
        this.attribute,
      });

  CheckModelBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imageId = json['image_id'];
    typeId = json['type_id'];
    status = json['status'];
    isHot = json['is_hot'];
    specId = json['spec_id'];
    imgUrl = json['img_url'];
    attribute = json['attribute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image_id'] = this.imageId;
    data['type_id'] = this.typeId;
    data['status'] = this.status;
    data['is_hot'] = this.isHot;
    data['spec_id'] = this.specId;
    data['img_url'] = this.imgUrl;
    data['attribute'] = this.attribute;
    return data;
  }
}

class ModelArgItems {
  int? specId;
  List<int>? specValueIds;

  ModelArgItems({this.specId, this.specValueIds});

  ModelArgItems.fromJson(Map<String, dynamic> json) {
    specId = json['spec_id'];
    specValueIds = json['spec_value_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['spec_id'] = this.specId;
    data['spec_value_ids'] = this.specValueIds;
    return data;
  }
}
