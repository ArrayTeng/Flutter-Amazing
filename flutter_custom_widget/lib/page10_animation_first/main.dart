import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'animation',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.only(top: 58, left: 20),
          child: Center(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: buildChildren(),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildChildren() {
    return List<Widget>.generate(6, (index) {
      return PacMan(
        color: Colors.blue,
      );
    });
  }
}

class PacMan extends StatefulWidget {
  const PacMan({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  State<StatefulWidget> createState() {
    return PacManState();
  }
}

class PacManState extends State<PacMan> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  Animation<double> _angleCtrl;

  Animation<Color> _colorCtrl;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    _angleCtrl = _controller.drive(Tween(begin: 10, end: 40));

    _colorCtrl =
        ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller);

    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 100),
      painter: PacManPainter(
          repaint: _controller, colorAnim: _colorCtrl, angle: _angleCtrl),
    );
  }
}

class PacManPainter extends CustomPainter {
  PacManPainter({
    this.repaint,
    this.colorAnim,
    this.angle,
  }) : super(repaint: repaint);

  final Animation<double> repaint;

  final Animation<Color> colorAnim;

  final Animation<double> angle;

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    double radius = size.width / 2;

    canvas.translate(radius, size.height / 2);

    _drawHead(canvas, size);

    _drawEye(canvas, radius);
  }

  //绘制头
  void _drawHead(Canvas canvas, Size size) {
    //开始角度
    var startAngle = angle.value / 180 * pi;

    var color = colorAnim.value;

    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(0, 0), width: size.width, height: size.height),
        startAngle,
        2 * pi - startAngle.abs() * 2,
        true,
        _paint..color = color);
  }

  //绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.16, -radius * 0.6), radius * 0.12,
        _paint..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant PacManPainter oldDelegate) {
    return oldDelegate.repaint != repaint;
  }
}
