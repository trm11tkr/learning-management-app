import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/date_time_timestamp_converter.dart';

part 'material.freezed.dart';
part 'material.g.dart';

@freezed
class MaterialData with _$MaterialData {
  const factory MaterialData({
    required String id,
    required String title,
    @DateTimeTimestampConverter() required DateTime createdAt,
    String? imageUrl,
  }) = _MaterialData;

  factory MaterialData.fromJson(Map<String, dynamic> json) =>
      _$MaterialDataFromJson(json);
}
