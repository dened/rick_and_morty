import 'dart:developer' as developer;
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class Shimmer extends LeafRenderObjectWidget {
  const Shimmer({
    this.highlight = const Color(0xFFEBEBF5),
    this.background = const Color(0xFFF5F5F9),
    this.speed = 1.0,
    this.size,
    this.radius,
    this.stripe,
    super.key,
  });

  final Color highlight;
  final Color background;
  final double speed;
  final Size? size;
  final Radius? radius;
  final double? stripe;

  @override
  RenderObject createRenderObject(BuildContext context) => ShimmerRenderObject(
    highlight: highlight,
    background: background,
    speed: speed,
    size: size,
    radius: radius,
    stripe: stripe,
  );

  @override
  void updateRenderObject(BuildContext context, covariant ShimmerRenderObject renderObject) => renderObject.update(
    highlight: highlight,
    background: background,
    speed: speed,
    size: size,
    radius: radius,
    stripe: stripe,
  );
}

class ShimmerRenderObject extends RenderBox {
  ShimmerRenderObject({
    required Color highlight,
    required Color background,
    required double speed,
    required Size? size,
    required Radius? radius,
    required double? stripe,
  }) : _highlight = highlight,
       _background = background,
       _speed = speed,
       _size = size,
       _radius = radius,
       _stripe = stripe,
       _paint = Paint() {
    _paint
      ..color = background
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.srcOver
      ..filterQuality = FilterQuality.low
      ..isAntiAlias = true;
  }

  Color _highlight;
  Color _background;
  double _speed;
  Size? _size;
  Radius? _radius;
  double? _stripe;

  final Paint _paint;

  Ticker? _animationTicker;

  void update({
    required Color highlight,
    required Color background,
    required double speed,
    required Size? size,
    required Radius? radius,
    required double? stripe,
  }) {
    if (size != _size) {
      markNeedsLayout();
    }

    _highlight = highlight;
    _background = background;
    _speed = speed;
    _size = size;
    _radius = radius;
    _stripe = stripe;
    _paint.color = background;
    markNeedsPaint();
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);

    _ShimmerShaderManager.setShader(_paint);
    _animationTicker = Ticker(_onTick)..start();
  }

  Duration _elapsed = Duration.zero;
  void _onTick(Duration elapsed) {
    _elapsed = elapsed;
    markNeedsPaint();
  }

  @override
  Size computeDryLayout(covariant BoxConstraints constraints) => switch (_size) {
    Size size => constraints.constrain(size),
    _ => constraints.biggest,
  };

  @override
  void performLayout() {
    size = computeDryLayout(constraints);
  }

  @override
  void performResize() {
    size = computeDryLayout(constraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (size.isEmpty) return;

    final canvas = context.canvas
      ..save()
      ..translate(offset.dx, offset.dy);

    if (_radius case Radius radius when radius != Radius.zero) {
      canvas.clipRRect(RRect.fromRectAndRadius(Offset.zero & size, radius));
    } else {
      canvas.clipRect(Offset.zero & size);
    }

    if (_paint.shader case ui.FragmentShader shader) {
      final seed = _elapsed.inMicroseconds * _speed / 200000;

      _paint.shader = shader
        ..setFloat(0, size.width)
        ..setFloat(1, size.height)
        ..setFloat(2, seed)
        ..setFloat(3, _highlight.r)
        ..setFloat(4, _highlight.g)
        ..setFloat(5, _highlight.b)
        ..setFloat(6, _highlight.a)
        ..setFloat(7, _background.r)
        ..setFloat(8, _background.g)
        ..setFloat(9, _background.b)
        ..setFloat(10, _background.a)
        ..setFloat(11, _stripe ?? 0.75);

      canvas.drawRect(Offset.zero & size, _paint);
    } else {
      canvas.drawRect(Offset.zero & size, _paint);
    }

    canvas.restore();
  }

  @override
  void detach() {
    super.detach();
    _animationTicker?.dispose();
  }
}

// ignore: avoid_classes_with_only_static_members
abstract final class _ShimmerShaderManager {
  static ui.FragmentProgram? _fragmentProgram;
  static final Future<ui.FragmentProgram?> _loadFragmentProgramOnce = _loadFragmentProgram();

  static Future<ui.FragmentProgram?> _loadFragmentProgram() async {
    if (_fragmentProgram != null) {
      return _fragmentProgram;
    }

    const asset = 'packages/ui/assets/shaders/shimmer.frag';
    try {
      final program = _fragmentProgram = await ui.FragmentProgram.fromAsset(asset).timeout(const Duration(seconds: 5));
      return program;
      // ignore: avoid_catching_errors
    } on UnsupportedError {
      return null;
    } on Object catch (e, s) {
      developer.log('Failed to load shader: $e', error: e, stackTrace: s, name: 'ui', level: 700);
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: e,
          stack: s,
          library: 'ui',
          context: ErrorDescription('Failed to load shimmer shader'),
        ),
      );
      return null;
    }
  }

  static void setShader(Paint paint) {
    if (_fragmentProgram case ui.FragmentProgram program) {
      paint
        ..shader = program.fragmentShader()
        ..blendMode = BlendMode.src;
    } else {
      _loadFragmentProgramOnce.then((program) {
        if (program == null) return;

        paint
          ..shader = program.fragmentShader()
          ..blendMode = BlendMode.src;
      }).ignore();
    }
  }
}
