import 'package:flutter_movies_ca/app/domain/either.dart';
import 'package:flutter_movies_ca/app/domain/enums.dart';
import 'package:flutter_movies_ca/app/domain/models/user.dart';
import 'package:flutter_movies_ca/app/domain/repositories/authentication_repository.dart';
import 'package:flutter_movies_ca/app/presentation/global/widgets/state_notifier.dart';
import 'package:flutter_movies_ca/app/presentation/screens/signIn/controller/sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  final AuthenticationRepository authenticationRepository;

  SignInController(
    super.state, {
    required this.authenticationRepository,
  });

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

  Future<Either<SignInFailure, User>> submit() async {
    state = state.copyWith(loading: true);
    final res = await authenticationRepository.signIn(
      state.username,
      state.password,
    );

    res.when(
      (p0) => state = state.copyWith(loading: false),
      (p0) => null,
    );

    return res;
  }
}
