import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/features/authentication/domain/repositories/auth_repositories.dart';


class AuthUseCases{

  Future<String?> loginUser(String email, String password) async {
    return await locator<AuthRepository>().signIn(email, password);
  }

  Future<String?> registerUser({ required email,  required password, required fullName,  required phoneNumber,}) async {
    return await locator<AuthRepository>().registration(email, password, fullName, phoneNumber);
  }

}