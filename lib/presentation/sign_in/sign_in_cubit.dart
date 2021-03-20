import 'package:chat_app_clean_architecture/domain/exceptions/auth_exception.dart';
import 'package:chat_app_clean_architecture/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SignInState { none, existing_user }

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._logInUseCase) : super(SignInState.none);

  final LogInUseCase _logInUseCase;

  Future<void> signIn() async {
    try {
      final result = await _logInUseCase.validateLogin();
      if (result) emit(SignInState.existing_user);
    } catch (e) {
      final result = await _logInUseCase.signIn();
      if (result != null) {
        emit(SignInState.none);
      }
    }
  }
}
