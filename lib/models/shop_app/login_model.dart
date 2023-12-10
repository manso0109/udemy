class ShopLoginModel {
  int? id;
  String? email;
  String? password;
  String? token;
  String? role;
  String? name;
  String? avatar;

  ShopLoginModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    role = json['role'];
    password = json['password'];
    token = json['access_token'];
    name = json['name'];
    avatar = json['avatar'];
  }
  // ShopLoginModel({
  //   this.email,
  //   this.username,
  //   this.password,
  //   this.phone,
  //   this.token,
  // });
}
