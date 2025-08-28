import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/src/_core/app_navigator.dart';
import 'package:rick_and_morty/src/auth/widget/authentication_scope.dart';
import 'package:rick_and_morty/src/home_screen/controller/character_list_controller.dart';
import 'package:rick_and_morty/src/home_screen/controller/favorites_list_controller.dart';
import 'package:rick_and_morty/src/initialization/dependencies.dart';
import 'package:ui/ui.dart' as theme show darkTheme, lightTheme;

/// App widget.
class App extends StatefulWidget {
  /// {@macro app}
  const App({
    super.key, // ignore: unused_element
  });

  /// The state from the closest instance of this class
  /// that encloses the given context, if any.
  @internal
  static AppState? maybeOf(BuildContext context) => context.findAncestorStateOfType<AppState>();

  @override
  State<App> createState() => AppState();
}

/// State for widget App.
class AppState extends State<App> {
  final Key _builderKey = GlobalKey();

  final ValueNotifier<ThemeMode> _themeModeNotifier = ValueNotifier(ThemeMode.light);

  ValueNotifier<ThemeMode> get themeMode => _themeModeNotifier;

  final ThemeData _lightTheme = theme.lightTheme();
  final ThemeData _darkTheme = theme.darkTheme();

  late final AppNavigator _navigator;

  late final OverlayEntry _scopes = OverlayEntry(
    builder: (context) => AuthenticationScope(
      child: ControllerScope<FavoritesListController>(
        () => FavoritesListController(repository: Dependencies.of(context).favoritesRepository),
        child: ControllerScope<CharacterListController>(
          () => CharacterListController(repository: Dependencies.of(context).apiRepository),
          child: _navigator,
        ),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _navigator = AppNavigator.controlled(
      controller: Dependencies.of(context).navigator,
      key: const ValueKey('app-navigator'),
    );
  }

  void setTheme(ThemeMode themeMode) {
    if (_themeModeNotifier.value == themeMode) return;
    _themeModeNotifier.value = themeMode;
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<ThemeMode>(
    valueListenable: _themeModeNotifier,
    builder: (context, value, child) => MaterialApp(
      themeMode: value,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      builder: (context, child) => Overlay(key: _builderKey, clipBehavior: Clip.none, initialEntries: [_scopes]),
    ),
  );
}
