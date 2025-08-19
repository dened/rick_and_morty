import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:rick_and_morty/src/_core/app_navigator.dart';
import 'package:rick_and_morty/src/data_source/api_repository.dart';
import 'package:rick_and_morty/src/data_source/remote_data_repository.dart';
import 'package:rick_and_morty/src/database.dart';

class Dependencies {
  /// Inject dependencies into the widget tree.
  Widget inject({required Widget child}) => InheritedDependencies(dependencies: this, child: child);

  /// Get dependecies from BuildContext
  static Dependencies of(BuildContext context) => InheritedDependencies.of(context);

  late final Database db;

  late final RemoteDataRepository remoteDataRepository;

  late final ValueNotifier<NavigationState> navigator;

  late final HttpClient client;

  late final IApiRepository apiRepository;
}

/// {@template dependencies}
/// InheritedDependencies widget.
/// {@endtemplate}
class InheritedDependencies extends InheritedWidget {
  /// {@macro dependencies}
  const InheritedDependencies({required this.dependencies, required super.child, super.key});

  final Dependencies dependencies;

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  /// e.g. `Dependencies.maybeOf(context)`.
  static Dependencies? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<InheritedDependencies>()?.dependencies;

  static Never _notFoundInheritedWidgetOfExactType() => throw ArgumentError(
    'Out of scope, not found inherited widget '
        'a InheritedDependencies of the exact type',
    'out_of_scope',
  );

  /// The state from the closest instance of this class
  /// that encloses the given context.
  /// e.g. `Dependencies.of(context)`
  static Dependencies of(BuildContext context) => maybeOf(context) ?? _notFoundInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(covariant InheritedDependencies oldWidget) => false;
}
