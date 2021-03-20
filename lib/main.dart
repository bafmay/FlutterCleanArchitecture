import 'package:chat_app_clean_architecture/dependencies.dart';
import 'package:chat_app_clean_architecture/presentation/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/splash/splash_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _streamChatClient =
      StreamChatClient("tcbg9kv2tv6t", logLevel: Level.INFO);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return MultiRepositoryProvider(
      providers: buildRepositories(_streamChatClient),
      child: BlocProvider(
        create: (context) => AppThemeCubit(context.read())..init(),
        child: BlocBuilder<AppThemeCubit, bool>(builder: (context, snapshot) {
          return MaterialApp(
            title: 'Flutter Chat',
            debugShowCheckedModeBanner: false,
            home: SplashPage(),
            theme: snapshot ? ThemeData.dark() : ThemeData.light(),
            builder: (_, child) {
              return StreamChat(child: child, client: _streamChatClient);
            },
          );
        }),
      ),
    );
  }
}
