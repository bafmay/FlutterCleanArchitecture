import 'package:chat_app_clean_architecture/presentation/home/home_page.dart';
import 'package:chat_app_clean_architecture/presentation/sign_in/sign_in_page.dart';
import 'package:chat_app_clean_architecture/presentation/splash/splash_cubit.dart';
import 'package:chat_app_clean_architecture/presentation/utils/navigator_utils.dart';
import 'package:chat_app_clean_architecture/presentation/verify_profile/verify_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context.read())..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, snapshot) {
          if (snapshot == SplashState.none)
            pushAndReplaceToPage(context, SignInPage());
          else if (snapshot == SplashState.existing_user)
            pushAndReplaceToPage(context, HomePage());
          else
            pushAndReplaceToPage(context, VerifyProfile());
        },
        child: Scaffold(
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}
