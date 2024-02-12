import 'package:flutter/material.dart';
import 'package:todo_app/view/splash_view/widgets/appear_circle_painter.dart';
import 'package:todo_app/view/splash_view/widgets/circle_part_top_left.dart';
import 'package:todo_app/view/splash_view/widgets/disappearing_cirle.dart';
import 'package:todo_app/view/splash_view/widgets/semi_circle_left.dart';
import 'package:todo_app/view/splash_view/widgets/semi_circle_two_color_d_shape_painter.dart';
import 'package:todo_app/view/splash_view/widgets/semi_circle_part_bottom.dart';
import 'package:todo_app/view/splash_view/widgets/circle_part_bottom_left.dart';
import 'package:todo_app/view/splash_view/widgets/semi_circle_part_top.dart';
import 'package:todo_app/view_model/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _animationStart = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _animationStart = true;
        });
      });

    _controller.forward();
    SplashServices().isLogin(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: -40,
            child: CustomPaint(
              size: const Size(270, 270),
              painter: SemiCirclePartTopPainter(color: Color(0xff70357B)),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: _animationStart ? -60 : 20,
            right: -20,
            child: CustomPaint(
              size: const Size(125, 125),
              painter: AppearingCirclePainter(
                  animation: _animation, color: Color(0xff9B73F7)),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: _animationStart ? height / 8.5 : height / 7,
            right: -22,
            child: CustomPaint(
              size: const Size(270, 270),
              painter: CirclePartTopLeftPainter(),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: _animationStart ? height / 8.5 : height / 7,
            right: -22,
            child: CustomPaint(
              size: const Size(270, 270),
              painter: SemiCircleTwoColorDShapePainter(
                rotationAngle: _animation.value,
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 1500),
            top: _animationStart ? height / 7 : height / 6,
            left: -140,
            child: CustomPaint(
              size: const Size(270, 270),
              painter: SemiCircleTwoColorDShapeLeftPainter(
                rotationAngle: _animation.value,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: _animationStart ? height / 8.5 : height / 3.5,
            right: -22,
            child: CustomPaint(
              size: const Size(270, 270),
              painter: CirclePartBottomLeftPainter(),
            ),
          ),
          Positioned(
            top: height / 2.2,
            right: -40,
            child: CustomPaint(
              size: const Size(150, 150),
              painter: DisappearingCirclePainter(animation: _animation),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: _animationStart ? height / 3.2 : height / 2.2,
            left: -40,
            child: CustomPaint(
              size: const Size(150, 150),
              painter: AppearingCirclePainter(
                  animation: _animation, color: Color(0xffE5922D)),
            ),
          ),
          Positioned(
            top: height / 2,
            left: 40,
            child: Text(
              'TODOER',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 60,
                  color: Colors.black.withOpacity(1.0 - _animation.value)),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: height / 1.5,
            right: _animationStart ? width / 6 : width / 3,
            child: CustomPaint(
              size: const Size(125, 125),
              painter: AppearingCirclePainter(
                  animation: _animation, color: Color(0xff9B73F7)),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            top: height / 1.5,
            right: _animationStart ? -180 : -125,
            child: CustomPaint(
              size: const Size(250, 250),
              painter: SemiCirclePartTopPainter(color: Color(0xffE79AD4)),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            bottom: 0,
            right: _animationStart ? width / 5.5 : -20,
            child: CustomPaint(
              size: const Size(270, 270),
              painter: SemiCirclePartBottomPainter(),
            ),
          ),
        ],
      ),
    );
  }
}
