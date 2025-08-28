import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/app.dart';

/// {@template settings_screen}
/// SettingsScreen widget.
/// {@endtemplate}
class SettingsTab extends StatelessWidget {
  /// {@macro settings_screen}
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      const Text('Settings'),
      ValueListenableBuilder<ThemeMode>(
        valueListenable: App.maybeOf(context)!.themeMode,
        builder: (context, value, child) => SwitchListTile(
          value: value == ThemeMode.light,
          title: const Text('Theme'),
          onChanged: (value) => App.maybeOf(context)?.setTheme(value ? ThemeMode.light : ThemeMode.dark),
        ),
      ),
    ],
  );
}
