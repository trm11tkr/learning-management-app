// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MaterialData _$$_MaterialDataFromJson(Map<String, dynamic> json) =>
    _$_MaterialData(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      category: $enumDecodeNullable(_$CategoryDataEnumMap, json['category']),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$_MaterialDataToJson(_$_MaterialData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
      'category': _$CategoryDataEnumMap[instance.category],
      'imageUrl': instance.imageUrl,
    };

const _$CategoryDataEnumMap = {
  CategoryData.japanese: 'japanese',
  CategoryData.mathematics: 'mathematics',
  CategoryData.english: 'english',
  CategoryData.science: 'science',
  CategoryData.socialStudies: 'socialStudies',
  CategoryData.other: 'other',
};
