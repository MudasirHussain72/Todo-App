import 'package:flutter/material.dart';
import 'dart:math';

class CirclePartBottomLeftPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xff9B73F7) // Change color as needed
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, size.height / 2)
      ..arcTo(
          Rect.fromCircle(
              center: Offset(size.width / 2, size.height / 2),
              radius: size.width / 2),
          -pi,
          -pi / 2,
          false)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
// import 'package:flutter/material.dart';
// import 'dart:math';

// class CirclePartBottomLeftPainter extends CustomPainter {
//   final Offset position; // Position of the circle part

//   CirclePartBottomLeftPainter({required this.position});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Color(0xff9B73F7) // Change color as needed
//       ..style = PaintingStyle.fill;

//     final path = Path()
//       ..moveTo(position.dx, position.dy)
//       ..arcTo(
//         Rect.fromCircle(
//           center: position,
//           radius: size.width / 2,
//         ),
//         -pi,
//         -pi / 2,
//         false,
//       )
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
