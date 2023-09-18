import 'package:flutter/foundation.dart';
import 'package:flutter_movies_ca/app/presentation/screens/signIn/controller/sign_in_state.dart';

class SignInController extends ChangeNotifier {
  SignInState _state = SignInState();

  bool _mounted = true;

  SignInState get state => _state;
  bool get mounted => _mounted;

  void onUserNameChanged(String text) {
    _state = _state.copyWith(
      username: text.trim(),
    );
  }

  void onPasswordChanged(String text) {
    _state = _state.copyWith(
      password: text.replaceAll(' ', ''),
    );
  }

  void onLoadingChanged(bool value) {
    _state = _state.copyWith(
      loading: value,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
