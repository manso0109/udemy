class SocialUserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;

  SocialUserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.uId,
      required this.image,
      required this.cover,
      required this.bio,
      required this.isEmailVerified});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    bio = json['bio'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'cover': cover,
      'name': name,
      'phone': phone,
      'uId': uId,
      'bio': bio,
      'image': image,
      'isEmailVerified': isEmailVerified
    };
  }
}
