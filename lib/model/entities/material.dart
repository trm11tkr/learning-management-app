import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'material.freezed.dart';
part 'material.g.dart';


@freezed
class MaterialData with _$MaterialData {
  const factory MaterialData({
    required String id,
    required String title,
    required DateTime createdAt,
    String? imageUrl,
  }) = _MaterialData;

  factory MaterialData.fromJson(Map<String, dynamic> json) =>
      _$MaterialDataFromJson(json);
}