
import 'package:mayapur_bace/core/side_drawer/data/model/user_profile_model.dart';
import 'package:mayapur_bace/core/side_drawer/domain/entity/entity_model.dart';
import 'package:mayapur_bace/core/side_drawer/domain/repositories/user_repo.dart';

class GetProfileUseCase {
  final ProfileReposotories repository;

  GetProfileUseCase(this.repository);

  Future<ProfileModel> call(String email) {
    return repository.getProfile(email);
  }

}