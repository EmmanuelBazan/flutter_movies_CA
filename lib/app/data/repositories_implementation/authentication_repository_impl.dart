import 'package:flutter_movies_ca/app/domain/models/user.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  @override
  Future<User?> getUserData() {
    // TODO: implement getUserData
    return Future.value(null);
  }

  @override
  // TODO: implement isSignedIn
  Future<bool> get isSignedIn {
    return Future.value(true);
  }
}
