// import 'package:mayapur_bace/features/authentication/domain/entities/user_entity.dart';



// class ProfileModel extends UserEntity {
//   const ProfileModel({
//         // required super.uid,

//     required super.profilePicture,
//   });

//   factory ProfileModel.fromMap(Map<String, dynamic> data) {
//     return ProfileModel(
   
//       profilePicture: data['imageUrl']?.toString() ?? '',
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {

//       'profilePicture': profilePicture,
//     };
//   }

//   ProfileModel copyWith({
//     // String? uid,
//     String? profilePicture,

//   }) {
//     return ProfileModel(
//       // uid: uid?? this.uid,
//       profilePicture: profilePicture ?? this.profilePicture,

//     );
//   }
// }