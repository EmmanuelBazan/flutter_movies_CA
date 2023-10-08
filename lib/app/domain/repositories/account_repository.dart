import 'package:flutter_movies_ca/app/domain/models/user/user.dart';

abstract class AccountRepository {
  Future<UserModel?> getUserData();
}
