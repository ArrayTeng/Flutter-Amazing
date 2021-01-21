import 'dart:ui';

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

    _drawPointsWithPoints(canvas, size);

    //_drawPointsWithLines(canvas,size);

    _drawPointsWithPolygon(canvas, size);
  }

  //绘制点
  void _drawPointsWithPoints(Canvas canvas, Size size) {
    final List<Offset> points = [
      Offset(0, 0),
      Offset(20, 40),
      Offset(40, 60),
      Offset(80, 90),
      Offset(-100, 0),
      Offset(-140, 60),
      Offset(-160, 60),
      Offset(-180, -80),
    ];

    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawPoints(PointMode.points, points, paint);
  }

  //绘制连线
  void _drawPointsWithLines(Canvas canvas, Size size) {
    final List<Offset> points = [
      Offset(0, 0),
      Offset(20, 40),
      Offset(40, 60),
      Offset(80, 90),
      Offset(-100, 0),
      Offset(-140, 60),
      Offset(-160, 60),
      Offset(-180, -80),
    ];

    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawPoints(PointMode.lines, points, paint);
  }

  //多边形连线模式所有的点依次连接成图形
  void _drawPointsWithPolygon(Canvas canvas, Size size) {
    final List<Offset> points = [
      Offset(0, 0),
      Offset(20, 40),
      Offset(40, 60),
      Offset(80, 90),
      Offset(-100, 0),
      Offset(-140, 60),
      Offset(-160, 60),
      Offset(-180, -80),
    ];

    Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPoints(PointMode.polygon, points, paint);
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
