import 'package:flutter/material.dart';
import 'dart:math' as math;

class InteractiveGraphicsDemo extends StatefulWidget {
  const InteractiveGraphicsDemo({super.key});

  @override
  State<InteractiveGraphicsDemo> createState() => _InteractiveGraphicsDemoState();
}

class _InteractiveGraphicsDemoState extends State<InteractiveGraphicsDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Offset> _tapPositions = [];
  List<Color> _tapColors = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTap(Offset position) {
    setState(() {
      _tapPositions.add(position);
      _tapColors.add(Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));

      // Keep only last 10 taps
      if (_tapPositions.length > 10) {
        _tapPositions.removeAt(0);
        _tapColors.removeAt(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _addTap(details.localPosition),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade900, Colors.blue.shade900],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Animated background circles
            ...List.generate(5, (index) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  final offset = (_controller.value + index * 0.2) % 1.0;
                  return Positioned(
                    left: 50 + (index * 60.0),
                    top: 150 + math.sin(offset * 2 * math.pi) * 100,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  );
                },
              );
            }),

            // User tap circles
            ..._tapPositions.asMap().entries.map((entry) {
              return Positioned(
                left: entry.value.dx - 25,
                top: entry.value.dy - 25,
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 500),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: 1 - value,
                      child: Transform.scale(
                        scale: 1 + value,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _tapColors[entry.key],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),

            // Instructions
            const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.touch_app, size: 60, color: Colors.white54),
                  SizedBox(height: 12),
                  Text(
                    'Tap anywhere to create graphics!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}