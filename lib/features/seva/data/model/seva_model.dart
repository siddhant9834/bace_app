import 'package:mayapur_bace/features/seva/domain/entity/seva_list_entity.dart';

class SevaListModel extends SevaListEntity {
  const SevaListModel({
    // required super.uid,
    required super.fullName,
    required super.phoneNumber,
    required super.role,
    required super.seva,
    required super.email,
  });

  factory SevaListModel.fromMap(Map<String, dynamic> data) {
    return SevaListModel(
      // uid: data['uid']?.toString() ?? '',
      seva: data['seva']?.toString() ?? '',
      fullName: data['fullName']?.toString() ?? '',
      phoneNumber: data['Ph']?.toString() ?? '',
      role: data['role']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
    );
  }
}
