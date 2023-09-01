import 'package:flutter_movies_ca/app/domain/models/user.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _secureStorage;

  AuthenticationRepositoryImpl(this._secureStorage);

  @override
  Future<User?> getUserData() {
    // TODO: implement getUserData
    return Future.value(null);
  }

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _secureStorage.read(key: _key);
    return sessionId != null;
  }
}
