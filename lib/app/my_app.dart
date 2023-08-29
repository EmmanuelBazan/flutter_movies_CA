import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/presentation/routes/app_routes.dart';
import 'package:flutter_movies_ca/app/presentation/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: Routes.splashScreen,
      routes: appRoutes,
    );
  }
}
