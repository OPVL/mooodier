import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedGradientContainer extends StatefulWidget {
  final Widget? child;
  final Duration duration;
  final List<Color>? colors;
  final double blurAmount;
  final int numCircles;
  final bool pauseWhenOffscreen;
  final double animationSpeed;

  const AnimatedGradientContainer({
    super.key,
    this.child,
    this.duration = const Duration(seconds: 20),
    this.colors,
    this.blurAmount = 60.0,
    this.numCircles = 5,
    this.pauseWhenOffscreen = true,
    this.animationSpeed = 1.0,
  });

  @override
  State<AnimatedGradientContainer> createState() =>
      _AnimatedGradientContainerState();
}

class _AnimatedGradientContainerState extends State<AnimatedGradientContainer>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final List<_AnimatedCircle> _circles = [];
  List<Color>? _colors;
  bool _isPaused = false;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCircles();
  }

  void _checkVisibility() {
    if (!widget.pauseWhenOffscreen || !mounted) return;

    final renderObject = context.findRenderObject();
    if (renderObject is RenderBox && renderObject.hasSize) {
      final position = renderObject.localToGlobal(Offset.zero);
      final size = renderObject.size;
      final screenSize = MediaQuery.of(context).size;

      final isVisible = position.dx < screenSize.width &&
          position.dy < screenSize.height &&
          position.dx + size.width > 0 &&
          position.dy + size.height > 0;

      if (isVisible != _isVisible) {
        _isVisible = isVisible;
        if (_isVisible) {
          _resumeAnimations();
        } else {
          _pauseAnimations();
        }
      }
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        _pauseAnimations();
        break;
      case AppLifecycleState.resumed:
        _resumeAnimations();
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  void _pauseAnimations() {
    if (!_isPaused) {
      _isPaused = true;
      for (final circle in _circles) {
        circle.pause();
      }
    }
  }

  void _resumeAnimations() {
    if (_isPaused && _isVisible) {
      _isPaused = false;
      for (final circle in _circles) {
        circle.resume();
      }
    }
  }

  void _initializeCircles() {
    _circles.clear();
    for (int i = 0; i < widget.numCircles; i++) {
      final randomDurationVariation = (5 + Random().nextInt(15));
      final baseDuration =
          (widget.duration.inSeconds / widget.animationSpeed).round();

      _circles.add(
        _AnimatedCircle(
          vsync: this,
          duration: Duration(
            seconds: baseDuration - 5 + randomDurationVariation,
          ),
          colorDuration: Duration(
            seconds: (baseDuration ~/ 2 + Random().nextInt(10)),
          ),
          animationSpeed: widget.animationSpeed,
        ),
      );
    }
  }

  @override
  void didUpdateWidget(AnimatedGradientContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.numCircles != oldWidget.numCircles ||
        widget.duration != oldWidget.duration ||
        widget.animationSpeed != oldWidget.animationSpeed) {
      for (final circle in _circles) {
        circle.dispose();
      }
      _initializeCircles();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (final circle in _circles) {
      circle.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _colors = widget.colors;

    if (_colors == null || _colors!.length < 2) {
      _colors = [
        Theme.of(context).colorScheme.primary,
        Theme.of(context).colorScheme.secondary,
        Theme.of(context).colorScheme.tertiary,
        Theme.of(context).colorScheme.primary,
      ];
    }

    for (final circle in _circles) {
      circle.updateColors(_colors!);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;

        if (widget.pauseWhenOffscreen) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _checkVisibility();
            }
          });
        }

        return ClipRect(
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: Listenable.merge(
                    _circles
                        .expand((circle) =>
                            [circle.positionController, circle.sizeController])
                        .toList(),
                  ),
                  builder: (context, _) {
                    return CustomPaint(
                      painter: _GradientPainter(
                        circles: _circles,
                        size: Size(width, height),
                      ),
                      size: Size(width, height),
                    );
                  },
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: widget.blurAmount,
                    sigmaY: widget.blurAmount,
                  ),
                  child: Container(color: Colors.transparent),
                ),
              ),
              if (widget.child != null) widget.child!,
            ],
          ),
        );
      },
    );
  }
}

class _AnimatedCircle {
  late AnimationController positionController;
  late AnimationController sizeController;
  late AnimationController colorController;
  late Animation<Offset> positionAnimation;
  late Animation<double> sizeAnimation;
  late Animation<double> colorAnimation;

