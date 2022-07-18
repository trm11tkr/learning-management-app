import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../entities/record.dart';
import '../../../../exceptions/app_exception.dart';
import '../entities/material.dart';
import '../../utils/logger.dart';
import '../../extensions/exception_extension.dart';
import '../repositories/firestore/collection_repository.dart';
import '../repositories/firestore/collection_paging_repository.dart';
import '../repositories/firestore/document.dart';
import '../repositories/firestore/document_repository.dart';
import '../../results/result_void_data.dart';

final recordProvider =
    StateNotifierProvider<RecordController, List<Record>>((ref) {
  return RecordController(ref.read);
});

class RecordController extends StateNotifier<List<Record>> {
  RecordController(
    this._read,
  ) : super([]) {
    // final userId = _firebaseAuthRepository.loggedInUserId;
    // if (userId == null) {
    //   return;
    // }
    _collectionPagingRepository = _read(
      recordPagingProvider(
        CollectionParam<Record>(
          query: Document.colRef(
            Record.collectionPath('2'),
          ).orderBy('createdAt', descending: true),
          limit: 20,
          decode: Record.fromJson,
        ),
      ),
    );
  }

  final Reader _read;

  // FirebaseAuthRepository get _firebaseAuthRepository =>
  //     _read(firebaseAuthRepositoryProvider);

  DocumentRepository get _documentRepository =>
      _read(documentRepositoryProvider);

  CollectionPagingRepository<Record>? _collectionPagingRepository;

  /// 一覧取得
  /// ※状態はstateで管理するので関数の戻り値では返さない
  Future<ResultVoidData> fetch() async {
    try {
      final repository = _collectionPagingRepository;
      if (repository == null) {
        throw AppException.irregular();
      }
      final data = await repository.fetch(
        fromCache: (cache) {
          /// キャッシュから即時反映する
          state = cache.map((e) => e.entity).whereType<Record>().toList();
        },
      );
      state = data.map((e) => e.entity).whereType<Record>().toList();
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  /// ページング取得
  /// ※状態はstateで管理するので関数の戻り値では返さない
  Future<ResultVoidData> fetchMore() async {
    try {
      final repository = _collectionPagingRepository;
      if (repository == null) {
        throw AppException.irregular();
      }

      final data = await repository.fetchMore();
      if (data.isNotEmpty) {
        state = [
          ...state.toList(),
          ...data.map((e) => e.entity).whereType<Record>().toList(),
        ];
      }
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  /// 作成
  Future<ResultVoidData> create(
      String materialId, int learningTime, String? description) async {
    try {
      // final userId = _firebaseAuthRepository.loggedInUserId;
      final userId = '2';
      if (userId == null) {
        throw AppException(title: 'ログインしてください');
      }
      final ref = Document.docRef(Record.collectionPath(userId));
      final now = DateTime.now();
      final data = Record(
          id: ref.id,
          materialId: materialId,
          learningTime: learningTime,
          description: description,
          createdAt: now);
      await _documentRepository.save(Record.docPath(userId, ref.id),
          data: data.toCreateDoc);
      state = [data, ...state];
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  /// 更新
  Future<ResultVoidData> update(Record record) async {
    try {
      // final userId = _firebaseAuthRepository.loggedInUserId;
      final userId = '2';
      if (userId == null) {
        throw AppException(title: 'ログインしてください');
      }

      final docId = record.id;
      if (docId == null) {
        throw AppException.irregular();
      }

      await _documentRepository.update(
        Record.docPath(userId, docId),
        data: record.toUpdateDoc,
      );
      state = state
          .map(
            (e) => e.id == record.id ? record : e,
          )
          .toList();
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  /// 削除
  Future<ResultVoidData> remove(String docId) async {
    try {
      // final userId = _firebaseAuthRepository.loggedInUserId;
      final userId = '2';
      if (userId == null) {
        throw AppException(title: 'ログインしてください');
      }

      await _documentRepository.remove(Record.docPath(userId, docId));
      state = state
          .where(
            (e) => e.id != docId,
          )
          .toList();
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  // 教材と紐づく学習記録を削除
  Future<ResultVoidData> removeByMaterialId(String docId) async {
    try {
      // final userId = _firebaseAuthRepository.loggedInUserId;
      final userId = '2';
      if (userId == null) {
        throw AppException(title: 'ログインしてください');
      }

      await _documentRepository.remove(MaterialData.docPath(userId, docId));
      state = state
          .where(
            (e) => e.id != docId,
          )
          .toList();
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

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
}
