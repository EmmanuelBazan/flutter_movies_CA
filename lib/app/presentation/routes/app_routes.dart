import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/presentation/routes/routes.dart';
import 'package:flutter_movies_ca/app/presentation/screens/splash/views/splash_view.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splashScreen: (context) => const SplashView(),
  };
}
