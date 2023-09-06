import 'dart:convert';

import 'package:flutter_movies_ca/app/data/http/http.dart';
import 'package:flutter_movies_ca/app/domain/either.dart';
import 'package:flutter_movies_ca/app/domain/enums.dart';

class AuthenticationAPI {
  final Http _http;

  AuthenticationAPI(this._http);

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final res = await _http.request('/authentication/token/new');

    return res.when(
      (failure) {
        if (failure.exception is NetworkException) {
          return Either.left(SignInFailure.network);
        }

        return Either.left(SignInFailure.unknown);
      },
      (responseBody) {
        final decoded = jsonDecode(responseBody);
        return Either.right(decoded['request_token'] as String);
      },
    );
  }

  Future<Either<SignInFailure, String>> createRequestWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final res = await _http.request(
      '/authentication/token/validate_with_login',
      method: HttpMethod.post,
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );

    return res.when(
      (failure) {
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
      },
      (responseBody) {
        final decoded = jsonDecode(responseBody);

        return Either.right(decoded['request_token'] as String);
      },
    );
  }

  Future<Either<SignInFailure, String>> createSession(String token) async {
    final res = await _http.request(
      '/authentication/session/new',
      method: HttpMethod.post,
      body: {'request_token': token},
    );

    return res.when(
      (failure) {
        if (failure.exception is NetworkException) {
          return Either.left(SignInFailure.network);
        }

        return Either.left(SignInFailure.unknown);
      },
      (responseBody) {
        final decoded = jsonDecode(responseBody);
        return Either.right(decoded['session_id']);
      },
    );
  }
}
