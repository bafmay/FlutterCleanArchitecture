import 'package:chat_app_clean_architecture/presentation/home/chat/chat_page.dart';
import 'package:chat_app_clean_architecture/presentation/home/friends/friend_selection_cubit.dart';
import 'package:chat_app_clean_architecture/presentation/home/friends/group_selection_cubit.dart';
import 'package:chat_app_clean_architecture/presentation/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class GroupSelectionPage extends StatelessWidget {
  const GroupSelectionPage({Key key, this.selectedUsers}) : super(key: key);

  final List<ChatUserState> selectedUsers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GroupSelectionCubit(
        selectedUsers,
        context.read(),
        context.read(),
      ),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
          listener: (context, state) {
        if (state.channel != null) {
          pushAndReplaceToPage(
            context,
            Scaffold(
              body: StreamChannel(
                channel: state.channel,
                child: ChannelPage(),
              ),
            ),
          );
        }
      }, builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Verify your identity"),
                if (snapshot?.file != null)
                  Image.file(snapshot.file, height: 150)
                else
                  Placeholder(
                    fallbackWidth: 100,
                    fallbackHeight: 100,
                  ),
                IconButton(
                  icon: Icon(Icons.photo),
                  onPressed: () =>
                      context.read<GroupSelectionCubit>().pickImage(),
                ),
                TextField(
                  controller:
                      context.read<GroupSelectionCubit>().nameTextController,
                  decoration: InputDecoration(hintText: "Name of the group"),
                ),
                Wrap(
                  children: List.generate(
                    selectedUsers.length,
                    (index) => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(),
                        Text(selectedUsers[index].chatUser.name),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  child: Text("Next"),
                  onPressed: () =>
                      context.read<GroupSelectionCubit>().createGroup(),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
