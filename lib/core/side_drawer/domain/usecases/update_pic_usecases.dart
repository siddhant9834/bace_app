import 'package:mayapur_bace/core/side_drawer/domain/repositories/user_repo.dart';

class UpdateImageUrl {
  final ProfileReposotories repository;

  UpdateImageUrl(this.repository);

  Future<void> call(String imageUrl) {
    return repository.updateProfileImageUrl(imageUrl);
  }
}