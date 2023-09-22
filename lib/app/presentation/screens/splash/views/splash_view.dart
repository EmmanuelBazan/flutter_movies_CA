import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/domain/repositories/account_repository.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_movies_ca/app/domain/repositories/connectivity_repository.dart';
import 'package:flutter_movies_ca/app/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    // final connectivityRepository = injector.connectivityRepository;
    final ConnectivityRepository connectivityRepository = context.read();
    final AuthenticationRepository authenticationRepository = context.read();
    final AccountRepository accountRepository = context.read();

    final hasInternet = await connectivityRepository.hasInternet;

    if (hasInternet) {
      final isSignIn = await authenticationRepository.isSignedIn;

      if (isSignIn) {
        final user = await accountRepository.getUserData();
        if (mounted) {
          if (user != null) {
            _goTo(Routes.homeScreen);
          } else {
            _goTo(Routes.signInScreen);
          }
        }
      } else if (mounted) {
        _goTo(Routes.signInScreen);
      }
    } else {
      _goTo(Routes.offlineScreen);
    }
  }

  void _goTo(String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
