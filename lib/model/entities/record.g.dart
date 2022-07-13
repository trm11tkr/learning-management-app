// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      id: json['id'] as String,
      materialId: json['materialId'] as String,
      learningTime: json['learningTime'] as int,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) => <String, dynamic>{
      'id': instance.id,
      'materialId': instance.materialId,
      'learningTime': instance.learningTime,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };
