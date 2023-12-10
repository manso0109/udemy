import 'package:flutter_application_1/models/shop_app/products_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_search_model.g.dart';

@JsonSerializable()
class ListSearchModel {
  List<ProductsModel>? data;
  ListSearchModel({this.data});

  factory ListSearchModel.fromJson(Map<String, dynamic> json) {
    return _$ListSearchModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ListSearchModelToJson(this);
}
