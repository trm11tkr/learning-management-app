// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Record _$$_RecordFromJson(Map<String, dynamic> json) => _$_Record(
      material: MaterialData.fromJson(json['material'] as Map<String, dynamic>),
      learningTime: json['learningTime'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$_RecordToJson(_$_Record instance) => <String, dynamic>{
      'material': instance.material,
      'learningTime': instance.learningTime,
      'description': instance.description,
      'createdAt': instance.createdAt.toIso8601String(),
    };
