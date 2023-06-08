class OrderInfoBean {
  int? id;
  String? orderNo;
  int? type;
  String? mobile;
  int? userId;
  String? collectionAccountName;
  String? collectionAccount;
  String? estimatedPrice;
  String? payPrice;
  String? floatingPrice;
  int? isPay;
  int? isNew;
  int? payTime;
  int? orderStatus;
  int? recoverMethod;
  int? recoverAddressId;
  int? sellerId;
  String? customerRemark;
  String? sellerRemark;
  OrderInfoUser? user;
  String? isPayLabel;
  String? orderStatusLabel;
  List<OrderItemList>? itemList;
  OrderItems? items;

  OrderInfoBean(
      {this.id,
        this.orderNo,
        this.type,
        this.mobile,
        this.userId,
        this.collectionAccountName,
        this.collectionAccount,
        this.estimatedPrice,
        this.payPrice,
        this.floatingPrice,
        this.isPay,
        this.isNew,
        this.payTime,
        this.orderStatus,
        this.recoverMethod,
        this.recoverAddressId,
        this.sellerId,
        this.customerRemark,
        this.sellerRemark,
        this.user,
        this.isPayLabel,
        this.orderStatusLabel,
        this.items,
        this.itemList});

  OrderInfoBean.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    type = json['type'];
    mobile = json['mobile'];
    userId = json['user_id'];
    collectionAccountName = json['collection_account_name'];
    collectionAccount = json['collection_account'];
    estimatedPrice = json['estimated_price'];
    payPrice = json['pay_price'];
    floatingPrice = json['floating_price'];
    isPay = json['is_pay'];
    isNew = json['is_new'];
    payTime = json['pay_time'];
    orderStatus = json['order_status'];
    recoverMethod = json['recover_method'];
    recoverAddressId = json['recover_address_id'];
    sellerId = json['seller_id'];
    customerRemark = json['customer_remark'];
    sellerRemark = json['seller_remark'];
    user = json['user'] != null ? OrderInfoUser.fromJson(json['user']) : null;
    if (json['item_list'] != null) {
      itemList = <OrderItemList>[];
      json['item_list'].forEach((v) {
        itemList?.add(OrderItemList.fromJson(v));
      });
    }
    items = json['items'] != null ? OrderItems.fromJson(json['items']) : null;
    isPayLabel = json['is_pay_label'];
    orderStatusLabel = json['order_status_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['type'] = this.type;
    data['mobile'] = this.mobile;
    data['user_id'] = this.userId;
    data['collection_account_name'] = this.collectionAccountName;
    data['collection_account'] = this.collectionAccount;
    data['estimated_price'] = this.estimatedPrice;
    data['pay_price'] = this.payPrice;
    data['floating_price'] = this.floatingPrice;
    data['is_pay'] = this.isPay;
    data['is_new'] = this.isNew;
    data['pay_time'] = this.payTime;
    data['order_status'] = this.orderStatus;
    data['recover_method'] = this.recoverMethod;
    data['recover_address_id'] = this.recoverAddressId;
    data['seller_id'] = this.sellerId;
    data['customer_remark'] = this.customerRemark;
    data['seller_remark'] = this.sellerRemark;
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items?.toJson();
    }
    if (this.itemList != null) {
      data['item_list'] = this.itemList?.map((v) => v.toJson()).toList();
    }
    data['is_pay_label'] = this.isPayLabel;
    data['order_status_label'] = this.orderStatusLabel;
    return data;
  }
}

class OrderInfoUser {
  int? id;
  String? username;
  String? mobile;
  int? sex;
  String? birthday;
  String? avatar;
  String? nickname;
  String? balance;
  int? point;
  int? grade;
  int? status;
  int? pid;
  String? remarks;

  OrderInfoUser(
      {this.id,
        this.username,
        this.mobile,
        this.sex,
        this.birthday,
        this.avatar,
        this.nickname,
        this.balance,
        this.point,
        this.grade,
        this.status,
        this.pid,
        this.remarks});

  OrderInfoUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    mobile = json['mobile'];
    sex = json['sex'];
    birthday = json['birthday'];
    avatar = json['avatar'];
    nickname = json['nickname'];
    balance = json['balance'];
    point = json['point'];
    grade = json['grade'];
    status = json['status'];
    pid = json['pid'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['sex'] = this.sex;
    data['birthday'] = this.birthday;
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['balance'] = this.balance;
    data['point'] = this.point;
    data['grade'] = this.grade;
    data['status'] = this.status;
    data['pid'] = this.pid;
    data['remarks'] = this.remarks;
    return data;
  }
}

class OrderItemList {
  int? id;
  String? orderNo;
  int? goodsId;
  String? goodsName;
  String? image;
  int? specId;
  String? specName;
  int? specValueId;
  String? specValueName;
  String? estimatedPrice;
  int? num;

  OrderItemList(
      {this.id,
        this.orderNo,
        this.goodsId,
        this.goodsName,
        this.image,
        this.specId,
        this.specName,
        this.specValueId,
        this.specValueName,
        this.estimatedPrice,
        this.num});

  OrderItemList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    goodsId = json['goods_id'];
    goodsName = json['goods_name'];
    image = json['image'];
    specId = json['spec_id'];
    specName = json['spec_name'];
    specValueId = json['spec_value_id'];
    specValueName = json['spec_value_name'];
    estimatedPrice = json['estimated_price'];
    num = json['num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.orderNo;
    data['goods_id'] = this.goodsId;
    data['goods_name'] = this.goodsName;
    data['image'] = this.image;
    data['spec_id'] = this.specId;
    data['spec_name'] = this.specName;
    data['spec_value_id'] = this.specValueId;
    data['spec_value_name'] = this.specValueName;
    data['estimated_price'] = this.estimatedPrice;
    data['num'] = this.num;
    return data;
  }
}

class OrderItems {
  List<OrderItemSpec>? spec;

  OrderItems({this.spec});

  OrderItems.fromJson(Map<String, dynamic> json) {
    if (json['spec'] != null) {
      spec = [];
      json['spec'].forEach((v) {
        spec?.add(OrderItemSpec.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.spec != null) {
      data['spec'] = this.spec?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItemSpec {
  String? specName;
  int? specId;
  List<SpecValueItems>? specValueItems;

  OrderItemSpec({this.specName, this.specId, this.specValueItems});

  OrderItemSpec.fromJson(Map<String, dynamic> json) {
    specName = json['spec_name'];
    specId = json['spec_id'];
    if (json['spec_value_items'] != null) {
      specValueItems = [];
      json['spec_value_items'].forEach((v) {
        specValueItems?.add(new SpecValueItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spec_name'] = this.specName;
    data['spec_id'] = this.specId;
    if (this.specValueItems != null) {
      data['spec_value_items'] =
          this.specValueItems?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecValueItems {
  String? specValueName;
  int? specValueId;

  SpecValueItems({this.specValueName, this.specValueId});

  SpecValueItems.fromJson(Map<String, dynamic> json) {
    specValueName = json['spec_value_name'] ?? 'xxx';
    specValueId = json['spec_value_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spec_value_name'] = this.specValueName;
    data['spec_value_id'] = this.specValueId;
    return data;
  }
}


