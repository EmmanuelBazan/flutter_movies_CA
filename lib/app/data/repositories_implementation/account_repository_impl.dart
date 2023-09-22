import 'package:flutter_movies_ca/app/data/services/local/session_service.dart';
import 'package:flutter_movies_ca/app/data/services/remote/account_api.dart';
import 'package:flutter_movies_ca/app/domain/models/user.dart';
import 'package:flutter_movies_ca/app/domain/repositories/account_repository.dart';

class AccountRepositoryImpl extends AccountRepository {
  final AccountApi _accountApi;
  final SessionService _sessionService;

  AccountRepositoryImpl(
    this._accountApi,
    this._sessionService,
  );

  @override
  Future<UserModel?> getUserData() async {
    final sessionId = await _sessionService.sessionId;
    final res = await _accountApi.getAccount(sessionId ?? '');
    return res;
  }
}
