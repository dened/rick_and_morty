import 'package:flutter/widgets.dart';

/// {@template favorites_tab}
/// BrokenHeartWidget widget.
/// {@endtemplate}
class BrokenHeartWidget extends StatefulWidget {
  /// {@macro favorites_tab}
  const BrokenHeartWidget({
    super.key, // ignore: unused_element
  });

  @override
  State<BrokenHeartWidget> createState() => _BrokenHeartWidgetState();
}

/// State for widget BrokenHeartWidget.
class _BrokenHeartWidgetState extends State<BrokenHeartWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _rotateAnimation;

  /* #region Lifecycle */
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _scaleAnimation = Tween<double>(begin: 1, end: 1.2).animate(_controller);
    _rotateAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: -0.02, end: 0.02), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.02, end: -0.02), weight: 1),
    ]).animate(_controller);

    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => RotationTransition(
    turns: _rotateAnimation,
    child: ScaleTransition(
      scale: _scaleAnimation,
      child: const Text('💔', style: TextStyle(fontSize: 96)),
    ),
  );
}
