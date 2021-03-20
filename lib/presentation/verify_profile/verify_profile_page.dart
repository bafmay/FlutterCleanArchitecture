import 'package:chat_app_clean_architecture/presentation/home/home_page.dart';
import 'package:chat_app_clean_architecture/presentation/utils/navigator_utils.dart';
import 'package:chat_app_clean_architecture/presentation/verify_profile/verify_profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyProfile extends StatelessWidget {
  const VerifyProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyProfileCubit(context.read(), context.read()),
      child: BlocConsumer<VerifyProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.success) pushAndReplaceToPage(context, HomePage());
        },
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Verify your identity"),
                  if (snapshot.file != null)
                    Image.file(snapshot.file, height: 150)
                  else
                    Placeholder(
                      fallbackWidth: 100,
                      fallbackHeight: 100,
                    ),
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: () =>
                        context.read<VerifyProfileCubit>().pickImage(),
                  ),
                  Text("Your name"),
                  TextField(
                    controller:
                        context.read<VerifyProfileCubit>().nameController,
                    decoration: InputDecoration(
                      hintText: "Or just how people know you",
                    ),
                  ),
                  ElevatedButton(
                    child: Text("Start chatting now"),
                    onPressed: () =>
                        context.read<VerifyProfileCubit>().startChatting(),
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
