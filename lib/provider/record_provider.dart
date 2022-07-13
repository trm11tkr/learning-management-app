import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/entities/record.dart';

final recordProvider =
    StateNotifierProvider<RecordList, List<Record>>((_) => RecordList([
          Record(
            id: 'r1',
            materialId: '1',
            learningTime: 30,
            description: '15ページ進めた',
            createdAt: DateTime.now(),
          ),
        ]));

class RecordList extends StateNotifier<List<Record>> {
  RecordList([List<Record>? initialRecords]) : super(initialRecords ?? []);

  // 追加
  void add({required String materialId, required int learningTime, String? description}) {
    state = [
      ...state,
      Record(
          id: DateTime.now().toString(),
          materialId: materialId,
          learningTime: learningTime,
          description: description,
          createdAt: DateTime.now())
    ];
  }

  // 編集
  void edit(
      {required String recordId,
      String? materialId,
      int? learningTime,
      String? description}) {
    state = [
      for (final record in state)
        if (record.id == recordId)
          record.copyWith(
            materialId: materialId ?? record.materialId,
            learningTime: learningTime ?? record.learningTime,
            description: description ?? record.description,
          )
        else
          record,
    ];
  }

  // 削除
  void remove(String id) {
    state = state.where((record) => record.id != id).toList();
  }

  // 教材と紐づく学習記録を削除
  void removeByMaterialId(String materialId) {
    state = state.where((record) => record.materialId != materialId).toList();
  }
}
