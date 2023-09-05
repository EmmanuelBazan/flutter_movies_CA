import 'dart:convert';
import 'dart:io';

import 'package:flutter_movies_ca/app/domain/either.dart';
import 'package:flutter_movies_ca/app/domain/enums.dart';
import 'package:http/http.dart';

class AuthenticationAPI {
  final Client _client;
  final String _urlBase = 'https://api.themoviedb.org/3';
  final String _apiKey = '7de4526afb410af4f76b69c33bcdc202';

  AuthenticationAPI(this._client);

  Future<String?> createRequestToken() async {
    try {
      final res = await _client.get(
        Uri.parse('$_urlBase/authentication/token/new?api_key=$_apiKey'),
      );

      if (res.statusCode == 200) {
        final decoded = Map<String, dynamic>.from(jsonDecode(res.body));
        return decoded['request_token'];
      }

      return null;
    } catch (e) {
      print('🚨🚨🚨 AUTHENTICATION API $e');
      return null;
    }
  }

  Future<Either<SignInFailure, String>> createRequestWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    try {
      final res = await _client.post(
        Uri.parse(
            '$_urlBase/authentication/token/validate_with_login?api_key=$_apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'request_token': requestToken,
        }),
      );

      switch (res.statusCode) {
        case 200:
          final token = Map.from(jsonDecode(res.body));
          return Either.right(token['request_token']);

        case 401:
          return Either.left(SignInFailure.unauthorized);

        case 404:
          return Either.left(SignInFailure.notFound);

        default:
          return Either.left(SignInFailure.unknown);
      }
    } catch (e) {
      if (e == SocketException) {
        return Either.left(SignInFailure.network);
      }

      return Either.left(SignInFailure.unknown);
    }
  }
}
