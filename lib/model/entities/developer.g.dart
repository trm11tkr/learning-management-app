// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Developer _$$_DeveloperFromJson(Map<String, dynamic> json) => _$_Developer(
      developerId: json['developerId'] as String,
      name: json['name'] as String?,
      targetTime: json['targetTime'] as int? ?? 60,
      image: json['image'] == null
          ? null
          : StorageFile.fromJson(json['image'] as Map<String, dynamic>),
      numOfMaterials: json['numOfMaterials'] as int? ?? 0,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const DateTimeTimestampConverter().fromJson),
      updatedAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['updatedAt'], const DateTimeTimestampConverter().fromJson),
    );

Map<String, dynamic> _$$_DeveloperToJson(_$_Developer instance) =>
    <String, dynamic>{
      'developerId': instance.developerId,
      'name': instance.name,
      'targetTime': instance.targetTime,
      'image': instance.image,
      'numOfMaterials': instance.numOfMaterials,
      'createdAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.createdAt, const DateTimeTimestampConverter().toJson),
      'updatedAt': _$JsonConverterToJson<Timestamp, DateTime>(
          instance.updatedAt, const DateTimeTimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
