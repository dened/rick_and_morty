import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// {@template property_widget}
/// Widget to display a property with a label and a value.
/// [label] • • • • • [value]
///
/// Tip: Use `DefaultTextStyle` to customize the underlying text style.
/// Tip: User `FittedBox` to downscale the size of form at limited space.
/// {@endtemplate}
class PropertyWidget extends StatelessWidget {
  /// {@macro property_widget}
  const PropertyWidget({
    required this.label,
    required this.value,
    this.action,
    this.height = 18,
    super.key, // ignore: unused_element_parameter
  });

  /// Label of the property.
  final String label;

  /// Value of the property.
  final String value;

  /// (Optional) Action to perform when the value is tapped.
  final VoidCallback? action;

  /// Height of the widget.
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomMultiChildLayout(
          delegate: _PropertyWidgetLayoutDelegate(),
          children: <LayoutId>[
            // --- Label --- //
            LayoutId(
              id: 1,
              child: Text(
                label.toUpperCase(),
                maxLines: 1,
                softWrap: false,
                style: TextStyle(height: 1, overflow: TextOverflow.ellipsis, color: theme.colorScheme.onSurface),
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // --- Dots --- //
            LayoutId(
              id: 2,
              child: const CustomPaint(isComplex: false, willChange: false, painter: _PropertyDotsPainter()),
            ),

            // --- Value --- //
            LayoutId(
              id: 3,
              child: Text.rich(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                action == null
                    // No action, just display the value
                    ? TextSpan(
                        text: value,
                        style: TextStyle(
                          height: 1,
                          decoration: TextDecoration.none,
                          overflow: TextOverflow.ellipsis,
                          color: theme.colorScheme.onSurface,
                        ),
                      )
                    // Action, display the value as a link with an action
                    : TextSpan(
                        text: value,
                        recognizer: TapGestureRecognizer()..onTap = action,
                        style: TextStyle(
                          height: 1,
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyWidgetLayoutDelegate extends MultiChildLayoutDelegate {
  _PropertyWidgetLayoutDelegate();

  @override
  void performLayout(Size size) {
    const padding = 4; // Padding between the label, the dots and the value
    const middle = 48; // Reserved space for the dots, subtracted from label and value
    final Size(width: s$w, height: s$h) = size;
    // Allow 75% of the width for the label
    final label = layoutChild(1, BoxConstraints.loose(Size(s$w * .75 - middle / 2, s$h)));
    // Allow all the remaining width (minus double padding) for the value
    final value = layoutChild(3, BoxConstraints.loose(Size(s$w - label.width - middle / 2 - padding * 2, s$h)));
    // The dots width is the remaining space between the label and the value, minus the padding on each side
    final dots = layoutChild(2, BoxConstraints.tight(Size(s$w - label.width - value.width - padding * 2, s$h)));
    // Position the label at the left, centered vertically
    positionChild(1, Offset(0, (s$h - label.height) / 2));
    // Position the value at the right, centered vertically
    positionChild(3, Offset(s$w - value.width, (s$h - value.height) / 2));
    // Position the dots at the right of the label, centered vertically
    positionChild(2, Offset(label.width + padding, (s$h - dots.height) / 2));
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => false;
}

class _PropertyDotsPainter extends CustomPainter {
  const _PropertyDotsPainter({super.repaint}); // ignore: unused_element_parameter

  static const double _radius = 1;
  static const double _space = 4;
  static final Paint _dotsPaint = Paint()
    ..color = const Color(0x7FE0E0E0)
    ..blendMode = BlendMode.src
    ..strokeWidth = _radius * 2
    ..strokeCap = StrokeCap.round
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    final s$w = size.width;
    if (s$w < (_radius + _space) * 2) return; // Not enough space for a dots
    final count = (s$w - _radius * 2 - _space) ~/ (_radius * 2 + _space);
    final offset = (s$w - count * (_radius * 2 + _space)) / 2;
    final dy = size.height / 2 + 1; // Center vertically
    final dx = offset + _radius + _space / 2; // Base dx offset
    final f32l = Float32List(count * 2);
    for (var i = 0; i < count; i++)
      f32l
        ..[i * 2 + 0] = dx + i * (_radius * 2 + _space)
        ..[i * 2 + 1] = dy;
    canvas.drawRawPoints(PointMode.points, f32l, _dotsPaint);
  }

  @override
  bool shouldRepaint(covariant _PropertyDotsPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(covariant _PropertyDotsPainter oldDelegate) => false;

  @override
  bool? hitTest(Offset position) => false;
}
