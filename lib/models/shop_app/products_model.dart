import 'package:json_annotation/json_annotation.dart';

part 'products_model.g.dart';

@JsonSerializable()
class ProductsModel {
  int? id;
  String? title;
  int? price;
  String? description;
  List<dynamic>? images;
  String? creationAt;
  String? updatedAt;
  Category? category;
  ProductsModel(
      {this.category,
      this.creationAt,
      this.description,
      this.id,
      this.images,
      this.price,
      this.title,
      this.updatedAt});

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return _$ProductsModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}

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
