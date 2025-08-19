import 'package:flutter/material.dart';
import 'package:rick_and_morty/src/_core/app_navigator.dart';
import 'package:rick_and_morty/src/home_screen/widget/character_tab.dart';
import 'package:rick_and_morty/src/home_screen/widget/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  /// {@macro home_screen}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> pages = [const CharacterTab(), const SettingsTab()];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Home'),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () => AppNavigator.push(context, Routes.settings.page()),
        ),
      ],
    ),
    body: pages[_currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      onTap: _onBottomBarTap,
      currentIndex: _currentIndex,
    ),
  );

  void _onBottomBarTap(int index) {
    if (index == _currentIndex) return;

    setState(() {
      _currentIndex = index;
    });
  }
}
