import 'package:chat_app_clean_architecture/data/stream_api_repository.dart';
import 'package:chat_app_clean_architecture/domain/models/chat_user.dart';
import 'package:stream_chat/stream_chat.dart';

class StreamApiLocalImpl extends StreamApiRepository {
  final StreamChatClient _client;

  StreamApiLocalImpl(this._client);

  @override
  Future<bool> connectIfExist(String userId) async {
    final token = await getToken(userId);
    await _client.connectUser(User(id: userId), token);
    return _client.state.user.name != null;
  }

  @override
  Future<ChatUser> connectUser(ChatUser user, String token) async {
    Map<String, dynamic> extraData = {};
    if (user.image != null) {
      extraData["image"] = user.image;
    }
    if (user.name != null) {
      extraData["name"] = user.name;
    }
    await _client.disconnect();
    await _client.connectUser(User(id: user.id, extraData: extraData), token);
    return user;
  }

  @override
  Future<Channel> createGroupChat(
      String channelId, String name, List<String> members,
      {String imagePath}) async {
    final channel = _client.channel("messaging", id: channelId, extraData: {
      "name": name,
      "image": imagePath,
      "members": [_client.state.user.id, ...members],
    });
    await channel.watch();
    return channel;
  }

  @override
  Future<Channel> createSimpleChat(String friendId) async {
    final channel = _client.channel("messaging",
        id: "${_client.state.user.id.hashCode}${friendId.hashCode}",
        extraData: {
          "members": [
            friendId,
            _client.state.user.id,
          ],
        });
    await channel.watch();
    return channel;
  }

  @override
  Future<List<ChatUser>> getChatUsers() async {
    final result = await _client.queryUsers();
    final chatUsers = result.users
        .where((element) => element.id != _client.state.user.id)
        .map((e) => ChatUser(
              id: e.id,
              name: e.name,
              image: e.extraData["image"],
            ))
        .toList();
    return chatUsers;
  }

  @override
  Future<String> getToken(String userId) async {
    return _client.devToken(userId);
  }

  @override
  Future<void> logout() async {
    _client.disconnect();
  }
}
