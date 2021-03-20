import 'dart:io';

import 'package:chat_app_clean_architecture/data/image_picker_repository.dart';
import 'package:chat_app_clean_architecture/domain/usecases/create_group_usecase.dart';
import 'package:chat_app_clean_architecture/presentation/home/friends/friend_selection_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionState {
  final File file;
  final Channel channel;

  GroupSelectionState(this.file, {this.channel});
}

class GroupSelectionCubit extends Cubit<GroupSelectionState> {
  GroupSelectionCubit(
    this.members,
    this._createGroupUseCase,
    this._imagePickerRepository,
  ) : super(null);

  final List<ChatUserState> members;
  final nameTextController = TextEditingController();
  final CreateGroupUseCase _createGroupUseCase;
  final ImagePickerRepository _imagePickerRepository;

  void createGroup() async {
    final channel = await _createGroupUseCase.createGroup(CreateGroupInput(
      imageFile: state.file,
      name: nameTextController.text,
      members: members.map((e) => e.chatUser.name).toList(),
    ));
    emit(GroupSelectionState(state.file, channel: channel));
  }

  void pickImage() async {
    final image = await _imagePickerRepository.pickImage();
    emit(GroupSelectionState(image));
  }
}
