import 'dart:async';

import 'package:control/src/state_controller.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier, Listenable;
import 'package:meta/meta.dart';

@internal
abstract interface class IController implements Listenable {
  bool get isDisposed;

  bool get isProcessing;

  void dispose();

  void handle(Future<void> Function() handler);
}

abstract interface class IControlObserver {
  void onCreate(Controller controller);

  void onDispose(Controller controller);

  void onHandler(Object context);

  void onStateChanged<S extends Object>(StateController<S> controller, S prevState, S nextState);

  void onError(Controller controller, Object error, StackTrace stackTrace);
}

abstract base class Controller with ChangeNotifier implements IController {
  Controller() {
    runZonedGuarded<void>(() => Controller.observer?.onCreate(this), (error, stackTrace) {
      /* ignore */
    });
  }

  static IControlObserver? observer;

  @override
  bool get isDisposed => _isDisposed;
  bool _isDisposed = false;

  @protected
  void onError(Object error, StackTrace stackTrace) {
    runZonedGuarded<void>(() => Controller.observer?.onError(this, error, stackTrace), (error, stackTrace) {
      /* ignore */
    });
  }

  @protected
  @override
  Future<void> handle(Future<void> Function() handler);

  @protected
  @nonVirtual
  @override
  void notifyListeners() {
    if (_isDisposed) {
      assert(false, 'A $runtimeType was disposed');
      return;
    }
    super.notifyListeners();
  }

  @override
  @mustCallSuper
  void dispose() {
    if (_isDisposed) {
      assert(false, 'A $runtimeType was disposed');
      return;
    }

    _isDisposed = true;
    runZonedGuarded<void>(() => Controller.observer?.onDispose(this), (error, stackTrace) {
      /* ignore */
    });
    super.dispose();
  }
}
