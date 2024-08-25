
import 'package:mayapur_bace/core/di/dependency_injection_container.dart';
import 'package:mayapur_bace/features/authentication/data/datasource/auth_datasource.dart';
import 'package:mayapur_bace/features/authentication/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<String?> registration(String email, String password) async {
   return await locator<AuthService>().registration(email: email, password: password);
  }

  @override
  Future<String?> signIn(String email, String password) async {
return await locator<AuthService>().login(email: email, password: password);
  }
}