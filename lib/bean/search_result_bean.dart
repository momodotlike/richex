class SearchResultBean {
  int? id;
  String? name;
  String? price;
  String? imageId;
  int? typeId;
  int? status;
  int? isRecommend;
  int? isHot;
  String? imgUrl;

  SearchResultBean(
      {this.id,
        this.name,
        this.price,
        this.imageId,
        this.typeId,
        this.status,
        this.isRecommend,
        this.isHot,
        this.imgUrl});

  SearchResultBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imageId = json['image_id'];
    typeId = json['type_id'];
    status = json['status'];
    isRecommend = json['is_recommend'];
    isHot = json['is_hot'];
    imgUrl = json['img_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image_id'] = this.imageId;
    data['type_id'] = this.typeId;
    data['status'] = this.status;
    data['is_recommend'] = this.isRecommend;
    data['is_hot'] = this.isHot;
    data['img_url'] = this.imgUrl;
    return data;
  }
}
