// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      userId: json['userId'] as String? ?? '',
      name: json['name'] as String? ?? '',
      userImage: json['userImage'] as String? ?? '',
      targetTime: json['targetTime'] as int? ?? 60,
      numOfMaterials: json['numOfMaterials'] as int? ?? 0,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'userImage': instance.userImage,
      'targetTime': instance.targetTime,
      'numOfMaterials': instance.numOfMaterials,
    };
