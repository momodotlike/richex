class ArticleInfoBean {
  int? id;
  String? typeName;
  List<ArticleInfoChild>? child;

  ArticleInfoBean({this.id, this.typeName, this.child});

  ArticleInfoBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['type_name'];
    if (json['child'] != null) {
      child = [];
      json['child'].forEach((v) {
        child?.add(ArticleInfoChild.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['type_name'] = this.typeName;
    if (this.child != null) {
      data['child'] = this.child?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArticleInfoChild {
  int? id;
  String? title;
  String? cover;
  String? content;
  int? typeId;
  String? brief;

  ArticleInfoChild(
      {this.id,
        this.title,
        this.cover,
        this.content,
        this.typeId,
        this.brief});

  ArticleInfoChild.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    cover = json['cover'];
    content = json['content'];
    typeId = json['type_id'];
    brief = json['brief'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['cover'] = this.cover;
    data['content'] = this.content;
    data['type_id'] = this.typeId;
    data['brief'] = this.brief;
    return data;
  }
}
