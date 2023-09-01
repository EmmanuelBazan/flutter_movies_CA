import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_movies_ca/app/data/services/remote/internet_checker.dart';
import 'package:flutter_movies_ca/app/domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final Connectivity _connectivity;
  final InternetChecker _internetChecker;

  ConnectivityRepositoryImpl(
    this._connectivity,
    this._internetChecker,
  );

  @override
  Future<bool> get hasInternet async {
    final connectRes = await (_connectivity.checkConnectivity());
    if (connectRes == ConnectivityResult.none) return false;

    return _internetChecker.hasInternet();
  }
}
