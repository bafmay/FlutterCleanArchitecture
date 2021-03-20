import 'package:chat_app_clean_architecture/presentation/home/home_page.dart';
import 'package:chat_app_clean_architecture/presentation/sign_in/sign_in_cubit.dart';
import 'package:chat_app_clean_architecture/presentation/utils/navigator_utils.dart';
import 'package:chat_app_clean_architecture/presentation/verify_profile/verify_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, snapshot) {
          if (snapshot == SignInState.none)
            pushAndReplaceToPage(context, VerifyProfile());
          else if (snapshot == SignInState.existing_user)
            pushAndReplaceToPage(context, HomePage());
        },
        builder: (context, _) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome to FluChat"),
                  ElevatedButton(
                    child: Text("Login with Google"),
                    onPressed: () {
                      context.read<SignInCubit>().signIn();
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
