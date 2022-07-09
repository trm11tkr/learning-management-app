// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Material _$$_MaterialFromJson(Map<String, dynamic> json) => _$_Material(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      category: $enumDecodeNullable(_$CategoryEnumMap, json['category']),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$$_MaterialToJson(_$_Material instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt': instance.createdAt.toIso8601String(),
      'category': _$CategoryEnumMap[instance.category],
      'imageUrl': instance.imageUrl,
    };

const _$CategoryEnumMap = {
  Category.japanese: 'japanese',
  Category.mathematics: 'mathematics',
  Category.english: 'english',
  Category.science: 'science',
  Category.socialStudies: 'socialStudies',
  Category.other: 'other',
};
