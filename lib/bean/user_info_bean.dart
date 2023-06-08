class UserInfoBean {
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
  bool? password;
  int? ctime;
  String? remarks;
  String? gradeName;

  UserInfoBean(
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
        this.password,
        this.ctime,
        this.remarks,
        this.gradeName});

  UserInfoBean.fromJson(Map<String, dynamic> json) {
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
    password = json['password'];
    ctime = json['ctime'];
    remarks = json['remarks'];
    gradeName = json['grade_name'];
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
    data['password'] = this.password;
    data['ctime'] = this.ctime;
    data['remarks'] = this.remarks;
    data['grade_name'] = this.gradeName;
    return data;
  }
}
