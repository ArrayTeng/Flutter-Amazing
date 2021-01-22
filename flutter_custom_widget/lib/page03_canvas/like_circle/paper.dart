import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Paper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaperState();
  }
}

class _PaperState extends State<Paper> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);
    _drawFill(canvas);
  }

  void _drawFill(Canvas canvas){
    Paint paint = Paint()..color = Colors.blue..style = PaintingStyle.fill;
    canvas.save();
    canvas.translate(-200, 0);
    canvas.drawCircle(Offset(0, 0), 60, paint);
    canvas.restore();

    var rect = Rect.fromCenter(center: Offset(0, 0),height: 100,width: 120);
    canvas.drawOval(rect, paint);

    canvas.save();
    canvas.translate(200, 0);
    canvas.drawArc(rect, 0, pi*2 *(3/4), true, paint);
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    _drawBottomRight(canvas, size);
    canvas.save();
    canvas.scale(1, -1);
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1);
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1);
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    //绘制网格
    double step = 20;

    Paint paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5;
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), paint);
      canvas.translate(0, step);
    }
    canvas.restore();

    //绘制竖直方向
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, size.height / 2), Offset(0, 0), paint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
