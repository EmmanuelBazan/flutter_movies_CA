import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = '', _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (text) {
                  setState(() {
                    _username = text.trim().toLowerCase();
                  });
                },
                decoration: const InputDecoration(hintText: 'username'),
                validator: (text) {
                  final currText = text?.trim().toLowerCase() ?? '';
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
                  final currText = text?.trim().toLowerCase() ?? '';
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
                    if (isValid) {}
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[900],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
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
    ));
  }
}
