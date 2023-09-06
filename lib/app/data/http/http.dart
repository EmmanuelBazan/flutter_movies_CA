import 'dart:io';

import 'package:flutter_movies_ca/app/domain/either.dart';
import 'package:http/http.dart';

class Http {
  final String _baseUrl;
  final String _path;
  final Client _client;
  final String _apiKey;

  Http(this._baseUrl, this._path, this._client, this._apiKey);

  Future<Either<HttpFailure, String>> request(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    bool useApiKey = true,
  }) async {
    try {
      queryParameters = {
        ...queryParameters,
        'api_key': _apiKey,
      };

      Uri url = Uri.parse('$_baseUrl$_path');
      if (queryParameters.isNotEmpty) {
        url = url.replace(queryParameters: queryParameters);
      }

      headers = {'Content-Type': 'application/json', ...headers};

      late final Response response;
      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;

        case HttpMethod.post:
          response = await _client.get(url, headers: headers);
          break;

        case HttpMethod.patch:
          response = await _client.get(url, headers: headers);
          break;

        case HttpMethod.delete:
          response = await _client.get(url, headers: headers);
          break;

        case HttpMethod.put:
          response = await _client.get(url, headers: headers);
          break;
      }

      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(response.body);
      }

      return Either.left(HttpFailure(statuscode: statusCode));
    } catch (e) {
      if (e is SocketException || e is ClientException) {
        return Either.left(HttpFailure(exception: NetworkException()));
      }

      return Either.left(HttpFailure(exception: e));
    }
  }
}

class HttpFailure {
  final int? statuscode;
  final Object? exception;

  HttpFailure({this.statuscode, this.exception});
}

class NetworkException {}

enum HttpMethod {
  get,
  post,
  patch,
  delete,
  put,
}
