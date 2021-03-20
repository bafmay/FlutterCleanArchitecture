import 'package:chat_app_clean_architecture/presentation/home/home_cubit.dart';
import 'package:chat_app_clean_architecture/presentation/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat/chat_page.dart';
import 'friends/friends_selection_page.dart';
import 'settings/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<HomeCubit, int>(
              builder: (context, snapshot) {
                return IndexedStack(
                  index: snapshot,
                  children: [
                    ChatPage(),
                    SettingsPage(),
                  ],
                );
              },
            ),
          ),
          HomeNavigationBar(),
        ],
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text("Chats"),
            onPressed: () => context.read<HomeCubit>().onItemMenuChange(0),
          ),
          FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              pushToPage(context, FriendsSelectionPage());
            },
          ),
          ElevatedButton(
            child: Text("Settings"),
            onPressed: () => context.read<HomeCubit>().onItemMenuChange(1),
          ),
        ],
      ),
    );
  }
}
