
import 'package:mayapur_bace/core/side_drawer/data/datasource/FB_services.dart';
import 'package:mayapur_bace/core/side_drawer/data/model/user_profile_model.dart';
import 'package:mayapur_bace/core/side_drawer/domain/repositories/user_repo.dart';

class ProfileRepositoryImpl implements ProfileReposotories {
  final ProfileService datasource;

  ProfileRepositoryImpl(this.datasource);

  @override
  Future<ProfileModel> getProfile(String email) {
    return datasource.getProfile(email);
  }
    @override

   Future<void>updateProfileImageUrl(String imageUrl) {
    return datasource.updateProfileImageUrl(imageUrl);
  }
}
