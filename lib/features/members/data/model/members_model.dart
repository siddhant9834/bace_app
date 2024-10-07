import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mayapur_bace/core/side_drawer/domain/entity/entity_model.dart';
import 'package:mayapur_bace/features/members/domain/entity/members_entity.dart';

class MembersModel extends ProfileEntity {
  const MembersModel(
      {
      // required super.uid,
      required super.email,
      required super.fullName,
      required super.phoneNumber,
      required super.role,
      required super.profilePic,
      required super.status
      });

  factory MembersModel.fromMap(Map<String, dynamic> data) {
    return MembersModel(
      // uid: data['uid']?.toString() ?? '',
      email: data['email'] as String,
      fullName: data['fullName'] as String,
      phoneNumber: data['phoneNumber'] as String,
      role: data['role'] as String,
      // status: (data['status'] as List).map((e) => e as bool).toList(),
      status: List<bool>.from(data['status'] as  List<dynamic>),

      profilePic: data['profilePic'] as String,
    );
  }
}
