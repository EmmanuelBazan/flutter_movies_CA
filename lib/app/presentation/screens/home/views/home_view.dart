import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/presentation/routes/routes.dart';
import 'package:flutter_movies_ca/main.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: TextButton(
              onPressed: () async {
                Injector.of(context).authentificationRepository.signOut();
                Navigator.pushReplacementNamed(context, Routes.signInScreen);
              },
              child: Text(
                'sign out',
                style: TextStyle(color: Colors.lightBlue[900]),
              ))),
    );
  }
}
