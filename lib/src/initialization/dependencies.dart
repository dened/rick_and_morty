import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/src/database.dart';

class Dependencies {
  late final Database db;

  Widget inject({required Widget child}) => InheritedDependencies(dependencies: this, child: child);
}

/// {@template dependencies}
/// Dependencies widget.
/// {@endtemplate}
class InheritedDependencies extends InheritedWidget {
  /// {@macro dependencies}
  const InheritedDependencies({
    required super.child,
    required Dependencies dependencies,

    super.key, // ignore: unused_element
  }) : _dependencies = dependencies;

  final Dependencies _dependencies;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `Dependencies.maybeOf(context)`.
  static Dependencies? maybeOf(BuildContext context, {bool listen = true}) => listen
      ? context.dependOnInheritedWidgetOfExactType<InheritedDependencies>()?._dependencies
      : context.getInheritedWidgetOfExactType<InheritedDependencies>()?._dependencies;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
    'Out of scope, not found inherited widget '
        'a InheritedDependencies of the exact type',
    'out_of_scope',
  );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `Dependencies.of(context)`
  static Dependencies of(BuildContext context, {bool listen = true}) =>
      maybeOf(context, listen: listen) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant InheritedDependencies oldWidget) => false;
}
