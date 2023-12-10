import 'package:flutter_application_1/models/shop_app/products_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_model.g.dart';

@JsonSerializable()
class ListModel {
  List<ProductsModel>? data;
  ListModel({this.data});

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return _$ListModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ListModelToJson(this);
}
