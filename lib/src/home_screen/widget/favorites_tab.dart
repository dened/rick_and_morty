import 'package:flutter/widgets.dart';
import 'package:ui/ui.dart';

class FavoritesString {
  static const String noFavoritesTitle = 'No favorites yet';
  static const String noFavoritesMessage = ' Add some characters to your favorites list! \nPress ❤️ in list';
}

/// {@template favorites_tab}
/// FavoritesTab widget.
/// {@endtemplate}
class FavoritesTab extends StatefulWidget {
  /// {@macro favorites_tab}
  const FavoritesTab({
    super.key, // ignore: unused_element
  });

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

/// State for widget FavoritesTab.
class _FavoritesTabState extends State<FavoritesTab> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotateAnimation;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(_controller);
    _rotateAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: -0.02, end: 0.02), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.02, end: -0.02), weight: 1),
    ]).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant FavoritesTab oldWidget) {
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
    _controller.dispose();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RotationTransition(
          turns: _rotateAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: const Text('💔', style: TextStyle(fontSize: 100)),
          ),
        ),
        const AppText.headlineMedium(FavoritesString.noFavoritesTitle),
        const SizedBox(height: 16),
        const AppText.bodyLarge(FavoritesString.noFavoritesMessage, maxLines: 4),
      ],
    ),
  );
}
