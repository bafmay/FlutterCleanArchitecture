import 'package:chat_app_clean_architecture/presentation/app_theme_cubit.dart';
import 'package:chat_app_clean_architecture/presentation/home/settings/settings_cubit.dart';
import 'package:chat_app_clean_architecture/presentation/sign_in/sign_in_page.dart';
import 'package:chat_app_clean_architecture/presentation/utils/navigator_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = StreamChat.of(context).client.state.user;
    final image = user?.extraData["image"];
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                SettingsSwitchCubit(context.read<AppThemeCubit>().isDark)),
        BlocProvider(create: (context) => SettingsLogoutCubit(context.read())),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              if (image != null)
                Image.network(image, height: 150)
              else
                Placeholder(),
              BlocBuilder<SettingsSwitchCubit, bool>(
                builder: (context, snapshot) {
                  return Switch(
                    value: snapshot,
                    onChanged: (val) {
                      context.read<SettingsSwitchCubit>().onChangeDarkMode(val);
                      context.read<AppThemeCubit>().updateTheme(val);
                    },
                  );
                },
              ),
              Builder(
                builder: (context) {
                  return BlocListener<SettingsLogoutCubit, void>(
                    listener: (context, _) {
                      popAllAndPush(context, SignInPage());
                    },
                    child: ElevatedButton(
                      child: Text("Logout"),
                      onPressed: () =>
                          context.read<SettingsLogoutCubit>().logOut(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
