import 'dart:io';

import 'package:chat_app_clean_architecture/data/image_picker_repository.dart';
import 'package:chat_app_clean_architecture/domain/models/chat_user.dart';
import 'package:chat_app_clean_architecture/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileState {
  final File file;
  final bool success;

  ProfileState(this.file, {this.success = false});
}

class VerifyProfileCubit extends Cubit<ProfileState> {
  VerifyProfileCubit(this._imagePickerRepository, this._profileSignInUseCase)
      : super(ProfileState(null));

  final nameController = TextEditingController();
  final ImagePickerRepository _imagePickerRepository;
  final ProfileSignInUseCase _profileSignInUseCase;

  void pickImage() async {
    final file = await _imagePickerRepository.pickImage();
    emit(ProfileState(file));
  }

  void startChatting() async {
    final file = state.file;
    final name = nameController.text;
    await _profileSignInUseCase
        .verify(ProfileInput(name: name, imageFile: file));

    emit(ProfileState(file, success: true));
  }
}
