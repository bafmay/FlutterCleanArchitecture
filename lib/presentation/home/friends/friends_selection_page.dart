import 'package:chat_app_clean_architecture/presentation/home/chat/chat_page.dart';
import 'package:chat_app_clean_architecture/presentation/home/friends/friend_selection_cubit.dart';
import 'package:chat_app_clean_architecture/presentation/home/friends/group_selection_page.dart';
import 'package:chat_app_clean_architecture/presentation/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendsSelectionPage extends StatelessWidget {
  const FriendsSelectionPage({Key key}) : super(key: key);

  void _createFriendChannel(
      BuildContext context, ChatUserState chatUserState) async {
    final channel = await context
        .read<FriendSelectionCubit>()
        .createFriendChannel(chatUserState);
    pushAndReplaceToPage(
      context,
      Scaffold(
        body: StreamChannel(
          channel: channel,
          child: ChannelPage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  FriendSelectionCubit(context.read())..init()),
          BlocProvider(create: (_) => FriendsGroupCubit()),
        ],
        child:
            BlocBuilder<FriendsGroupCubit, bool>(builder: (context, isGroup) {
          return BlocBuilder<FriendSelectionCubit, List<ChatUserState>>(
            builder: (context, snapshot) {
              final selectedUsers =
                  context.read<FriendSelectionCubit>().selectedUsers;
              return Scaffold(
                floatingActionButton: isGroup && selectedUsers.isNotEmpty
                    ? FloatingActionButton(onPressed: () {
                        pushAndReplaceToPage(context,
                            GroupSelectionPage(selectedUsers: selectedUsers));
                      })
                    : null,
                body: Column(
                  children: [
                    if (isGroup)
                      Row(
                        children: [
                          BackButton(
                            onPressed: () {
                              context.read<FriendsGroupCubit>().changeToGroup();
                            },
                          ),
                          Text("New group"),
                        ],
                      )
                    else
                      Row(
                        children: [
                          BackButton(
                            onPressed: Navigator.of(context).pop,
                          ),
                          Text("People"),
                        ],
                      ),
                    if (!isGroup)
                      ElevatedButton(
                        child: Text("Create Group"),
                        onPressed: () {
                          context.read<FriendsGroupCubit>().changeToGroup();
                        },
                      )
                    else if (isGroup && selectedUsers.isEmpty)
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(),
                          Text("Add a friend"),
                        ],
                      )
                    else
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedUsers.length,
                          itemBuilder: (context, index) {
                            final chatUserState = selectedUsers[index];
                            return Stack(
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(),
                                    Text(chatUserState.chatUser.name)
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    context
                                        .read<FriendSelectionCubit>()
                                        .selectUser(chatUserState);
                                  },
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.length,
                        itemBuilder: (context, index) {
                          final chatUserState = snapshot[index];
                          final image = chatUserState.chatUser.image;
                          final urlImage = image == null
                              ? "https://i.pinimg.com/474x/8e/0c/fa/8e0cfaf58709f7e626973f0b00d033d0.jpg"
                              : image;
                          return ListTile(
                            onTap: () =>
                                _createFriendChannel(context, chatUserState),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(urlImage),
                            ),
                            title: Text(chatUserState.chatUser.name),
                            trailing: isGroup
                                ? Checkbox(
                                    value: chatUserState.selected,
                                    onChanged: (val) {
                                      context
                                          .read<FriendSelectionCubit>()
                                          .selectUser(chatUserState);
                                    },
                                  )
                                : null,
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
