import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../exceptions/app_exception.dart';
import '../../entities/developer.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firestore/document_repository.dart';
import './fetch_my_profile.dart';

final saveMyProfileProvider = Provider((ref) => SaveMyProfile(ref.read));

class SaveMyProfile {
  SaveMyProfile(this._read);
  final Reader _read;

  Future<void> call({
    String? name,
    int? targetTime,
    int? numOfMaterials,
  }) async {
    final userId = _read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    final profile = _read(fetchMyProfileProvider).value;
    final newProfile = (profile ?? Developer(developerId: userId)).copyWith(
      name: name,
      targetTime: targetTime,
      numOfMaterials: numOfMaterials,
    );
    await _read(documentRepositoryProvider).save(
      Developer.docPath(userId),
      data: newProfile.toDocWithNotImage,
    );
  }
}