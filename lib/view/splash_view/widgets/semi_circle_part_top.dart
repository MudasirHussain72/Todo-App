import 'package:flutter/material.dart';
import 'dart:math';

class SemiCirclePartTopPainter extends CustomPainter {
  final Color color;

  SemiCirclePartTopPainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color // Change color as needed
      ..style = PaintingStyle.fill;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, 0);

    final path = Path()
      ..moveTo(center.dx - radius, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        0, // Start angle (0 degrees)
        pi, // Sweep angle (180 degrees)
        false,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
