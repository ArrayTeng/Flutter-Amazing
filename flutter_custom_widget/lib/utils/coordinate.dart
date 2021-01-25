import 'package:flutter/material.dart';

class Coordinate {
  double step;

  Paint _paint;

  final TextPainter _stepTextPainter =
  TextPainter(textDirection: TextDirection.ltr);

  Coordinate(this.step) {
    _paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5;
  }

  void print(Canvas canvas, Size size) {
    //通过path相对路径的方式绘制网格
    _drawGridLine(canvas, size);
    _drawAxis(canvas, size);
    _drawText(canvas,size);
  }

  void _drawGridLine(Canvas canvas, Size size) {
    //通过path相对路径的方式绘制网格
    double step = 25.0;
    _paint
      ..style = PaintingStyle.stroke
      ..color = Colors.grey
      ..strokeWidth = .5;

    Path path = Path();

    for (int i = 0; i < size.width / 2 / step; i++) {
      path.moveTo(step * i, -size.height / 2);
      path.relativeLineTo(0, size.height);
      path.moveTo(-step * i, -size.height / 2);
      path.relativeLineTo(0, size.height);
    }

    for (int i = 0; i < size.height / 2 / step; i++) {
      path.moveTo(-size.width / 2, step * i);
      path.relativeLineTo(size.width, 0);

      path.moveTo(-size.width / 2, -step * i);
      path.relativeLineTo(size.width, 0);
    }

    canvas.drawPath(path, _paint);
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
        Offset(size.width / 2  - 10, -10), paint);

    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2  - 10, 10), paint);
  }


  void _drawText(Canvas canvas, Size size) {
    //y轴大于 0 的情况
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, step);
        continue;
      } else {
        var str = (i * step).toInt().toString();
        _drawAxisText(canvas, str);
      }
      canvas.translate(0, step);
    }
    canvas.restore();

    //x轴大于0的情况
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      if(i ==0){
        _drawAxisText(canvas,'0',x: null);
        canvas.translate(step,0);
        continue;
      }
      if(step < 30 && i.isOdd){
        canvas.translate(step,0);
        continue;
      }else {
        var str = (i * step).toInt().toString();
        _drawAxisText(canvas, str,x: true);
      }
      canvas.translate(step,0);
    }
    canvas.restore();

    //y轴小于0的情况
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      if (step < 30 && i.isOdd || i == 0) {
        canvas.translate(0, -step);
        continue;
      } else {
        var str = (i * -step).toInt().toString();
        _drawAxisText(canvas, str,);
      }
      canvas.translate(0, -step);
    }
    canvas.restore();

    //x轴大小于0的情况
    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {

      if(step < 30 && i.isOdd || i==0){
        canvas.translate(-step,0);
        continue;
      }else {
        var str = (i * -step).toInt().toString();
        _drawAxisText(canvas, str,x: true);
      }
      canvas.translate(-step,0);
    }
    canvas.restore();
  }

  void _drawAxisText(
      Canvas canvas,
      String text, {
        Color color = Colors.black87,
        bool x = false,
      }) {
    TextSpan textSpan =
    TextSpan(text: text, style: TextStyle(fontSize: 11, color: color));

    _stepTextPainter.text = textSpan;
    _stepTextPainter.layout();

    Size size = _stepTextPainter.size;

    Offset offset = Offset.zero;

    if (x == null) {
      offset = Offset(8, 8);
    } else if (x) {
      offset = Offset(size.width / 2 - 13, size.height / 2 );
    } else {
      offset = Offset(size.height / 2, -size.height / 2 + 2);
    }

    _stepTextPainter.paint(canvas, offset);
  }

}
