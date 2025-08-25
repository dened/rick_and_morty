import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

/// {@template card_item}
/// CardItem widget.
/// {@endtemplate}
class CardItem extends StatefulWidget {
  /// {@macro card_item}
  const CardItem({
    super.key, // ignore: unus
    this.onTap,
    this.imageUrl = 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    this.name = 'Rick Sanchez',
    this.status = Status.alive,
    this.species = 'Human',
    this.location = 'Earth (C-137)', // ignore: unused_element
  });

  final VoidCallback? onTap;
  final String imageUrl;
  final String name;
  final Status status;
  final String species;
  final String location;

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool _isPressed = false;

  void _onPressed(bool pressed) {
    if (_isPressed == pressed) return;
    setState(() {
      _isPressed = pressed;
    });
  }

  Color _borderColor(BuildContext context) =>
      _isPressed ? Theme.of(context).custom.ring : Theme.of(context).custom.border;

  @override
  Widget build(BuildContext context) => OnHoverScaleTransitionWrapper(
    scale: 1.02,
    child: Card.outlined(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: _borderColor(context), width: 3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: widget.onTap,
        onTapDown: (_) => _onPressed(true),
        onTapUp: (_) => _onPressed(false),
        onTapCancel: () => _onPressed(false),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Ink(
                    padding: const EdgeInsets.all(60),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      image: DecorationImage(image: NetworkImage(widget.imageUrl), fit: BoxFit.cover),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: <Widget>[
                      AppText.titleMedium(widget.name),
                      StatusWidget(status: widget.status),
                      AppText.labelLarge(widget.species),
                      AppText.labelMedium(widget.location),
                    ],
                  ),
                ),
              ],
            ),

            const Align(
              alignment: Alignment.topRight,
              child: Padding(padding: EdgeInsets.all(16), child: FavoriteIcon()),
            ),
          ],
        ),
      ),
    ),
  );
}

enum Status { alive, dead, unknown }

/// {@template card_item}
/// StatusWidget widget.
/// {@endtemplate}
class StatusWidget extends StatelessWidget {
  /// {@macro card_item}
  const StatusWidget({
    required this.status,
    super.key, // ignore: unused_element
  });

  final Status status;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: status == Status.alive
          ? Theme.of(context).colorScheme.primary.withAlpha(100)
          : Theme.of(context).colorScheme.error.withAlpha(100),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: AppText.labelMedium(status == Status.alive ? 'Alive' : 'Dead'),
    ),
  );
}

/// {@template card_item}
/// FavoriteIcon widget.
/// {@endtemplate}
class FavoriteIcon extends StatefulWidget {
  /// {@macro card_item}
  const FavoriteIcon({
    super.key, // ignore: unused_element
  });

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

/// State for widget FavoriteIcon.
class _FavoriteIconState extends State<FavoriteIcon> {
  bool _isFavorite = false;
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    // Initial state initialization
  }

  @override
  void didUpdateWidget(covariant FavoriteIcon oldWidget) {
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

  void _onFavoriteChanged(bool isFavorite) {
    setState(() {
      _isFavorite = isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: () => _onFavoriteChanged(!_isFavorite),
    icon: AnimatedFavIcon(isFavorite: _isFavorite),
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

/// {@template card_item}
/// OnHoverScaleTransitionWrapper widget.
/// {@endtemplate}
class OnHoverScaleTransitionWrapper extends StatefulWidget {
  /// {@macro card_item}
  const OnHoverScaleTransitionWrapper({
    required this.child,
    this.scale = 1.02,
    this.duration = const Duration(milliseconds: 150),
    this.curve = Curves.easeInOut,
    super.key, // ignore: unused_element
  });

  /// The widget below this widget in the tree.
  final Widget child;

  final double scale;
  final Duration duration;
  final Curve curve;

  @override
  State<OnHoverScaleTransitionWrapper> createState() => _OnHoverScaleTransitionWrapperState();
}

/// State for widget OnHoverScaleTransitionWrapper.
class _OnHoverScaleTransitionWrapperState extends State<OnHoverScaleTransitionWrapper>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Animation<double>? _animation;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _initAnimation(widget.scale, widget.curve);
  }

  void _initAnimation(double scale, Curve curve) {
    _animation = Tween<double>(begin: 1, end: widget.scale).animate(CurvedAnimation(parent: _controller, curve: curve));
  }

  @override
  void didUpdateWidget(covariant OnHoverScaleTransitionWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scale != oldWidget.scale || widget.curve != oldWidget.curve) {
      _initAnimation(widget.scale, widget.curve);
    }
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
    }
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
    _controller.dispose();
    _animation = null;
    super.dispose();
  }
  /* #endregion */

  void _onHover(bool isHovering) {
    if (isHovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (event) => _onHover(true),
    onExit: (event) => _onHover(false),

    child: ScaleTransition(scale: _animation!, child: widget.child),
  );
}
