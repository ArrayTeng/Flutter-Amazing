import 'package:flutter/material.dart';

//详细认识画笔
class Paper extends StatelessWidget {
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
    //drawStrokeCap(canvas);
    drawStrokeJoin(canvas);
  }

  //线帽类型
  void drawStrokeCap(Canvas canvas) {
    Paint paint = Paint();
    canvas.drawLine(
        Offset(50, 50),
        Offset(50, 150),
        paint
          ..style = PaintingStyle.fill
          ..color = Colors.blue
          ..strokeWidth = 20
          ..strokeCap = StrokeCap.butt);

    canvas.drawLine(
        Offset(50 + 50.0, 50),
        Offset(50 + 50.0, 150),
        paint
          ..style = PaintingStyle.fill
          ..color = Colors.blue
          ..strokeWidth = 20
          ..strokeCap = StrokeCap.round);

    canvas.drawLine(
        Offset(50 + 50.0 + 50.0, 50),
        Offset(50 + 50.0 + 50.0, 150),
        paint
          ..style = PaintingStyle.fill
          ..color = Colors.blue
          ..strokeWidth = 20
          ..strokeCap = StrokeCap.square);
  }

  //线接类型
  void drawStrokeJoin(Canvas canvas) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..color = Colors.blue;
    Path path = Path();
    path.moveTo(50, 50);
    path.lineTo(50, 150);
    //相对于当前位置的相对坐标
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);

    path.reset();
    path.moveTo(50+150.0, 50);
    path.lineTo(50+150.0, 150);
    //相对于当前位置的相对坐标
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);

    path.reset();
    path.moveTo(50+150.0+150.0, 50);
    path.lineTo(50+150.0+150.0, 150);
    //相对于当前位置的相对坐标
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.round);

  }

  //斜接限制
  void drawStrokeMiterLimit(Canvas canvas){

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
