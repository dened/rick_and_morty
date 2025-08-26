import 'package:flutter/material.dart';

/// {@template card_item}
/// FavoriteIcon widget.
/// {@endtemplate}
class FavoriteItemListIcon extends StatelessWidget {
  /// {@macro card_item}
  const FavoriteItemListIcon({
    required this.value,
    required this.onChanged,
    super.key, // ignore: unused_element
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: () => onChanged(!value),
    icon: AnimatedFavIcon(isFavorite: value),
    style: IconButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
    ),
  );
}

/// {@template card_item}
/// AnimatedFavIcon widget.
/// {@endtemplate}
class AnimatedFavIcon extends StatefulWidget {
  /// {@macro card_item}
  const AnimatedFavIcon({
    required this.isFavorite,
    super.key, // ignore: unused_element
  });

  final bool isFavorite;

  @override
  State<AnimatedFavIcon> createState() => _AnimatedFavIconState();
}

/// State for widget AnimatedFavIcon.
class _AnimatedFavIconState extends State<AnimatedFavIcon> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1.5), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 1.5, end: 1), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(covariant AnimatedFavIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFavorite && !oldWidget.isFavorite) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
    scale: _animation,
    child: Icon(
      widget.isFavorite ? Icons.favorite : Icons.favorite_border,
      color: widget.isFavorite ? Theme.of(context).colorScheme.error : null,
      size: 16,
    ),
  );
}
