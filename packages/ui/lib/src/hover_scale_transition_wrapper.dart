import 'package:flutter/material.dart';

/// {@template card_item}
/// OnHoverScaleTransitionWrapper widget.
/// {@endtemplate}
class HoverScaleTransitionWrapper extends StatefulWidget {
  /// {@macro card_item}
  const HoverScaleTransitionWrapper({
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
  State<HoverScaleTransitionWrapper> createState() => _HoverScaleTransitionWrapperState();
}

/// State for widget OnHoverScaleTransitionWrapper.
class _HoverScaleTransitionWrapperState extends State<HoverScaleTransitionWrapper>
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
  void didUpdateWidget(covariant HoverScaleTransitionWrapper oldWidget) {
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
