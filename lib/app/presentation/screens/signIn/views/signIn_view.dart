import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/domain/enums.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_movies_ca/app/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = '', _password = '';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          child: AbsorbPointer(
            absorbing: _loading,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (text) {
                    setState(() {
                      _username = text.trim();
                    });
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
                    setState(() {
                      _password = text.replaceAll(' ', '');
                    });
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
                Builder(builder: (context) {
                  return MaterialButton(
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
                      child: _loading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Future<void> _submit(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    final res = await Provider.of<AuthenticationRepository>(
      context,
      listen: false,
    ).signIn(
      _username,
      _password,
    );

    if (!mounted) {
      return;
    }

    res.when((failure) {
      setState(() {
        _loading = false;
      });
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
