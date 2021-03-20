import 'dart:io';

import 'package:chat_app_clean_architecture/data/auth_repository.dart';
import 'package:chat_app_clean_architecture/data/stream_api_repository.dart';
import 'package:chat_app_clean_architecture/data/upload_storage_repository.dart';
import 'package:chat_app_clean_architecture/domain/models/chat_user.dart';

class ProfileInput {
  final File imageFile;
  final String name;

  ProfileInput({this.imageFile, this.name});
}

class ProfileSignInUseCase {
  final AuthRepository _authRepository;
  final UploadStorageRepository _uploadStorageRepository;
  final StreamApiRepository _streamApiRepository;

  ProfileSignInUseCase(
    this._authRepository,
    this._uploadStorageRepository,
    this._streamApiRepository,
  );

  Future<void> verify(ProfileInput input) async {
    final auth = await _authRepository.getAuthUser();
    final token = await _streamApiRepository.getToken(auth.id);
    final image = await _uploadStorageRepository.uploadPhoto(
        input.imageFile, "users/${auth.id}");
    await _streamApiRepository.connectUser(
        ChatUser(name: input.name, id: auth.id, image: image), token);
  }
}
