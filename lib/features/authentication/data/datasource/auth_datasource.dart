
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> registration({
    required String email,
    required String password,
  }) async {
    print(11);
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
          print(22);

      return 'Success';
    print(22);

    } on FirebaseAuthException catch (e) {
          print(33);

      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
          print(44);

      return e.toString();
    }
        print(55);

  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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
}

// import 'package:firebase_auth/firebase_auth.dart';

// class FirebaseAuthService{
//   FirebaseAuth _auth= FirebaseAuth.instance;
//   Future<User?> signUpWithEmailAndPassword(String email, String password) async{
    
//     try{
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//         email : email,
//         password: password
//       );
//       return credential.user;

//     } catch (e){
//       print('Some error occured');
//     }
//     return null;
//   }

//     Future<User?> signInWithEmailAndPassword(String email, String password, ) async{
    
//     try{
//       UserCredential credential = await _auth.signInWithEmailAndPassword(
//         email: email,
        
//         password: password
        
//       );
//       return credential.user;

//     } catch (e){
//       print('Some error occured');
//     }
//     return null;
//   }


  
// }