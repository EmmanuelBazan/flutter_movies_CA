import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/presentation/routes/routes.dart';
import 'package:flutter_movies_ca/app/presentation/screens/home/views/home_view.dart';
import 'package:flutter_movies_ca/app/presentation/screens/offline/views/offline_view.dart';
import 'package:flutter_movies_ca/app/presentation/screens/signIn/views/sign_in_view.dart';
import 'package:flutter_movies_ca/app/presentation/screens/splash/views/splash_view.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.offlineScreen: (context) => const OfflineView(),
    Routes.splashScreen: (context) => const SplashView(),
    Routes.signInScreen: (context) => const SignInView(),
    Routes.homeScreen: (context) => const HomeView(),
  };
}
