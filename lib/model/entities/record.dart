import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/date_time_timestamp_converter.dart';
import '../repositories/firestore/docment.dart';
import '../../extensions/date_extension.dart';

part 'record.freezed.dart';
part 'record.g.dart';

@freezed
class Record with _$Record {
  const factory Record({
    required String id,
    required String materialId,
    required int learningTime,
    required String? description,
    @DateTimeTimestampConverter() required DateTime createdAt,
  }) = _Record;
  const Record._();

  factory Record.fromJson(Map<String, dynamic> json) => _$RecordFromJson(json);

  static String collectionPath(String userId) =>
      'learning-management/v1/users/$userId/records';

  static CollectionReference<SnapType> colRef(String userId) =>
      Document.colRef(collectionPath(userId));

  static String docPath(String userId, String id) =>
      '${collectionPath(userId)}/$id';

  static DocumentReference<SnapType> docRef(String userId, String id) =>
      Document.docRefWithDocPath(docPath(userId, id));

  Map<String, dynamic> get toCreateDoc => <String, dynamic>{
        'id': id,
        'materialId': materialId,
        'learningTime': learningTime,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      };

  Map<String, dynamic> get toUpdateDoc => <String, dynamic>{
        'materialId': materialId,
        'learningTime': learningTime,
        'description': description,
      };

  String get dateLabel {
    return createdAt.format(pattern: 'yyyy.M.d HH:mm');
  }
}
