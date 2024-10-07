// import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mayapur_bace/core/side_drawer/data/model/user_profile_model.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  String? getEmail() {
    User? user = _auth.currentUser;
    return user?.email;
  }

  Future<ProfileModel> getProfile(String userEmail) async {
    try {
      log(userEmail.toString());

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return ProfileModel.fromMap(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        throw Exception('No user found with this email.');
      }
    } catch (e) {
      print('Error in getting profile: $e');
      throw e;
    }
  }
//      Future<void> updateProfileImageUrl(String imageUrl) async {
//     try {
//           User? user = _auth.currentUser  ;
//           String? email = user!.email;
// ;

//       DocumentReference profileRef =
//           _firestore.collection('users').doc('phoneNumber');
//       print(imageUrl);
//       await profileRef.update({'profilePic': imageUrl});
//     } catch (e) {
//       print('Error updating bio: $e');
//       throw e;
//     }
//   }

  Future<void> updateProfileImageUrl(String imageUrl) async {
    try {
      User? user = _auth.currentUser;

      if (user == null) {
        throw Exception('No user is currently logged in.');
      }

      String? email = user.email;
      if (email == null) {
        throw Exception('The logged-in user does not have an email.');
      }

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference profileRef = querySnapshot.docs.first.reference;

        print('Updating profilePic for user with email: $email');

        await profileRef.update({'profilePic': imageUrl});
      } else {
        print('No user found with this email.');
      }
    } catch (e) {
      print('Error updating profilePic: $e');
      throw e;
    }
  }
  

  // Future<void> updateStatus(bool status) async {
  //   try {
  //     QuerySnapshot querySnapshot = await _firestore
  //         .collection('users')
  //         .where('email', isEqualTo: getEmail())
  //         .get();

  //     log('Status update service called for user: ${getEmail()}');

  //     if (querySnapshot.docs.isNotEmpty) {
  //       for (QueryDocumentSnapshot doc in querySnapshot.docs) {
  //         Map<bool, Timestamp> currentStatus = doc['status'] ?? [];
  //         // log(currentStatus.last.toString());
  //          Map<String, dynamic> newStatus = {
  //         'status': status,
  //         'timestamp': FieldValue.serverTimestamp()
  //       };
  //         currentStatus.add(newStatus);

  //         await doc.reference.update({
  //           'status': currentStatus,
  //         });

  //         log('Status updated successfully with timestamp for document: ${doc.id}');
  //       }
  //     } else {
  //       log('No user found with this email.');
  //       throw Exception('User not found.');
  //     }
  //   } catch (e) {
  //     log('Error updating status: $e');
  //     throw 'Facing problem while updating IN/OUT status, try again after some time';
  //   }
  // }
Future<void> updateStatus(bool status) async {
   try {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: getEmail())
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference profileRef = querySnapshot.docs.first.reference;

      await profileRef.set({
        'status': FieldValue.arrayUnion([status]) 
      }, SetOptions(merge: true)); 
    } else {
      print('No user found with the provided email.');
    }
  } catch (e) {
    print('Facing problem while adding IN/OUT status, try again after some time');
    throw e;
  }
}

  //   Future<void> updateStatus(bool status) async {
  //   try {
  //     DocumentReference profileRef = _firestore
  //         .collection('users')
  //              .where('email', isEqualTo: userEmail)
  //          .get();
  //     await profileRef.update({'status': status});
  //   } catch (e) {
  //     print('Facing Problem while updating IN/OUT status, try again after some time');
  //     throw e;
  //   }
  // }
}
