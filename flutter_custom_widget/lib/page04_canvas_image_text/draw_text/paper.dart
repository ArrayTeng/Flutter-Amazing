import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:ui' as ui;

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
    _drawGrid(canvas, size);
    _drawAxis(canvas, size);
    _drawText(canvas, size);
    //_drawTextWithParagraph(canvas,TextAlign.left);

    //_drawTextPainter(canvas);

    //_drawTextPaintShowSize(canvas);

    //_drawTextPaintWithPaint(canvas);
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
      // if(i ==0){
      //   _drawAxisText(canvas,'0',x: null);
      //   canvas.translate(step,0);
      //   continue;
      // }
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
      offset = Offset(size.height / 2, size.height / 2 );
    } else {
      offset = Offset(size.height / 2, -size.height / 2 + 2);
    }

    _stepTextPainter.paint(canvas, offset);
  }

  //drawParagraph绘制文字
  void _drawTextWithParagraph(Canvas canvas, TextAlign textAlign) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: textAlign,
        fontSize: 40,
        textDirection: TextDirection.ltr,
        maxLines: 1));

    builder.pushStyle(ui.TextStyle(
        color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic));

    builder.addText("Paragraph");

    ui.Paragraph paragraph = builder.build();

    paragraph.layout(ui.ParagraphConstraints(width: 300));

    //绘制的文字相比较原点的偏移量
    canvas.drawParagraph(paragraph, Offset(0, 0));

    canvas.drawRect(Rect.fromLTRB(0, 0, 300, 40),
        _paint..color = Colors.blue.withAlpha(33));
  }

  //TextPainter 绘制文字
  void _drawTextPainter(Canvas canvas) {
    var textPainter = TextPainter(
        text: TextSpan(
          text: 'TextPainter',
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);
  }

  //TextPainter 获取文字范围
  void _drawTextPaintShowSize(Canvas canvas) {
    var textPainter = TextPainter(
        text: TextSpan(
          text: 'PaintShowSize',
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    textPainter.layout();
    Size size = textPainter.size;
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height)
          .translate(-size.width / 2, -size.height / 2),
      _paint..color = Colors.blue.withAlpha(33),
    );
  }

  //为文字设置画笔样式
  void _drawTextPaintWithPaint(Canvas canvas) {
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    var textPainter = TextPainter(
        text: TextSpan(
          text: 'PaintShowSize',
          style: TextStyle(
            fontSize: 40,
            foreground: textPaint,
          ),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);

    textPainter.layout();
    Size size = textPainter.size;
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height));

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height)
          .translate(-size.width / 2, -size.height),
      _paint..color = Colors.blue.withAlpha(33),
    );
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
  bool shouldRepaint(covariant PaperPainter oldDelegate) => false;
}
