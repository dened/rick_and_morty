import 'package:flutter/widgets.dart';


/// {@template authentication_scope}
/// AuthenticationScope widget.
/// {@endtemplate}
class AuthenticationScope extends InheritedWidget {
  /// {@macro authentication_scope}
  const AuthenticationScope({
    required super.child,
    super.key, // ignore: unused_element
  });
  
  @override
  bool updateShouldNotify(covariant AuthenticationScope oldWidget) =>
    false;
}
