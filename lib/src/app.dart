import 'package:control/control.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/src/_core/app_navigator.dart';
import 'package:rick_and_morty/src/auth/widget/authentication_scope.dart';
import 'package:rick_and_morty/src/home_screen/controller/character_list_controller.dart';
import 'package:rick_and_morty/src/home_screen/controller/favorites_list_controller.dart';
import 'package:rick_and_morty/src/initialization/dependencies.dart';
import 'package:rick_and_morty/src/settings/widget/settings_scope.dart';
import 'package:ui/ui.dart' as ui;

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

  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  final ThemeData _lightTheme = ui.lightTheme();
  final ThemeData _darkTheme = ui.darkTheme();

  late final AppNavigator _navigator;

  late final OverlayEntry _scopes = OverlayEntry(
    builder: (context) => AuthenticationScope(
      child: SettingsScope(
        child: ControllerScope<FavoritesListController>(
          () => FavoritesListController(repository: Dependencies.of(context).favoritesRepository),
          child: ControllerScope<CharacterListController>(
            () => CharacterListController(repository: Dependencies.of(context).apiRepository),
            child: _navigator,
          ),
        ),
      ),
    ),
  );

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _navigator = AppNavigator.controlled(
      controller: Dependencies.of(context).navigator,
      key: const ValueKey('app-navigator'),
    );
  }

  void setTheme(ThemeMode themeMode) {
    if (_themeMode == themeMode) return;
    setState(() => _themeMode = themeMode);
  }

  @override
  void didUpdateWidget(covariant App oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Widget configuration changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // The configuration of InheritedWidgets has changed
    // Also called after initState but before build
  }

  @override
  void dispose() {
    // Permanent removal of a tree stent
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => MaterialApp(
    themeMode: _themeMode,
    theme: _lightTheme,
    darkTheme: _darkTheme,
    builder: (context, child) => Overlay(key: _builderKey, clipBehavior: Clip.none, initialEntries: [_scopes]),
  );
}
