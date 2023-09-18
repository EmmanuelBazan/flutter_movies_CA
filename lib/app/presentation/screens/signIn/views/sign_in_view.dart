import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/domain/enums.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_movies_ca/app/presentation/routes/routes.dart';
import 'package:flutter_movies_ca/app/presentation/screens/signIn/controller/sign_in_controller.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
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
                absorbing: controller.loading,
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
                    MaterialButton(
                      onPressed: () {
                        final isValid = Form.of(context)!.validate();
                        if (isValid) {
                          _submit(context);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: controller.loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Sign In',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      )),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final SignInController controller = context.read();

    controller.onLoadingChanged(true);

    final res = await context.read<AuthenticationRepository>().signIn(
          controller.username,
          controller.password,
        );

    if (!mounted) {
      return;
    }

    res.when((failure) {
      controller.onLoadingChanged(false);
      final message = {
        SignInFailure.notFound: 'Invalid user',
        SignInFailure.unauthorized: 'Invalid password',
        SignInFailure.unknown: 'Error',
        SignInFailure.network: 'Network error',
      }[failure];

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message!),
      ));
    }, (success) {
      Navigator.pushReplacementNamed(context, Routes.homeScreen);
    });
  }
}
