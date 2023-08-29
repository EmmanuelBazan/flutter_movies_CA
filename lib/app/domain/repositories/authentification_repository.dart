import 'package:flutter_movies_ca/app/domain/models/user.dart';

abstract class AuthentificationRepository {
  Future<bool> get isSignedIn;
  Future<User> getUserData();
}
