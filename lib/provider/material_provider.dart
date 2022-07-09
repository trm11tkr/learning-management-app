import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/entities/material.dart';



final materialProvider =
    StateNotifierProvider<MaterialList, List<MaterialData>>((_) => MaterialList(
      [
        MaterialData(id: '1', title: 'test1', createdAt: DateTime.now(), category: CategoryData.japanese),
        MaterialData(id: '2', title: 'test2', createdAt: DateTime.now(), category: CategoryData.mathematics),
        MaterialData(id: '3', title: 'test3', createdAt: DateTime.now(), category: CategoryData.science),
        MaterialData(id: '4', title: 'test4', createdAt: DateTime.now(), category: CategoryData.english),
      ]
    ));

class MaterialList extends StateNotifier<List<MaterialData>> {
  MaterialList([List<MaterialData>? initialMaterials]) : super(initialMaterials ?? []);

  // 追加
  void add(String title) {
    state = [
      ...state,
      MaterialData(
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
  void remove(MaterialData target) {
    state = state.where((material) => material.id != target.id).toList();
  }
}
