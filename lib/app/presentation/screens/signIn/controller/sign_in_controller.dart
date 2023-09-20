import 'package:flutter_movies_ca/app/presentation/global/widgets/state_notifier.dart';
import 'package:flutter_movies_ca/app/presentation/screens/signIn/controller/sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController(super.state);

  void onUserNameChanged(String text) {
    onlyUpdate(
      state.copyWith(
        username: text.trim(),
      ),
    );
  }

  void onPasswordChanged(String text) {
    onlyUpdate(
      state.copyWith(
        password: text.replaceAll(' ', ''),
      ),
    );
  }

  void onLoadingChanged(bool value) {
    state = state.copyWith(loading: value);
  }
}
