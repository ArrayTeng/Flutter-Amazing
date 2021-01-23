import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
    //从assets文件中加载图片
    _loadImage();
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('assets/images/right_chat.png');
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
    _drawNineImage(canvas);

  }

  void _drawNineImage(Canvas canvas){
    if(image!=null){
      canvas.drawImageNine(image, Rect.fromCenter(center: Offset(image.width/2, image.height -6.0),width: image.width -20.0,height: 2 ),
          Rect.fromCenter(center: Offset(0, 0),width: 300,height: 120), _paint);
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
