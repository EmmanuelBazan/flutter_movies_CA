import 'package:flutter_movies_ca/app/domain/models/user.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentification_repository.dart';

class AuthenticationRepositoryImpl implements AuthentificationRepository {
  @override
  Future<User> getUserData() {
    // TODO: implement getUserData
    return Future.value(User());
  }

  @override
  // TODO: implement isSignedIn
  Future<bool> get isSignedIn {
    return Future.value(true);
  }
}
