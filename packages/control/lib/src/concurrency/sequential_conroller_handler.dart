import 'dart:async';
import 'dart:collection';

import 'package:control/src/controller.dart';
import 'package:meta/meta.dart';

base mixin SequentialConrollerHandler on Controller {
  final _ControllerEventQueue _eventQueue = _ControllerEventQueue();

  @override
  @nonVirtual
  bool get isProcessing => _eventQueue.length > 0;

  @override
  @protected
  @mustCallSuper
  Future<void> handle(Future<void> Function() handler) async => _eventQueue
      .push<void>(() {
        final completer = Completer<void>();
        // var isDone = false;

        Future<void> onError(Object e, StackTrace st) async {
          if (isDisposed) return;
          try {
            super.onError(e, st);
          } on Object catch (error, stackTrace) {
            super.onError(error, stackTrace);
          }
        }

        Future<void> handleZoneError(Object error, StackTrace stackTrace) async {
          if (isDisposed) return;
          super.onError(error, stackTrace);
        }

        void onDone() {
          if (completer.isCompleted) return;
          completer.complete();
        }

        runZonedGuarded<void>(() async {
          try {
            if (isDisposed) return;
            Controller.observer?.onHandler(this);
            await handler();
          } on Object catch (error, stackTrace) {
            await onError(error, stackTrace);
          } finally {
            // isDone = true;
            onDone();
          }
        }, handleZoneError);

        return completer.future;
      })
      .catchError((_, _) => null);
}

final class _ControllerEventQueue {
  _ControllerEventQueue();

  final DoubleLinkedQueue<_SequentalTask<Object?>> _queue = DoubleLinkedQueue<_SequentalTask<Object?>>();

  Future<void>? _processing;

  bool _isClosed = false;

  int get length => _queue.length;

  Future<T> push<T>(Future<T> Function() fn) {
    final task = _SequentalTask(fn);
    _queue.add(task);
    _exec();
    return task.future;
  }

  Future<void> close() async {
    _isClosed = true;
    await _processing;
  }

  Future<void> _exec() => _processing ??= Future.doWhile(() async {
    final event = _queue.first;
    try {
      if (_isClosed) {
        event.reject(StateError('Controller\'s event queue is disposed'), StackTrace.current);
      } else {
        await event();
      }
    } on Object catch (error, stackTrace) {
      Future<void>.sync(() => event.reject(error, stackTrace)).ignore();
    }
    _queue.removeFirst();
    final isEmpty = _queue.isEmpty;
    if (isEmpty) _processing = null;
    return !isEmpty;
  });
}

final class _SequentalTask<T> {
  _SequentalTask(Future<T> Function() task) : _task = task, _completer = Completer<T>();
  final Completer<T> _completer;

  final Future<T> Function() _task;

  Future<T> get future => _completer.future;

  Future<T> call() async {
    final result = await _task();
    if (!_completer.isCompleted) {
      _completer.complete(result);
    }

    return result;
  }

  void reject(Object error, [StackTrace? stackTrace]) {
    if (_completer.isCompleted) return;

    _completer.completeError(error, stackTrace);
  }
}
