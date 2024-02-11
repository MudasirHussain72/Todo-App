import 'package:flutter/material.dart';

class AppearingCirclePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  AppearingCirclePainter({required this.animation,required this.color}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      // .withOpacity(1.0 - animation.value) // Update opacity here
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(AppearingCirclePainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
