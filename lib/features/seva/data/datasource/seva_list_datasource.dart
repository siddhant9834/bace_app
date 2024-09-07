// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mayapur_bace/features/seva/data/model/seva_model.dart';

class SevaListDataService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<SevaListModel>>getSevaList() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('seva_assigned').get();

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

  
}
