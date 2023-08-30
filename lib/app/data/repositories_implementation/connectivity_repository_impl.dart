import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_movies_ca/app/domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  final Connectivity _connectivity;

  ConnectivityRepositoryImpl(this._connectivity);

  @override
  Future<bool> get hasInternet async {
    final connectRes = await (_connectivity.checkConnectivity());
    if (connectRes == ConnectivityResult.none) return false;

    return _hasInternet();
  }

  Future<bool> _hasInternet() async {
    try {
      final list = await InternetAddress.lookup('google.com');
      return list.isNotEmpty && list.first.rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
