import 'package:chat_app_clean_architecture/data/stream_api_repository.dart';
import 'package:chat_app_clean_architecture/domain/models/chat_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat/stream_chat.dart';

class ChatUserState {
  final ChatUser chatUser;
  final bool selected;

  ChatUserState(this.chatUser, {this.selected = false});
}

class FriendSelectionCubit extends Cubit<List<ChatUserState>> {
  FriendSelectionCubit(this._streamApiRepository) : super([]);
  final StreamApiRepository _streamApiRepository;

  List<ChatUserState> get selectedUsers =>
      state.where((element) => element.selected).toList();

  Future<void> init() async {
    final users = (await _streamApiRepository.getChatUsers())
        .map((e) => ChatUserState(e))
        .toList();

    emit(users);
  }

  void selectUser(ChatUserState chatUser) {
    final index = state
        .indexWhere((element) => element.chatUser.id == chatUser.chatUser.id);
    state[index] =
        ChatUserState(state[index].chatUser, selected: !chatUser.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createFriendChannel(ChatUserState chatUserState) async {
    return await _streamApiRepository
        .createSimpleChat(chatUserState.chatUser.id);
  }
}

class FriendsGroupCubit extends Cubit<bool> {
  FriendsGroupCubit() : super(false);

  void changeToGroup() => emit(!state);
}
