import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'record.freezed.dart';
part 'record.g.dart';

@freezed
class Record with _$Record {
  const factory Record({
    required String id,
    required String materialId,
    required int learningTime,
    required String? description,
    required DateTime createdAt,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) =>
      _$RecordFromJson(json);
}
