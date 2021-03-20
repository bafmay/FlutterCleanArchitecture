import 'package:chat_app_clean_architecture/data/auth_repository.dart';
import 'package:chat_app_clean_architecture/data/image_picker_repository.dart';
import 'package:chat_app_clean_architecture/data/local/auth_local_impl.dart';
import 'package:chat_app_clean_architecture/data/local/image_picker_impl.dart';
import 'package:chat_app_clean_architecture/data/local/persistance_storage_local_impl.dart';
import 'package:chat_app_clean_architecture/data/local/stream_api_local_impl.dart';
import 'package:chat_app_clean_architecture/data/local/upload_storage_local_impl.dart';
import 'package:chat_app_clean_architecture/data/persistance_storage_repository.dart';
import 'package:chat_app_clean_architecture/data/stream_api_repository.dart';
import 'package:chat_app_clean_architecture/data/upload_storage_repository.dart';
import 'package:chat_app_clean_architecture/domain/usecases/create_group_usecase.dart';
import 'package:chat_app_clean_architecture/domain/usecases/log_out_usecase.dart';
import 'package:chat_app_clean_architecture/domain/usecases/login_usecase.dart';
import 'package:chat_app_clean_architecture/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat/stream_chat.dart';

List<RepositoryProvider> buildRepositories(StreamChatClient client) {
  return [
    RepositoryProvider<StreamApiRepository>(
        create: (_) => StreamApiLocalImpl(client)),
    RepositoryProvider<PersistanceStorageRepository>(
        create: (_) => PersistanceStorageLocalImpl()),
    RepositoryProvider<ImagePickerRepository>(create: (_) => ImagePickerImpl()),
    RepositoryProvider<AuthRepository>(create: (_) => AuthLocalImpl()),
    RepositoryProvider<UploadStorageRepository>(
        create: (_) => UploadStorageLocalImpl()),
    RepositoryProvider<ProfileSignInUseCase>(
      create: (context) => ProfileSignInUseCase(
        context.read(),
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<CreateGroupUseCase>(
      create: (context) => CreateGroupUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LogoutUseCase>(
      create: (context) => LogoutUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LogInUseCase>(
      create: (context) => LogInUseCase(
        context.read(),
        context.read(),
      ),
    ),
  ];
}
