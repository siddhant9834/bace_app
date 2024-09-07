import 'package:mayapur_bace/core/side_drawer/domain/entity/entity_model.dart';

class MembersModel extends ProfileEntity {
  const MembersModel(
      {
      // required super.uid,
      required super.email,
      required super.fullName,
      required super.phoneNumber,
      required super.role,
      required super.profilePic
      });

  factory MembersModel.fromMap(Map<String, dynamic> data) {
    return MembersModel(
      // uid: data['uid']?.toString() ?? '',
      email: data['email'] as String,
      fullName: data['fullName'] as String,
      phoneNumber: data['phoneNumber'] as String,
      role: data['role'] as String,
      profilePic: data['profilePic'] as String,
    );
  }
}
