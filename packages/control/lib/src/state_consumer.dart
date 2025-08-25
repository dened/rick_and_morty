import 'package:control/src/controller_scope.dart';
import 'package:control/src/state_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

typedef StateConsumerListener<C extends IStateController<S>, S extends Object> =
    void Function(BuildContext context, C controller, S previous, S current);

typedef StateConsumerCondition<S extends Object> = bool Function(S previous, S current);

typedef StateConsumerBuilder<S extends Object> = Widget Function(BuildContext context, S state, Widget? child);

/// {@template state_consumer}
/// StateConsumer widget.
/// {@endtemplate}
class StateConsumer<C extends IStateController<S>, S extends Object> extends StatefulWidget {
  /// {@macro state_consumer}
  const StateConsumer({this.controller, this.listener, this.buildWhen, this.builder, this.child, super.key});

  final C? controller;

  final StateConsumerListener<C, S>? listener;

  final StateConsumerCondition<S>? buildWhen;

  final StateConsumerBuilder<S>? builder;

  final Widget? child;

  @override
  State<StateConsumer> createState() => _StateConsumerState<C, S>();
}

/// State for widget StateConsumer.
class _StateConsumerState<C extends IStateController<S>, S extends Object> extends State<StateConsumer<C, S>> {
  late C _controller;
  late S _previousState;

  @override
  void didUpdateWidget(covariant StateConsumer<C, S> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldController = oldWidget.controller;
    final newController = widget.controller;
    if (identical(oldController, newController) || oldController == newController) return;

    _unsubscribe();

    _controller = newController ?? ControllerScope.of<C>(context, listen: false);
    _previousState = _controller.state;
    _subscribe();
  }

  @override
  void didChangeDependencies() {
    _controller = widget.controller ?? ControllerScope.of<C>(context, listen: false);
    _previousState = _controller.state;
    _subscribe();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() => _controller.addListener(_valueChanged);

  void _unsubscribe() {
    if (_controller.isDisposed) return;
    _controller.removeListener(_valueChanged);
  }

  void _valueChanged() {
    final oldState = _previousState;
    final newState = _controller.state;

    if (!mounted || identical(oldState, newState)) return;

    _previousState = newState;
    widget.listener?.call(context, _controller, oldState, newState);
    if (widget.buildWhen?.call(oldState, newState) ?? true) {
      switch (SchedulerBinding.instance.schedulerPhase) {
        case SchedulerPhase.idle:
        case SchedulerPhase.transientCallbacks:
        case SchedulerPhase.postFrameCallbacks:
          setState(() {});
          break;
        case SchedulerPhase.persistentCallbacks:
        case SchedulerPhase.midFrameMicrotasks:
          SchedulerBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            setState(() {});
          });
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder?.call(context, _controller.state, widget.child) ?? widget.child ?? const SizedBox.shrink();
}
