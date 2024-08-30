import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/features/authentication/data/FireB_auth_impl_datasource.dart/firebase_auth_services_impl.dart';
import 'package:mayapur_bace/features/authentication/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<String?> registration(String email, String password,
     String fullName, String phoneNumber) async {
    return await locator<AuthService>().registration(
        email: email,
        password: password,
        fullName: fullName,
        phoneNumber: phoneNumber,
        );
  }

  @override
  Future<String?> signIn(String email, String password) async {
    return await locator<AuthService>().login(email: email, password: password);
  }

  // @override
  // Future<void> updateProfilePic(String imageUrl)  {
  //   return  locator<AuthService>().updateProfileUrl(imageUrl);
  // }
}
