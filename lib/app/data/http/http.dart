import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_movies_ca/app/domain/either.dart';
import 'package:http/http.dart';

part 'failure.dart';

class Http {
  final String _baseUrl;
  final Client _client;
  final String _apiKey;

  Http({
    required String baseUrl,
    required Client client,
    required String apiKey,
  })  : _baseUrl = baseUrl,
        _apiKey = apiKey,
        _client = client;

  Future<Either<HttpFailure, T>> request<T>(
    String path,
    T Function(dynamic responseBody) onSuccess, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    bool useApiKey = true,
  }) async {
    Map<String, dynamic> logs = {};
    StackTrace? stackTrace;
    try {
      queryParameters = {
        ...queryParameters,
        'api_key': _apiKey,
      };

      Uri url = Uri.parse('$_baseUrl$path');
      if (queryParameters.isNotEmpty) {
        url = url.replace(queryParameters: queryParameters);
      }

      headers = {'Content-Type': 'application/json', ...headers};

      final bodyString = jsonEncode(body);

      logs = {
        '✅ url': url.toString(),
        '✅ method': method.toString(),
        '✅ body': body.toString(),
      };

      late final Response response;
      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;

        case HttpMethod.post:
          response =
              await _client.post(url, headers: headers, body: bodyString);
          break;

        case HttpMethod.patch:
          response =
              await _client.patch(url, headers: headers, body: bodyString);
          break;

        case HttpMethod.delete:
          response =
              await _client.delete(url, headers: headers, body: bodyString);
          break;

        case HttpMethod.put:
          response = await _client.put(url, headers: headers, body: bodyString);
          break;
      }

      final statusCode = response.statusCode;

      final decodedRes = _parseResponseBody(response.body);

      logs = {
        ...logs,
        '✅ statusCode': statusCode,
        '✅ response': decodedRes,
      };

      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(onSuccess(decodedRes));
      }

      return Either.left(HttpFailure(statuscode: statusCode));
    } catch (e, s) {
      stackTrace = s;
      logs = {
        ...logs,
        '🚨🚨🚨 exception': e.runtimeType,
      };

      if (e is SocketException || e is ClientException) {
        logs = {
          ...logs,
          '🚨🚨🚨 exception': 'NetworkException',
        };
        return Either.left(HttpFailure(exception: NetworkException()));
      }

      return Either.left(HttpFailure(exception: e));
    } finally {
      if (kDebugMode) {
        log(
          '''--------------------------------------${const JsonEncoder.withIndent(' ').convert(logs)}--------------------------------------''',
          stackTrace: stackTrace,
        );
      }
    }
  }
}

enum HttpMethod {
  get,
  post,
  patch,
  delete,
  put,
}

dynamic _parseResponseBody(String responseBody) {
  try {
    return jsonDecode(responseBody);
  } catch (e) {
    return responseBody;
  }
}
