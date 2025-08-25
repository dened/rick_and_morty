import 'package:control/control.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

extension ControllerScopeBuildContextExtension on BuildContext {
  C controllerOf<C extends Listenable>({bool listen = false}) => ControllerScope.of<C>(this, listen: listen);
}

class ControllerScope<C extends Listenable> extends InheritedWidget {
  ControllerScope(C Function() create, {Widget? child, bool lazy = true, super.key})
    : _dependency = _ControllerDependencyCreate(create: create, lazy: lazy),
      super(child: child ?? const SizedBox.shrink());

  ControllerScope.value(C controller, {Widget? child, super.key})
    : _dependency = _ControllerDependencyValue(controller: controller),
      super(child: child ?? const SizedBox.shrink());

  final _ControllerDependency<C> _dependency;

  static C? maybeOf<C extends Listenable>(BuildContext context, {bool listen = false}) {
    final element = context.getElementForInheritedWidgetOfExactType<ControllerScope<C>>();
    if (listen && element != null) context.dependOnInheritedElement(element);

    return element is ControllerScopeElement<C> ? element.controller : null;
  }

  static Never _notFoundInheritedWidgretOfExactType() => throw ArgumentError(
    'Out of scope, not found inherited widget '
        'a ControllerScope of the exact type',
    'out_of_scope',
  );

  static C of<C extends Listenable>(BuildContext context, {bool listen = false}) =>
      maybeOf<C>(context, listen: listen) ?? _notFoundInheritedWidgretOfExactType();

  @override
  bool updateShouldNotify(covariant ControllerScope oldWidget) => _dependency != oldWidget._dependency;

  @override
  InheritedElement createElement() => ControllerScopeElement<C>(this);
}

@immutable
sealed class _ControllerDependency<C extends Listenable> {
  const _ControllerDependency();
}

@internal
final class ControllerScopeElement<C extends Listenable> extends InheritedElement {
  ControllerScopeElement(ControllerScope<C> super.widget);

  _ControllerDependency<C> get _dependency => (widget as ControllerScope<C>)._dependency;

  C? _controller;
  C get controller => _controller ??= _initController();

  Object? _state;

  bool _dirty = false;

  bool _subscribed = false;

  C _initController() {
    if (_controller != null) {
      assert(false, 'Controller already initialized');
      return controller;
    }

    return switch (_dependency) {
      _ControllerDependencyCreate<C> d => d.create(),
      _ControllerDependencyValue<C> d => d.controller,
    };
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    if (_controller == null) {
      switch (_dependency) {
        case _ControllerDependencyCreate<C> d:
          if (!d.lazy) _controller = d.create();
          break;
        case _ControllerDependencyValue<C> d:
          _controller = d.controller;
          break;
      }
    }
    super.mount(parent, newSlot);
  }

  @override
  @mustCallSuper
  void update(covariant ControllerScope<C> newWidget) {
    final oldDependency = _dependency;
    final newDependency = newWidget._dependency;

    if (!identical(oldDependency, newDependency)) {
      switch (newDependency) {
        case _ControllerDependencyCreate<C> d:
          assert(oldDependency is _ControllerDependencyCreate<C>, 'Cannot change scope type');
          if (_controller == null && !d.lazy) {
            _controller = d.create();
          }

          break;
        case _ControllerDependencyValue<C> d:
          assert(oldDependency is _ControllerDependencyValue<C>, 'Cannot change scope type');
          final newController = d.controller;
          if (!identical(_controller, newController)) {
            _controller?.removeListener(_handleUpdate);
            _controller = newController;
          }
          break;
      }
      if (_subscribed) _controller?.addListener(_handleUpdate);
    }

    super.update(newWidget);
  }

  @mustCallSuper
  void _handleUpdate() {
    final newState = switch (_controller) {
      StateController<Object?> c => c.state,
      ValueListenable<Object?> c => c.value,
      _ => null,
    };

    if (identical(_state, newState)) return;
    _state = newState;
    _dirty = true;
    markNeedsBuild();
  }

  @override
  @mustCallSuper
  void updateDependencies(Element dependent, Object? aspect) {
    if (!_subscribed) {
      _subscribed = true;
      _controller?.addListener(_handleUpdate);
    }
    super.updateDependencies(dependent, aspect);
  }

  @override
  @mustCallSuper
  void notifyClients(covariant InheritedWidget oldWidget) {
    super.notifyClients(oldWidget);
    _dirty = false;
  }

  @override
  @mustCallSuper
  void unmount() {
    final listenable = _controller;
    listenable?.removeListener(_handleUpdate);
    _subscribed = false;
    if (_dependency is _ControllerDependencyCreate<C> && listenable is ChangeNotifier) listenable.dispose();
    super.unmount();
  }

  @override
  Widget build() {
    if (_dirty && _subscribed) notifyClients(widget as ControllerScope<C>);

    return super.build();
  }
}

final class _ControllerDependencyCreate<C extends Listenable> extends _ControllerDependency<C> {
  const _ControllerDependencyCreate({required this.create, required this.lazy});

  final C Function() create;

  final bool lazy;

  @override
  int get hashCode => create.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _ControllerDependencyCreate && create == other.create;
}

final class _ControllerDependencyValue<C extends Listenable> extends _ControllerDependency<C> {
  const _ControllerDependencyValue({required this.controller});

  final C controller;

  @override
  int get hashCode => controller.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _ControllerDependencyValue && identical(controller, other.controller);
}
