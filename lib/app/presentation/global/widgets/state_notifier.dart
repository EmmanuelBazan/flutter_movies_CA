import 'package:flutter/foundation.dart';

abstract class StateNotifier<T> extends ChangeNotifier {
  T _state;
  bool _mounted = true;

  T get state => _state;
  bool get mounted => _mounted;

  StateNotifier(this._state);

  void updateState(T state, {bool notify = true}) {
    _state = state;
    if (notify) notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
