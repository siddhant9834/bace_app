// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mayapur_bace/core/side_drawer/data/datasource/FB_services.dart';
import 'package:mayapur_bace/features/seva/data/model/seva_model.dart';

class SevaListDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<SevaListModel>> getSevaList() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('seva_assigned').get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          return SevaListModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        // return MembersModel.fromMap(
        //     querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        throw Exception('No Seva Member found.');
      }
    } catch (e) {
      print('Error in getting Seva Members: $e');
      throw e;
    }
  }

  Future<void> updateSeva(String newSeva, String userEmail) async {
  try {
    // Use the userEmail as the document ID
    await _firestore.collection('seva_assigned')
        .doc(userEmail) // Use the email as the document ID
        .update({'seva': newSeva});
    print('Seva updated successfully for ****$userEmail');
  } catch (e) {
    print('Error updating seva: $e');
    throw Exception('Facing problem while updating Seva, try again later');
  }
}


  // Future<void> updateSeva(String newSeva, String userEmail) async {
  //   try {
  //     // Fetch the document snapshot
  //     QuerySnapshot querySnapshot = await _firestore
  //         .collection('seva_assigned')
  //         .where('email', isEqualTo: userEmail)
  //         .get();

  //   if (querySnapshot.docs.isNotEmpty) {
  //     DocumentSnapshot documentSnapshot = querySnapshot.docs.first; // Get the first document
  //     await _firestore.collection('seva_assigned')
  //         .doc(userEmail) // Use the document ID
  //         .update({'seva': newSeva});
  //     print('Seva updated successfully for $userEmail');
  //   } else {
  //     print('No document found for the provided email: $userEmail');
  //   }
  //     // if (querySnapshot.docs.isNotEmpty) {
  //     //   await _firestore
  //     //       .collection('seva_assigned')
  //     //       .doc(ProfileService().getEmail())
  //     //       .update({'seva': newSeva});
  //     //   print('Seva updated successfully');
  //     // } else {
  //     //   print('Document does not exist for the provided email.');
  //     // }
  //   } catch (e) {
  //     throw "'Facing problem while adding Seva, try again after some time'";
  //   }
  // }
}
