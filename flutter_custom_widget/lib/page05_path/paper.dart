import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:flutter_custom_widget/utils/coordinate.dart';

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
  final TextPainter _stepTextPainter =
      TextPainter(textDirection: TextDirection.ltr);

  Paint _paint;

  //绘制网格
  double step = 25;

  PaperPainter() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue
      ..strokeWidth = 0.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    //_drawGrid(canvas, size);

    Coordinate coordinate = Coordinate(25);
    coordinate.print(canvas, size);

    //_drawLine(canvas);

    //_drawArc(canvas);

    //_drawArcToPointWithRelativeArcToPoint(canvas);

    //todo 圆锥曲线
    //todo 二阶贝塞尔
    //todo 三阶贝塞尔
    //todo 添加类矩形
    //todo 添加类圆形
    //todo 添加多边形路径 、 添加路径
  }



  void _drawArcToPointWithRelativeArcToPoint(Canvas canvas) {
    Path path = Path();
    _paint
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    path.lineTo(80, -40);

    path
      ..arcToPoint(Offset(40, 40), radius: Radius.circular(60), largeArc: false)
      ..close();
    canvas.drawPath(path, _paint);

    path.reset();

    canvas.translate(-150, 0);
    path.lineTo(80, -40);

    path
      ..arcToPoint(Offset(40, 40),
          radius: Radius.circular(60), largeArc: true, clockwise: false)
      ..close();
    canvas.drawPath(path, _paint);
    path.reset();

    canvas.translate(300, 0);
    path.lineTo(80, -40);

    path
      ..arcToPoint(Offset(40, 40),
          radius: Radius.circular(60), largeArc: true, clockwise: true)
      ..close();
    canvas.drawPath(path, _paint);
  }

  void _drawArc(Canvas canvas) {
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromCenter(center: Offset(0, 0), width: 160, height: 100);
    path.lineTo(30, 30);
    path..arcTo(rect, 0, pi * 1.5, true);

    canvas.drawPath(path, paint);
    path.reset();
    canvas.save();
    canvas.translate(200, 0);
    path.lineTo(30, 30);
    path..arcTo(rect, 0, pi * 1.5, false);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawLine(Canvas canvas) {
    Path path = Path();
    path
      ..moveTo(0, 0)
      ..lineTo(0, -100)
      ..lineTo(75, 0)
      ..lineTo(75, 100)
      ..close();
    canvas.drawPath(path, _paint);

    _paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    path
      ..moveTo(0, 0)
      ..lineTo(0, -100)
      ..lineTo(-75, 0)
      ..lineTo(-75, 100)
      ..close();
    canvas.drawPath(path, _paint);

    //相对画线
    _paint
      ..color = Colors.greenAccent
      ..style = PaintingStyle.fill;

    path..reset();

    path
      ..relativeMoveTo(100, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(
        60,
        -10,
      )
      ..close();

    canvas.drawPath(path, _paint);

    path.reset();

    path
      ..relativeMoveTo(200, 0)
      ..relativeLineTo(100, 120)
      ..relativeLineTo(-10, -60)
      ..relativeLineTo(
        60,
        -10,
      )
      ..close();

    canvas.drawPath(path, _paint);

    path.reset();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();

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



  //是否重新调用paint方法
  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) => false;
}
