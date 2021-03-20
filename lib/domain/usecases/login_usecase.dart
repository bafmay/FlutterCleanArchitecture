import 'package:chat_app_clean_architecture/data/auth_repository.dart';
import 'package:chat_app_clean_architecture/data/stream_api_repository.dart';
import 'package:chat_app_clean_architecture/domain/exceptions/auth_exception.dart';
import 'package:chat_app_clean_architecture/domain/models/auth_user.dart';

class LogInUseCase {
  final StreamApiRepository _streamApiRepository;
  final AuthRepository _authRepository;

  LogInUseCase(this._streamApiRepository, this._authRepository);

  Future<bool> validateLogin() async {
    final user = await _authRepository.getAuthUser();
    if (user != null) {
      final result = await _streamApiRepository.connectIfExist(user.id);
      if (result) {
        return true;
      } else {
        throw AuthException(AuthErrorCode.not_chat_user);
      }
    } else
      throw AuthException(AuthErrorCode.not_auth);
  }

  Future<AuthUser> signIn() async {
    return await _authRepository.signIn();
  }
}
