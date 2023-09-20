import 'package:flutter_movies_ca/app/presentation/global/widgets/state_notifier.dart';
import 'package:flutter_movies_ca/app/presentation/screens/signIn/controller/sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  SignInController(super.state);

  void onUserNameChanged(String text) {
    updateState(
      state.copyWith(
        username: text.trim(),
      ),
      notify: false,
    );
  }

  void onPasswordChanged(String text) {
    updateState(
      state.copyWith(
        password: text.replaceAll(' ', ''),
      ),
      notify: false,
    );
  }

  void onLoadingChanged(bool value) {
    updateState(state.copyWith(
      loading: value,
    ));
  }
}
