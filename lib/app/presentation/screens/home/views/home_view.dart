import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/presentation/global/controllers/session_controller.dart';
import 'package:flutter_movies_ca/app/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = Provider.of(context);
    final user = sessionController.state!;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(user.id.toString()),
          Text(user.username),
          TextButton(
              onPressed: () async {
                await sessionController.signOut();
                if (mounted) {
                  Navigator.pushReplacementNamed(context, Routes.signInScreen);
                }
              },
              child: Text(
                'sign out',
                style: TextStyle(color: Colors.lightBlue[900]),
              )),
        ],
      ),
    );
  }
}
