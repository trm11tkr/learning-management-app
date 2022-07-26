import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../exceptions/app_exception.dart';
import '../../entities/material.dart';
import '../../../utils/logger.dart';
import '../../../extensions/exception_extension.dart';
import '../../repositories/firestore/collection_paging_repository.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firestore/document.dart';
import '../../repositories/firestore/document_repository.dart';
import '../../../results/result_void_data.dart';
import '../../../results/result_data.dart';
import '../../../utils/provider.dart';

final materialDataProvider =
    StateNotifierProvider<MaterialDataController, List<MaterialData>>((ref) {
  ref.watch(authStateProvider);
  return MaterialDataController(ref.read);
});

class MaterialDataController extends StateNotifier<List<MaterialData>> {
  MaterialDataController(
    this._read,
  ) : super([]) {
    final userId = _firebaseAuthRepository.loggedInUserId;
    if (userId == null) {
      return;
    }
    _collectionPagingRepository = _read(
      materialDataPagingProvider(
        CollectionParam<MaterialData>(
          query: Document.colRef(
            MaterialData.collectionPath(userId),
          ).orderBy('createdAt', descending: true),
          limit: 20,
          decode: MaterialData.fromJson,
        ),
      ),
    );
  }

  final Reader _read;

  FirebaseAuthRepository get _firebaseAuthRepository =>
      _read(firebaseAuthRepositoryProvider);

  DocumentRepository get _documentRepository =>
      _read(documentRepositoryProvider);

  CollectionPagingRepository<MaterialData>? _collectionPagingRepository;

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
          state = cache.map((e) => e.entity).whereType<MaterialData>().toList();
        },
      );
      state = data.map((e) => e.entity).whereType<MaterialData>().toList();
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
          ...data.map((e) => e.entity).whereType<MaterialData>().toList(),
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
  Future<ResultData> create({
    required String title,
  }) async {
    try {
      final userId = _firebaseAuthRepository.loggedInUserId;
      if (userId == null) {
        throw AppException(title: 'ログインしてください');
      }
      final ref = Document.docRef(MaterialData.collectionPath(userId));
      final now = DateTime.now();
      final data = MaterialData(id: ref.id, title: title, createdAt: now);
      await _documentRepository.save(MaterialData.docPath(userId, ref.id),
          data: data.toDocWithNotImage);
      state = [data, ...state];
      return ResultData.success(ref.id);
    } on AppException catch (e) {
      logger.shout(e);
      return ResultData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultData.failure(AppException.error(e.errorMessage));
    }
  }

  /// 更新
  Future<ResultVoidData> update(MaterialData materialData) async {
    try {
      final userId = _firebaseAuthRepository.loggedInUserId;
      if (userId == null) {
        throw AppException(title: 'ログインしてください');
      }

      final docId = materialData.id;
      if (docId == null) {
        throw AppException.irregular();
      }

      await _documentRepository.update(
        MaterialData.docPath(userId, docId),
        data: materialData.toUpdateDoc,
      );
      state = state
          .map(
            (e) => e.id == materialData.id ? materialData : e,
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
      final userId = _firebaseAuthRepository.loggedInUserId;
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

  // idによる取得
  MaterialData getById(String materialId) {
    return state.firstWhere((material) => material.id == materialId);
  }


  List<Map<String, String>> getPickItem() {
    return state
        .map((material) => {'value': material.id, 'display': material.title})
        .toList();
  }
}
