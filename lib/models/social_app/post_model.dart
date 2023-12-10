// ignore_for_file: camel_case_types

class PostModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  List<dynamic>? likesList;
  List<dynamic>? commentslist;

  PostModel({
    required this.name,
    required this.uId,
    required this.image,
    required this.dateTime,
    required this.text,
    required this.postImage,
    required this.likesList,
    required this.commentslist,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postImage = json['postImage'];
    likesList = json['likes'];
    commentslist = json['comment_section'];
  }

  Map<String, dynamic> toMap() {
    return {
      'comment_section': commentslist,
      'likes': likesList,
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage,
    };
  }
}

class likes {
  bool? like;
  likes({required this.like});
  likes.fromJson(Map<String, dynamic> json) {
    like = json['like'];
  }
}

class comment_section {
  String? comments;
  comment_section({required this.comments});
  comment_section.fromJson(Map<String, dynamic> json) {
    comments = json['comments'];
  }
}
