// import 'package:firebase_auth/firebase_auth.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> registration({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,

    //  String? imageUrl

    // required String role,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc().set({
          'status': FieldValue.arrayUnion([DateTime.now().toIso8601String()]),
          'email': email,
          'fullName': fullName,
          'phoneNumber': phoneNumber,
          'role': 'Member',
          'profilePic':
              'https://firebasestorage.googleapis.com/v0/b/mayapur-bace.appspot.com/o/users_profile_images%2F1000050061.jpg?alt=media&token=f4578a49-92d9-4c96-8f32-019f8da1878e',
          'password': password,
          // 'profilePic': imageUrl,
        });
        await _firestore.collection('seva_assigned').doc(email).set({
          // 'email': email,
          'fullName': fullName,
          'Ph': phoneNumber,
          // 'role': 'Member',
          'seva': 'Not Assigned Yet'
          // 'profilePic': imageUrl,
        });
      }

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateProfileBio(String newBio) async {
    try {
      DocumentReference profileRef = _firestore
          .collection('registered_users')
          .doc('73x5M7xbusc6I3IlKx0CeANrhdc2');
      print('intupdate*********');
      print(newBio);
      await profileRef.update({'bio': newBio});
    } catch (e) {
      print('Error updating bio: $e');
      throw e;
    }
  }

  // Future<void> updateProfileUrl(String imageUrl) async {
  //   try {
  //     DocumentReference profileRef =
  //         _firestore.collection('users').doc('phoneNumber');
  //     print('In upadate image url*********');
  //     print(imageUrl);
  //     await profileRef.update({'profilePic': imageUrl});
  //   } catch (e) {
  //     print('Error updating bio: $e');
  //     throw e;
  //   }
  // }
}
