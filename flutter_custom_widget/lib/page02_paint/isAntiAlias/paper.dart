import 'package:flutter/material.dart';

//画笔绘制圆的练习
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
    drawIsAntiAliasColor(canvas);
//    drawStyleStrokeWidth(canvas);
  }

  void drawIsAntiAliasColor(Canvas canvas) {
    Paint paint = Paint();

    canvas.drawCircle(
      Offset(180, 180),
      170,
      paint
        ..color = Colors.red
        ..isAntiAlias = true
        ..strokeWidth = 5,
    );

    canvas.drawCircle(
      Offset(180 + 360.0, 180),
      170,
      paint
        ..color = Colors.blue
        ..isAntiAlias = false,
    );
  }

  void drawStyleStrokeWidth(Canvas canvas) {
    Paint paint = Paint();

    canvas.drawCircle(
      Offset(180, 180),
      140,
      paint
        ..color = Colors.yellow
        ..isAntiAlias = true
        ..style = PaintingStyle.stroke
        ..strokeWidth = 50,
    );

    canvas.drawCircle(
      Offset(180 + 360.0, 180),
      140,
      paint
        ..color = Colors.blue
        ..isAntiAlias = false
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
