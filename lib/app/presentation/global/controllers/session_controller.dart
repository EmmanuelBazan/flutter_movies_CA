import 'package:flutter_movies_ca/app/domain/models/user/user.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_movies_ca/app/presentation/global/widgets/state_notifier.dart';

class SessionController extends StateNotifier<UserModel?> {
  final AuthenticationRepository authenticationRepository;

  SessionController(this.authenticationRepository) : super(null);

  void setUser(UserModel user) {
    state = user;
  }

  Future<void> signOut() async {
    await authenticationRepository.signOut();
    onlyUpdate(null);
  }
}
