import 'dart:typed_data';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learning_management_app/model/use_cases/material/material_controller.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../../utils/uuid_generator.dart';
import '../../entities/material.dart';
import '../../entities/storage_file.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firebase_storage/firebase_storage_repository.dart';
import '../../repositories/firebase_storage/mime_type.dart';
import '../../repositories/firestore/document_repository.dart';

final saveMaterialImageProvider =
    Provider((ref) => SaveMaterialImage(ref.read));

class SaveMaterialImage {
  SaveMaterialImage(this._read);
  final Reader _read;

  Future<void> call(String materialId, Uint8List file) async {
    final userId = _read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }

    /// 画像をCloudStorageへ保存
    final filename = UuidGenerator.create();
    final imagePath = MaterialData.imagePath(materialId, userId, filename);
    const mimeType = MimeType.applicationOctetStream;
    final imageUrl = await _read(firebaseStorageRepositoryProvider).save(
      file,
      path: imagePath,
      mimeType: mimeType,
    );

    /// 画像情報をFirestoreへ保存
    final material = _read(materialDataProvider.notifier).getById(materialId);
    final newMaterial = (material).copyWith(
      image: StorageFile(
        url: imageUrl,
        path: imagePath,
        mimeType: mimeType.value,
      ),
    );
    await _read(documentRepositoryProvider).save(
      MaterialData.docPath(userId, materialId),
      data: newMaterial.toImageOnly,
    );

    /// 古い画像をCloudStorageから削除
    final oldImage = material.image;
    if (oldImage != null) {
      await _read(firebaseStorageRepositoryProvider).delete(oldImage.path);
    }
  }
}
