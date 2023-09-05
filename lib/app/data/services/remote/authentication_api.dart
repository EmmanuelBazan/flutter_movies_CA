import 'dart:convert';

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
}
