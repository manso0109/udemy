// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListSearchModel _$ListSearchModelFromJson(Map<String, dynamic> json) =>
    ListSearchModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListSearchModelToJson(ListSearchModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
