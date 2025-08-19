import 'package:flutter/material.dart';

sealed class AppPage extends MaterialPage<void> {
  const AppPage({
    required super.name,
    required Map<String, Object>? super.arguments,
    required LocalKey super.key,
    required super.child,
  });

  @override
  String get name => super.name ?? 'Unknown';

  @override
  Map<String, Object?> get arguments => switch(super.arguments) {
    Map<String, Object?> args when args.isNotEmpty => args,
    _ => const <String, Object?>{},
  };

  @override
  bool operator ==(Object other) => identical(this, other) || other is AppPage && other.key == key;

  @override
  int get hashCode => key.hashCode;
}
