import 'package:flutter/foundation.dart';

class SignInController extends ChangeNotifier {
  String _username = '', _password = '';
  bool _loading = false;

  String get username => _username;
  String get password => _password;
  bool get loading => _loading;

  void onUserNameChanged(String text) {
    _username = text.trim();
  }

  void onPasswordChanged(String text) {
    _password = text.replaceAll(' ', '');
  }

  void onLoadingChanged(bool value) {
    _loading = value;
    notifyListeners();
  }
}
