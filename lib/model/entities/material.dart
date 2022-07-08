import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'material.freezed.dart';
part 'material.g.dart';

enum Category {
  japanese,
  mathematics,
  english,
  science,
  socialStudies,
  other,
}

@freezed
class Material with _$Material {
  const factory Material({
    required String title,
    required DateTime createdAt,
    Category? category,
    String? imageUrl,
  }) = _Material;

  factory Material.fromJson(Map<String, dynamic> json) =>
      _$MaterialFromJson(json);
}
