import 'package:mayapur_bace/features/authentication/data/model/auth_model.dart';
import 'package:mayapur_bace/core/side_drawer/data/model/user_profile_model.dart';

abstract class ProfileReposotories {
  Future<ProfileModel> getProfile(String email);
  // Future<void> updateProfileBio(String newBio);
  Future<void> updateProfileImageUrl(String imageUrl);
}
