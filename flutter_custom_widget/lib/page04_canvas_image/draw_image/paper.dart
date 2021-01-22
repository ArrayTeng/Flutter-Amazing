import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:flutter_custom_widget/utils/utils.dart';

class Paper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaperState();
  }
}

class _PaperState extends State<Paper> {
  ui.Image _image;

  @override
  void initState() {
    super.initState();
    //从assets文件中加载图片
    _loadImage();
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('assets/images/wy_300x200.jpg');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(_image),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  Paint _paint;

  final ui.Image image;

  PaperPainter(this.image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue
      ..strokeWidth = 0.5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);
    _drawAxis(canvas, size);

    _drawImage(canvas);

    _drawImageRect(canvas);
  }

  void _drawImage(Canvas canvas) {
    if (image != null) {
      canvas.drawImage(
          //这里的Offset可以看作是图片左上角的位置
          image,
          Offset(-image.width / 2, -image.height / 2),
          _paint);
    }
  }

  void _drawImageRect(Canvas canvas) {
    if (image != null) {
      canvas.drawImageRect(
          image,
          Rect.fromCenter(
              center: Offset(image.width / 2, image.height / 2),
              width: 60,
              height: 60),
          Rect.fromLTRB(0, 0, 100, 100).translate(200, 0),
          _paint);

      canvas.drawImageRect(
          image,
          Rect.fromLTRB(image.width / 4, 0,
              image.width/2, image.height / 4),
          Rect.fromLTRB(0,-80, 80, 0).translate(200, 0),
          _paint);

      canvas.drawImageRect(
          image,
          Rect.fromCenter(
              center: Offset(image.width/2+60, image.height/2), width: 60, height: 60),
          Rect.fromLTRB(0, 0, 100, 100).translate(-280, 50),
          _paint);
    }
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

  //绘制x轴和y周坐标轴
  void _drawAxis(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 1.5
      ..color = Colors.blue;

    canvas.drawLine(Offset(0, 0), Offset(0, -size.height / 2), paint);

    canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), paint);

    canvas.drawLine(Offset(0, 0), Offset(-size.width / 2, 0), paint);

    canvas.drawLine(Offset(0, 0), Offset(-size.width / 2, 0), paint);

    canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), paint);

    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2 - 10 - 10, -10), paint);

    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10 - 10, 10), paint);
  }

  //是否重新调用paint方法
  @override
  bool shouldRepaint(covariant PaperPainter oldDelegate) =>
      image != oldDelegate.image;
}
