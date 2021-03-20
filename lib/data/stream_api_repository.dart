import 'package:chat_app_clean_architecture/domain/models/chat_user.dart';
import 'package:stream_chat/stream_chat.dart';

abstract class StreamApiRepository {
  Future<List<ChatUser>> getChatUsers();
  Future<String> getToken(String userId);
  Future<bool> connectIfExist(String userId);
  Future<ChatUser> connectUser(ChatUser user, String token);
  Future<Channel> createGroupChat(
      String channelId, String name, List<String> members,
      {String imagePath});
  Future<Channel> createSimpleChat(String friendId);
  Future<void> logout();
}
