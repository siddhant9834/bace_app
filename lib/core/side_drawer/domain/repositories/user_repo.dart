import 'package:mayapur_bace/core/side_drawer/data/model/user_profile_model.dart';

abstract class ProfileReposotories {
  Future<void> updateStatus(bool status);
  
  Future<ProfileModel> getProfile(String email);
  // Future<void> updateProfileBio(String newBio);
  Future<void> updateProfileImageUrl(String imageUrl);
  // Future<void>updateStatus(bool status);
}
