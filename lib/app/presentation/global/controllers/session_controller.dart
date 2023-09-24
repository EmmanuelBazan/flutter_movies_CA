import 'package:flutter_movies_ca/app/domain/models/user.dart';
import 'package:flutter_movies_ca/app/presentation/global/widgets/state_notifier.dart';

class SessionController extends StateNotifier<UserModel?> {
  SessionController() : super(null);

  void setUser(UserModel user) {
    state = user;
  }

  void signOut() {
    state = null;
  }
}
