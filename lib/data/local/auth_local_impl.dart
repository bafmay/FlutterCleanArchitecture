import 'package:chat_app_clean_architecture/data/auth_repository.dart';
import 'package:chat_app_clean_architecture/domain/models/auth_user.dart';

class AuthLocalImpl extends AuthRepository {
  @override
  Future<AuthUser> getAuthUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser("Brian");
  }

  @override
  Future<void> logout() async {
    return;
  }

  @override
  Future<AuthUser> signIn() async {
    await Future.delayed(const Duration(seconds: 2));
    return AuthUser("Brian");
  }
}
