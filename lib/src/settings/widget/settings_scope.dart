import 'package:flutter/widgets.dart';


/// {@template settings_scope}
/// SettingsScope widget.
/// {@endtemplate}
class SettingsScope extends InheritedWidget {
  /// {@macro settings_scope}
  const SettingsScope({
    required super.child,
    super.key, // ignore: unused_element
  });
  
  @override
  bool updateShouldNotify(covariant SettingsScope oldWidget) =>
    false;
}
