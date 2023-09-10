import 'package:flutter_movies_ca/app/data/http/http.dart';
import 'package:flutter_movies_ca/app/domain/either.dart';
import 'package:flutter_movies_ca/app/domain/enums.dart';

class AuthenticationAPI {
  final Http _http;

  AuthenticationAPI(this._http);

  Either<SignInFailure, String> _handleHttpFailure(HttpFailure failure) {
    if (failure.statuscode != null) {
      switch (failure.statuscode) {
        case 401:
          return Either.left(SignInFailure.unauthorized);

        case 404:
          return Either.left(SignInFailure.notFound);

        default:
          return Either.left(SignInFailure.unknown);
      }
    }

    if (failure.exception is NetworkException) {
      return Either.left(SignInFailure.network);
    }

    return Either.left(SignInFailure.unknown);
  }

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final res = await _http.request(
      '/authentication/token/new',
      (responseBody) {
        final decoded = responseBody as Map;
        return decoded['request_token'] as String;
      },
    );

    return res.when(
      _handleHttpFailure,
      (token) => Either.right(token),
    );
  }

  Future<Either<SignInFailure, String>> createRequestWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final res = await _http.request(
      '/authentication/token/validate_with_login',
      (responseBody) {
        final decoded = responseBody as Map;
        return decoded['request_token'] as String;
      },
      method: HttpMethod.post,
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );

    return res.when(
      _handleHttpFailure,
      (newToken) => Either.right(newToken),
    );
  }

  Future<Either<SignInFailure, String>> createSession(String token) async {
    final res = await _http.request(
      '/authentication/session/new',
      (responseBody) {
        final decoded = responseBody as Map;
        return decoded['session_id'];
      },
      method: HttpMethod.post,
      body: {'request_token': token},
    );

    return res.when(
      _handleHttpFailure,
      (sessionId) => Either.right(sessionId),
    );
  }
}
