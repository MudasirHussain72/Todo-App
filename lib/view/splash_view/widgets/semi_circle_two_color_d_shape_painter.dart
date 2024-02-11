// import 'package:flutter/material.dart';
// import 'dart:math';

// class SemiCircleDShapePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Color(0xffE79AD4) // Change color as needed
//       ..style = PaintingStyle.fill;

//     final path = Path()
//       ..moveTo(size.width / 2, size.height / 2)
//       ..arcTo(
//         Rect.fromCircle(
//           center: Offset(size.width / 2, size.height / 2),
//           radius: size.width / 2,
//         ),
//         -pi / 2, // Start angle (-90 degrees)
//         -pi, // Sweep angle (-180 degrees, making it a D-shape)
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
import 'package:flutter/material.dart';
import 'dart:math';

class SemiCircleTwoColorDShapePainter extends CustomPainter {
  final double rotationAngle;

  SemiCircleTwoColorDShapePainter({required this.rotationAngle});

  @override
  void paint(Canvas canvas, Size size) {
    final paintPink = Paint()
      ..color = Color(0xff9B73F7) // Pink color
      ..style = PaintingStyle.fill;

    final paintBlue = Paint()
      ..color = Color(0xff99cbca) // Blue color
      ..style = PaintingStyle.fill;

    // Define the center and radius of the semi-circle
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = size.width / 2;

    // Define the start and sweep angles for the semi-circle
    final startAngle = -pi / 2; // Start angle (-90 degrees)
    final sweepAngle = pi; // Sweep angle (180 degrees, making it a D-shape)

    // Create two separate paths for each half of the semi-circle
    final pathPink = Path()
      ..moveTo(centerX, centerY)
      ..arcTo(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle + rotationAngle,
        sweepAngle / 2, // Sweep angle for the pink half
        false,
      )
      ..lineTo(centerX, centerY); // Close the path

    final pathBlue = Path()
      ..moveTo(centerX, centerY)
      ..arcTo(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle +
            sweepAngle / 2 +
            rotationAngle, // Start angle for the blue half
        sweepAngle / 2, // Sweep angle for the blue half
        false,
      )
      ..lineTo(centerX, centerY); // Close the path

    // Draw the pink path on the left half and the blue path on the right half
    canvas.drawPath(pathPink, paintPink);
    canvas.drawPath(pathBlue, paintBlue);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
