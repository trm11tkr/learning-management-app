import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/entities/record.dart';

final recordProvider =
    StateNotifierProvider<RecordList, List<Record>>((ref) => RecordList([
          Record(
            id: 'r1',
            materialId: '1',
            learningTime: 30,
            description: '15ページ進めた',
            createdAt: DateTime.now(),
          ),
          Record(
            id: 'r2',
            materialId: '2',
            learningTime: 30,
            description: '15ページ進めた',
            createdAt: DateTime.now().subtract(const Duration(days: 1)),
          ),
          Record(
            id: 'r3',
            materialId: '3',
            learningTime: 30,
            description: '15ページ進めた',
            createdAt: DateTime.now().subtract(const Duration(days: 5)),
          ),
          Record(
            id: 'r4',
            materialId: '3',
            learningTime: 30,
            description: '15ページ進めた',
            createdAt: DateTime.now().subtract(const Duration(days: 5)),
          ),
        ]));

class RecordList extends StateNotifier<List<Record>> {
  RecordList([List<Record>? initialRecords]) : super(initialRecords ?? []);

  // idで検索
  dynamic getById({required String id}) {
    if (state.map((record) => record.id).toList().contains(id)) {
      return state.firstWhere((record) => record.id == id);
    }
    return null;
  }

  // 1週間分のデータを取得
  List<Record> get recentRecords {
    return state.where((record) {
      return record.createdAt.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  // 追加
  void add(
      {required String materialId,
      required int learningTime,
      String? description}) {
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
