import 'dart:async';

import 'package:control/src/controller.dart';
import 'package:flutter/foundation.dart';

typedef StateControllerSelector<S extends Object, Value> = Value Function(S state);

typedef StateControllerFilter<Value> = bool Function(Value prev, Value next);

@internal
abstract interface class IStateController<S extends Object> implements IController {
  S get state;
}

abstract base class StateController<S extends Object> extends Controller implements IStateController<S> {
  StateController({required S initialState}) : _state = initialState;

  @override
  @nonVirtual
  S get state => _state;
  S _state;

  @protected
  @mustCallSuper
  void setState(S state) {
    runZonedGuarded(() => Controller.observer?.onStateChanged<S>(this, _state, state), (error, stackTrace) {
      /* ignore */
    });

    _state = state;
    if (isDisposed) return;
    notifyListeners();
  }

  ValueListenable<Value> select<Value>(
    StateControllerSelector<S, Value> selector, [
    StateControllerFilter<Value>? test,
  ]) => _StateControllerValueListenableSelect(this, selector, test);
}

final class _StateControllerValueListenableSelect<S extends Object, Value>
    with ChangeNotifier
    implements ValueListenable<Value> {
  _StateControllerValueListenableSelect(this._controller, this._selector, this._test);

  final IStateController<S> _controller;
  final StateControllerSelector<S, Value> _selector;
  final StateControllerFilter<Value>? _test;
  bool get _isDisposed => _controller.isDisposed;
  bool _subscribed = false;

  late Value _value = _selector(_controller.state);

  @override
  Value get value => _subscribed ? _value : _selector(_controller.state);

  void _update() {
    final newValue = _selector(_controller.state);
    if (identical(_value, newValue)) return;

    if (!(_test?.call(_value, newValue) ?? true)) return;

    _value = newValue;
    notifyListeners();
  }

  @override
  void addListener(VoidCallback listener) {
    if (_isDisposed) return;
    if (!_subscribed) {
      _value = _selector(_controller.state);
      _controller.addListener(_update);
      _subscribed = true;
    }
    super.addListener(listener);
  }

  @override
  void dispose() {
    _controller.removeListener(_update);
    _subscribed = false;
  
    super.dispose();
  }
}
