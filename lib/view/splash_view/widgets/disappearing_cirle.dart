// import 'package:flutter/material.dart';

// class DisappearingCirclePainter extends CustomPainter {
//   final Animation<double> animation;

//   DisappearingCirclePainter({required this.animation})
//       : super(repaint: animation);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 2;

//     canvas.drawCircle(
//       Offset(size.width / 2, size.height / 2),
//       size.width / 2,
//       paint..color.withOpacity(animation.value),
//     );
//   }

//   @override
//   bool shouldRepaint(DisappearingCirclePainter oldDelegate) {
//     return animation != oldDelegate.animation;
//   }
// }

import 'package:flutter/material.dart';

class DisappearingCirclePainter extends CustomPainter {
  final Animation<double> animation;

  DisappearingCirclePainter({required this.animation})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color =
          Color(0xff3D8458).withOpacity(animation.value) // Update opacity here
      ..style = PaintingStyle.fill
      ..strokeWidth = 2;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );
  }

  @override
  bool shouldRepaint(DisappearingCirclePainter oldDelegate) {
    return animation != oldDelegate.animation;
  }
}
