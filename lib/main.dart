import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movies_ca/app/data/repositories_implementation/authentication_repository_impl.dart';
import 'package:flutter_movies_ca/app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'package:flutter_movies_ca/app/data/services/remote/internet_checker.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_movies_ca/app/domain/repositories/connectivity_repository.dart';
import 'package:flutter_movies_ca/app/my_app.dart';

void main() => runApp(Injector(
      authentificationRepository: AuthenticationRepositoryImpl(),
      connectivityRepository: ConnectivityRepositoryImpl(
        Connectivity(),
        InternetChecker(),
      ),
      child: const MyApp(),
    ));

class Injector extends InheritedWidget {
  const Injector({
    super.key,
    required super.child,
    required this.connectivityRepository,
    required this.authentificationRepository,
  });

  final ConnectivityRepository connectivityRepository;
  final AuthenticationRepository authentificationRepository;

  @override
  bool updateShouldNotify(_) => false;

  static Injector of(BuildContext context) {
    final injector = context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'Injector could not be found');
    return injector!;
  }
}
