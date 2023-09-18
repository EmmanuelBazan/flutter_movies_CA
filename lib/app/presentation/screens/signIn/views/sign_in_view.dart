import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/presentation/screens/signIn/controller/sign_in_controller.dart';
import 'package:flutter_movies_ca/app/presentation/screens/signIn/views/widgets/submit_button.dart';
import 'package:provider/provider.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (_) => SignInController(),
      child: Scaffold(
          body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            child: Builder(builder: (context) {
              final controller = Provider.of<SignInController>(context);
              return AbsorbPointer(
                absorbing: controller.state.loading,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (text) {
                        controller.onUserNameChanged(text);
                      },
                      decoration: const InputDecoration(hintText: 'username'),
                      validator: (text) {
                        final currText = text?.trim() ?? '';
                        if (currText.isEmpty) {
                          return 'Invalid username';
                        }

                        return null;
                      },
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (text) {
                        controller.onPasswordChanged(text);
                      },
                      decoration: const InputDecoration(hintText: 'password'),
                      validator: (text) {
                        final currText = text?.trim() ?? '';
                        if (currText.length < 4) {
                          return 'Invalid password';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const SubmitButton(),
                  ],
                ),
              );
            }),
          ),
        ),
      )),
    );
  }
}
