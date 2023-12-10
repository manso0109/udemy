import 'package:flutter_application_1/models/shop_app/products_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'categories_list.g.dart';

@JsonSerializable()
class CategoryListModel {
  List<Category>? catData;
  CategoryListModel({this.catData});

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    return _$CategoryListModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$CategoryListModelToJson(this);
}
