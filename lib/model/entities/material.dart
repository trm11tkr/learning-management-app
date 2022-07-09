import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    required String id,
    required String title,
    required DateTime createdAt,
    Category? category,
    String? imageUrl,
  }) = _Material;

  factory Material.fromJson(Map<String, dynamic> json) =>
      _$MaterialFromJson(json);
}

class MaterialList extends StateNotifier<List<Material>> {
  MaterialList([List<Material>? initialMaterials]) : super(initialMaterials ?? []);

  // 追加
  void add(String title) {
    state = [
      ...state,
      Material(
        id: DateTime.now().toString(),
        title: title,
        createdAt: DateTime.now(),
      ),
    ];
  }

  // 編集
  void edit({required String materialId, required String title, String? imageUrl}) {
    state = [
      for (final material in state)
        if (material.id == materialId)
          material.copyWith(
            title: title,
            imageUrl: imageUrl,
          )
        else
          material,
    ];
  }

  // 削除
  void remove(Material target) {
    state = state.where((material) => material.id != target.id).toList();
  }
}
