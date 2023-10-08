import 'package:flutter_movies_ca/app/domain/either.dart';
import 'package:flutter_movies_ca/app/domain/enums.dart';
import 'package:flutter_movies_ca/app/domain/models/user/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;
  Future<void> signOut();
  Future<Either<SignInFailure, UserModel>> signIn(
    String username,
    String password,
  );
}
