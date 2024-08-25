abstract class AuthRepository {
  Future<String?> signIn(String email, String password);
  Future<String?> registration(String email, String password);
}