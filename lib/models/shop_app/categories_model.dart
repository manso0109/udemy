import 'package:json_annotation/json_annotation.dart';

part 'categories_model.g.dart';

@JsonSerializable()
class Category {
  int? id;
  String? name;
  String? image;
  String? creationAt;
  String? updatedAt;
  Category({this.creationAt, this.id, this.image, this.name, this.updatedAt});
  factory Category.fromJson(Map<String, dynamic> json) {
    return _$CategoryFromJson(json);
  }
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