  Offset position = Offset.zero;
  double size = 0;
  Color color = Colors.transparent;
  List<Color> colors = [];
  int colorIndex = 0;
  final double animationSpeed;

  _AnimatedCircle({
    required TickerProvider vsync,
    required Duration duration,
    required Duration colorDuration,
    this.animationSpeed = 1.0,
  }) {
    final random = Random();

    // Each circle gets different durations for position and size
    final positionDuration = Duration(
      milliseconds:
          (duration.inMilliseconds * (0.7 + random.nextDouble() * 0.6)).round(),
    );
    final sizeDuration = Duration(
      milliseconds:
          (duration.inMilliseconds * (0.5 + random.nextDouble() * 0.8)).round(),
    );

    positionController =
        AnimationController(vsync: vsync, duration: positionDuration);
    sizeController = AnimationController(vsync: vsync, duration: sizeDuration);
    colorController =
        AnimationController(vsync: vsync, duration: colorDuration);

    _initializeAnimations();

    // Start each animation at a random point in its cycle for more chaos
    positionController.value = random.nextDouble();
    sizeController.value = random.nextDouble();

    positionController.repeat(reverse: true);
    sizeController.repeat(reverse: true);
    colorController.forward();

    colorController.addStatusListener((status) {
      if (status == AnimationStatus.completed && colors.isNotEmpty) {
        colorIndex = (colorIndex + 1) % colors.length;
        colorController.reset();
        colorController.forward();
      }
    });
  }

  void _initializeAnimations() {
    final random = Random();

    // Positions centered around the middle with symmetric distribution
    final startX = -0.5 + random.nextDouble() * 1.0;
    final startY = -0.5 + random.nextDouble() * 1.0;
    final endX = -0.5 + random.nextDouble() * 1.0;
    final endY = -0.5 + random.nextDouble() * 1.0;

    // Pick from various easing curves for more organic movement
    final curves = [
      Curves.easeInOut,
      Curves.easeInOutCubic,
      Curves.easeInOutSine,
      Curves.easeInOutQuad,
      Curves.easeInOutCirc,
    ];
    final positionCurve = curves[random.nextInt(curves.length)];

    positionAnimation = Tween<Offset>(
      begin: Offset(startX, startY),
      end: Offset(endX, endY),
    ).animate(
      CurvedAnimation(parent: positionController, curve: positionCurve),
    );

    // More varied size ranges
    final minSize = 0.2 + random.nextDouble() * 0.4;
    final maxSize = 0.5 + random.nextDouble() * 0.5;

    final sizeCurve = curves[random.nextInt(curves.length)];

    sizeAnimation = Tween<double>(begin: minSize, end: maxSize).animate(
      CurvedAnimation(parent: sizeController, curve: sizeCurve),
    );

    colorAnimation = CurvedAnimation(
      parent: colorController,
      curve: Curves.easeInOut,
    );
  }

  void updateColors(List<Color> newColors) {
    if (colors.isEmpty) {
      colorIndex = Random().nextInt(newColors.length);
    }
    colors = newColors;
  }

  void update() {
    position = positionAnimation.value;
    size = sizeAnimation.value;

    if (colors.isNotEmpty) {
      final nextIndex = (colorIndex + 1) % colors.length;
      color = Color.lerp(
        colors[colorIndex],
        colors[nextIndex],
        colorAnimation.value,
      )!;
    }
  }

  void pause() {
    positionController.stop();
    sizeController.stop();
    colorController.stop();
  }

  void resume() {
    positionController.repeat(reverse: true);
    sizeController.repeat(reverse: true);
    if (colorController.status != AnimationStatus.forward) {
      colorController.forward();
    }
  }

  void dispose() {
    positionController.dispose();
    sizeController.dispose();
    colorController.dispose();
  }
}

class _GradientPainter extends CustomPainter {
  final List<_AnimatedCircle> circles;
  final Size size;

  _GradientPainter({required this.circles, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final width = size.width;
    final height = size.height;

    for (final circle in circles) {
      circle.update();

      final paint = Paint()
        ..color = circle.color.withValues(alpha: 0.5)
        ..style = PaintingStyle.fill;

      final centerX = width * (0.5 + circle.position.dx * 0.5);
      final centerY = height * (0.5 + circle.position.dy * 0.5);
      final radius = width * circle.size * 0.5;

      canvas.drawCircle(Offset(centerX, centerY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
