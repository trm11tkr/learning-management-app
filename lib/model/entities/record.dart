import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import './material.dart';

part 'record.freezed.dart';
part 'record.g.dart';

@freezed
class Record with _$Record {
  const factory Record({
    required MaterialData material,
    required String learningTime,
    required String description,
    required DateTime createdAt,
  }) = _Record;

  factory Record.fromJson(Map<String, dynamic> json) =>
      _$RecordFromJson(json);
}
