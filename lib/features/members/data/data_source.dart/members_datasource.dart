// import 'package:firebase_auth/firebase_auth.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mayapur_bace/features/members/data/model/members_model.dart';


// class MembersDataService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<List<MembersModel>> getMembers() {
//     try {
//       return _firestore.collection('users').snapshots().map((querySnapshot) {

//         return querySnapshot.docs.map((doc) {
//           return MembersModel.fromMap(doc.data() as Map<String, dynamic>);
//         }).toList();
//       });
//     } catch (e) {
//       print('Error in getting Members: $e');
//       throw e;
//     }
//   }
// }

class MembersDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<MembersModel>>getMembers() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.map((doc) {
          return MembersModel.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();

        // return MembersModel.fromMap(
        //     querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else { 
        throw Exception('No Members found.');
      }
    } catch (e) {
      print('Error in getting Members: $e');
      throw e;
    }
  }

  
}
