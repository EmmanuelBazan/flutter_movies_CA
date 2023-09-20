import 'package:equatable/equatable.dart';

class SignInState extends Equatable {
  final String username, password;
  final bool loading;

  SignInState({
    this.username = '',
    this.password = '',
    this.loading = false,
  });

  SignInState copyWith({
    String? username,
    String? password,
    bool? loading,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        loading,
      ];
}
