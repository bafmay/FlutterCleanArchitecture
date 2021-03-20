import 'dart:io';

import 'package:chat_app_clean_architecture/data/stream_api_repository.dart';
import 'package:chat_app_clean_architecture/data/upload_storage_repository.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:uuid/uuid.dart';

class CreateGroupUseCase {
  final UploadStorageRepository _uploadStorageRepository;
  final StreamApiRepository _streamApiRepository;

  CreateGroupUseCase(this._uploadStorageRepository, this._streamApiRepository);

  Future<Channel> createGroup(CreateGroupInput input) async {
    final channelId = Uuid().v4();
    final imageResult =
        await _uploadStorageRepository.uploadPhoto(input.imageFile, "channels");
    final channel = await _streamApiRepository.createGroupChat(
      channelId,
      input.name,
      input.members,
      imagePath: imageResult,
    );
    return channel;
  }
}

class CreateGroupInput {
  final String name;
  final List<String> members;
  final File imageFile;

  CreateGroupInput({this.name, this.members, this.imageFile});
}
