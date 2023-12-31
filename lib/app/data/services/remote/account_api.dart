import 'package:flutter_movies_ca/app/data/http/http.dart';
import 'package:flutter_movies_ca/app/domain/models/user/user.dart';

class AccountApi {
  final Http _http;

  AccountApi(this._http);

  Future<UserModel?> getAccount(String sessionId) async {
    final res = await _http.request(
      '/account',
      (responseBody) => UserModel.fromMap(responseBody),
      queryParameters: {'session_id': sessionId},
    );

    return res.when(
      (_) => null,
      (user) => user,
    );
  }
}
