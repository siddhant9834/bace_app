
abstract class AuthRepository {
  Future<String?> signIn(String email, String password);
  Future<String?> registration(String email, String password, String fullName, String phoneNumber);
    // Future<void> updateProfilePic(String imageUrl);

}


// abstract class AuthRepository {
//   Future<String?> signIn(String email, String password);
//   Future<String?> registration(String email, String password, String phoneNumber, String fullName);
// }