import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/date_time_timestamp_converter.dart';
import '.././converters/date_time_timestamp_converter.dart';
import '../../extensions/date_extension.dart';
import '../repositories/firestore/document.dart';
import 'storage_file.dart';

part 'material.freezed.dart';
part 'material.g.dart';

@freezed
class MaterialData with _$MaterialData {
  const factory MaterialData({
    required String id,
    required String title,
    @DateTimeTimestampConverter() required DateTime createdAt,
    StorageFile? image,
  }) = _MaterialData;
  const MaterialData._();

  factory MaterialData.fromJson(Map<String, dynamic> json) =>
      _$MaterialDataFromJson(json);

  static String collectionPath(String userId) =>
      'learning-management/v1/users/$userId/materials';

  static CollectionReference<SnapType> colRef(String userId) =>
      Document.colRef(collectionPath(userId));

  static String docPath(String userId, String id) =>
      '${collectionPath(userId)}/$id';

  static DocumentReference<SnapType> docRef(String userId, String id) =>
      Document.docRefWithDocPath(docPath(userId, id));

  static String imagePath(
    String id,
    String userId,
    String filename,
  ) =>
      '${docPath(userId, id)}/image/$filename';

  Map<String, dynamic> get toDocWithNotImage {
    final data = <String, dynamic>{
      ...toJson(),
    }..remove('image');
    return data;
  }

  Map<String, dynamic> get toImageOnly => <String, dynamic>{
        'id': id,
        'title': title,
        'createdAt': createdAt,
        'image': image?.toJson(),
      };

  String get dateLabel {
    return createdAt.format(pattern: 'yyyy.M.d HH:mm');
  }

}
