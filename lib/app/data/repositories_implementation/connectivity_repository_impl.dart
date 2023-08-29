import 'package:flutter_movies_ca/app/domain/repositories/connectivity_repository.dart';

class ConnectivityRepositoryImpl implements ConnectivityRepository {
  @override
  // TODO: implement hasInternet
  Future<bool> get hasInternet {
    return Future.value(true);
  }
}
