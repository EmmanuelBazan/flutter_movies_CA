import 'package:flutter/foundation.dart';

abstract class StateNotifier<T> extends ChangeNotifier {
  T _state;
  bool _mounted = true;

  T get state => _state;
  bool get mounted => _mounted;

  set state(T newState) {
    _updateState(newState);
  }

  StateNotifier(this._state);

  void onlyUpdate(T newState) {
    _updateState(newState, notify: false);
  }

  void _updateState(T state, {bool notify = true}) {
    if (_state != state) {
      _state = state;
      if (notify) notifyListeners();
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
