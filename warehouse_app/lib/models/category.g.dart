// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      code: json['code'] as int,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
    };

CategoryCreateDTO _$CategoryCreateDTOFromJson(Map<String, dynamic> json) =>
    CategoryCreateDTO(
      name: json['nome'] as String,
    );

Map<String, dynamic> _$CategoryCreateDTOToJson(CategoryCreateDTO instance) =>
    <String, dynamic>{
      'nome': instance.name,
    };
