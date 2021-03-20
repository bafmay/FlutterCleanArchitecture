import 'package:chat_app_clean_architecture/data/auth_repository.dart';
import 'package:chat_app_clean_architecture/data/stream_api_repository.dart';

class LogoutUseCase {
  final StreamApiRepository _streamApiRepository;
  final AuthRepository _authRepository;

  LogoutUseCase(this._streamApiRepository, this._authRepository);

  Future<void> logout() async {
    await _streamApiRepository.logout();
    await _authRepository.logout();
  }
}
