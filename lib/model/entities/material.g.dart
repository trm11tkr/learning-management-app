// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MaterialData _$$_MaterialDataFromJson(Map<String, dynamic> json) =>
    _$_MaterialData(
      id: json['id'] as String,
      title: json['title'] as String,
      createdAt: const DateTimeTimestampConverter()
          .fromJson(json['createdAt'] as Timestamp),
      image: json['image'] == null
          ? null
          : StorageFile.fromJson(json['image'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_MaterialDataToJson(_$_MaterialData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'image': instance.image,
    };
