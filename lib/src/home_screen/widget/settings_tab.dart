import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/app.dart';
import 'package:ui/ui.dart';

/// {@template home_screen}
/// HomeScreen widget.
/// {@endtemplate}

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
      SwitchListTile(
        value: App.maybeOf(context)?.themeMode == ThemeMode.light,
        title: const Text('Theme'),
        onChanged: (value) => App.maybeOf(context)?.setTheme(value ? ThemeMode.light : ThemeMode.dark),
      ),

      const Padding(
        padding: EdgeInsets.all(8),
        child: SizedBox(height: 200, child: Shimmer(radius: Radius.circular(32))),
      ),
    ],
  );
}
