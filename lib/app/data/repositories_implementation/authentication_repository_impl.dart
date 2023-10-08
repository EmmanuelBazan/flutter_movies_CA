import 'package:flutter_movies_ca/app/data/services/local/session_service.dart';
import 'package:flutter_movies_ca/app/data/services/remote/account_api.dart';
import 'package:flutter_movies_ca/app/data/services/remote/authentication_api.dart';
import 'package:flutter_movies_ca/app/domain/either.dart';
import 'package:flutter_movies_ca/app/domain/enums.dart';
import 'package:flutter_movies_ca/app/domain/models/user/user.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationAPI _authenticationAPI;
  final SessionService _sessionService;
  final AccountApi _accountApi;

  AuthenticationRepositoryImpl(
    this._authenticationAPI,
    this._sessionService,
    this._accountApi,
  );

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _sessionService.sessionId;
    return sessionId != null;
  }

  @override
  Future<Either<SignInFailure, UserModel>> signIn(
    String username,
    String password,
  ) async {
    final reqToken = await _authenticationAPI.createRequestToken();

    return reqToken.when(
      (failure) async => Either.left(failure),
      (token) async {
        final loginRes = await _authenticationAPI.createRequestWithLogin(
          username: username,
          password: password,
          requestToken: token,
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
                await _sessionService.saveSessionId(sessionID);

                final user = await _accountApi.getAccount(sessionID);

                if (user == null) {
                  return Either.left(SignInFailure.unknown);
                }

                return Either.right(user);
              },
            );
          },
        );
      },
    );
  }

  @override
  Future<void> signOut() => _sessionService.signOut();
}
