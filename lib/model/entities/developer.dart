import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import './storage_file.dart';
import '../converters/date_time_timestamp_converter.dart';
import '../repositories/firestore/document.dart';
import '../../extensions/date_extension.dart';

part 'developer.freezed.dart';
part 'developer.g.dart';

@freezed
class Developer with _$Developer {
  const factory Developer({
    required String developerId,
    String? name,
    @Default(60) int? targetTime,
    StorageFile? image,
    @Default(0) int? numOfMaterials,
    @DateTimeTimestampConverter() DateTime? createdAt,
    @DateTimeTimestampConverter() DateTime? updatedAt,
  }) = _Developer;
  const Developer._();

  factory Developer.fromJson(Map<String, dynamic> json) =>
      _$DeveloperFromJson(json);

  static String get collectionPath => 'learning-management/v1/developers';
  static CollectionReference<SnapType> colRef() =>
      Document.colRef(collectionPath);

  static String docPath(String id) => '$collectionPath/$id';
  static DocumentReference<SnapType> docRef(String id) =>
      Document.docRefWithDocPath(docPath(id));

  static String imagePath(
    String id,
    String filename,
  ) =>
      '${docPath(id)}/image/$filename';

  String get dataLabel {
    return createdAt?.format(pattern: 'yyyy/M/d') ?? '-';
  }

  Map<String, dynamic> get toDocWithNotImage {
    final data = <String, dynamic>{
      ...toJson(),
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }..remove('image');
    return data;
  }

  Map<String, dynamic> get toImageOnly => <String, dynamic>{
        'developerId': developerId,
        'image': image?.toJson(),
        'createdAt': createdAt ?? FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}
