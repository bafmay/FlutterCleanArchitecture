import 'package:chat_app_clean_architecture/domain/exceptions/auth_exception.dart';
import 'package:chat_app_clean_architecture/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState { none, existing_user, new_user }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._logInUseCase) : super(SplashState.none);

  final LogInUseCase _logInUseCase;

  Future<void> init() async {
    try {
      final result = await _logInUseCase.validateLogin();
      if (result) emit(SplashState.existing_user);
    } on AuthException catch (e) {
      if (e.error == AuthErrorCode.not_auth) {
        emit(SplashState.none);
      } else {
        emit(SplashState.new_user);
      }
    }
  }
}
