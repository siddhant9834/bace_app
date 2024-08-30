


import 'package:mayapur_bace/core/side_drawer/domain/entity/entity_model.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
        // required super.uid,
    required super.email,
    required super.fullName,
    required super.phoneNumber,
    required super.role,
        required super.profilePic


  });

  factory ProfileModel.fromMap(Map<String, dynamic> data) {
    return ProfileModel(
      // uid: data['uid']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      fullName: data['fullName']?.toString() ?? '',
      phoneNumber: data['phoneNumber']?.toString() ?? '',
      role: data['role']?.toString() ?? '',
      profilePic: data['profilePic'].toString() ?? '',

    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     // 'uid': uid,
  //     'bio': bio,
  //     'phoneNumber': phoneNumber,
  //     'profilePicture': profilePicture,
  //     'userName': userName,
  //   };
  // }

  // ProfileModel copyWith({
  //   // String? uid,
  //   String? userName,
  //   String? profilePicture,
  //   String? phoneNumber,
  //   String? bio,
  // }) {
  //   return ProfileModel(
  //     // uid: uid?? this.uid,
  //     userName: userName ?? this.userName,
  //     profilePicture: profilePicture ?? this.profilePicture,
  //     phoneNumber: phoneNumber ?? this.phoneNumber,
  //     bio: bio ?? this.bio,
  //   );
  // }
}