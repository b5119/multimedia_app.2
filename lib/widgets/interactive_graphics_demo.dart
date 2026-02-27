import 'package:flutter/material.dart';
import 'dart:math' as math;

class InteractiveGraphicsDemo extends StatefulWidget {
  const InteractiveGraphicsDemo({super.key});

  @override
  State<InteractiveGraphicsDemo> createState() => _InteractiveGraphicsDemoState();
}

class _InteractiveGraphicsDemoState extends State<InteractiveGraphicsDemo>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  final List<TapData> _taps = [];

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    super.dispose();
  }

  void _handleTap(Offset position) {
    final color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);

    setState(() {
      _taps.add(TapData(position: position, color: color, time: DateTime.now()));

      // Keep only last 20 taps
      if (_taps.length > 20) {
        _taps.removeAt(0);
      }
    });

    // Remove tap after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _taps.removeWhere((tap) => tap.position == position);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _handleTap(details.localPosition),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade900,
              Colors.blue.shade900,
              Colors.indigo.shade900,
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Animated background circles
              AnimatedBuilder(
                animation: _backgroundController,
                builder: (context, child) {
                  return CustomPaint(
                    size: const Size(double.infinity, 300),
                    painter: BackgroundPainter(_backgroundController.value),
                  );
                },
              ),

              // Tap effects
              ..._taps.map((tap) => TapEffectWidget(key: ValueKey(tap.time), tapData: tap)),

              // Instructions
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.touch_app,
                        size: 60,
                        color: Colors.white,
                      ),
                      SizedBox(height: 12),
                      Text(
                        'TAP ANYWHERE!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Create colorful graphics',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TapData {
  final Offset position;
  final Color color;
  final DateTime time;

  TapData({required this.position, required this.color, required this.time});
}

class TapEffectWidget extends StatefulWidget {
  final TapData tapData;

  const TapEffectWidget({super.key, required this.tapData});

  @override
  State<TapEffectWidget> createState() => _TapEffectWidgetState();
}

class _TapEffectWidgetState extends State<TapEffectWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _scaleAnim = Tween<double>(begin: 0.0, end: 3.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _opacityAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: widget.tapData.position.dx - 40,
          top: widget.tapData.position.dy - 40,
          child: Opacity(
            opacity: _opacityAnim.value,
            child: Transform.scale(
              scale: _scaleAnim.value,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.tapData.color.withOpacity(0.7),
                  boxShadow: [
                    BoxShadow(
                      color: widget.tapData.color,
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 30 * (1 - _controller.value),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animValue;

  BackgroundPainter(this.animValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Draw floating circles
    for (int i = 0; i < 8; i++) {
      final offset = (animValue + i * 0.125) % 1.0;
      final x = (i % 4) * (size.width / 4) + 50;
      final y = size.height * offset;

      paint.color = Colors.white.withOpacity(0.05);
      canvas.drawCircle(Offset(x, y), 30, paint);
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => true;
}