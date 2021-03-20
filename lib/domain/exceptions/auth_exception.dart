enum AuthErrorCode { not_auth, not_chat_user }

class AuthException implements Exception {
  final AuthErrorCode error;

  AuthException(this.error);
}
