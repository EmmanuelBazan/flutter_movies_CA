import 'package:flutter_movies_ca/app/data/services/remote/authentication_api.dart';
import 'package:flutter_movies_ca/app/domain/either.dart';
import 'package:flutter_movies_ca/app/domain/enums.dart';
import 'package:flutter_movies_ca/app/domain/models/user.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _secureStorage;
  final AuthenticationAPI _authenticationAPI;

  AuthenticationRepositoryImpl(
    this._secureStorage,
    this._authenticationAPI,
  );

  @override
  Future<User?> getUserData() {
    return Future.value(User());
  }

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, User>> signIn(
    String username,
    String password,
  ) async {
    final reqToken = await _authenticationAPI.createRequestToken();

    if (reqToken == null) {
      return Either.left(SignInFailure.unknown);
    }

    final loginRes = await _authenticationAPI.createRequestWithLogin(
      username: username,
      password: password,
      requestToken: reqToken,
    );

    return loginRes.when(
      (failure) async {
        return Either.left(failure);
      },
      (newToken) async {
        final res = await _authenticationAPI.createSession(newToken);

        return res.when(
          (failure) async => Either.left(failure),
          (sessionID) async {
            await _secureStorage.write(key: _key, value: sessionID);

            return Either.right(
              User(),
            );
          },
        );
      },
    );
  }

  @override
  Future<void> signOut() {
    return _secureStorage.delete(key: _key);
  }
}
