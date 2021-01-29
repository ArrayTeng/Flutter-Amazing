import 'dart:math';

import 'package:flutter/material.dart';

class HandleWidget extends StatefulWidget {
  const HandleWidget({
    Key key,
    this.size = 160,
    this.handleRadius = 20,
    this.onMove,
  }) : super(key: key);

  final double size;
  final double handleRadius;

  final void Function(double rotate, double distance) onMove;

  @override
  State<StatefulWidget> createState() {
    return HandleState();
  }
}

class HandleState extends State<HandleWidget> {
  ValueNotifier<Offset> valueNotifier = ValueNotifier(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: _reset,
      onPanUpdate: _parser,
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: HandlePainter(
            handleR: widget.handleRadius,
            offset: valueNotifier,
            color: Colors.green),
      ),
    );
  }

  void _reset(DragEndDetails details) {
    valueNotifier.value = Offset.zero;
    if (widget.onMove != null) {
      widget.onMove(0, 0);
    }
  }

  void _parser(DragUpdateDetails details) {
    final offset = details.localPosition;
    double dx = 0.0;
    double dy = 0.0;
    dx = offset.dx - widget.size / 2;
    dy = offset.dy - widget.size / 2;
    var rad = atan2(dx, dy);
    if (dx < 0) {
      rad += 2 * pi;
    }
    var bgR = widget.size / 2 - widget.handleRadius;
    var thta = rad - pi / 2; //旋转坐标系90度
    var d = sqrt(dx * dx + dy * dy);
    if (d > bgR) {
      dx = bgR * cos(thta);
      dy = -bgR * sin(thta);
    }
    if (widget.onMove != null) {
      widget.onMove(thta, d);
    }
    valueNotifier.value = Offset(dx, dy);
  }
}

class HandlePainter extends CustomPainter {
  var _paint = Paint();

  var handleR;

  final ValueNotifier<Offset> offset;

  Color color;

  HandlePainter({this.offset, this.handleR, this.color = Colors.blue})
      : super(repaint: offset);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    final bgR = size.width / 2 - handleR;
    canvas.translate(size.width / 2, size.height / 2);
    _paint
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    _paint.color = _paint.color.withAlpha(100);
    canvas.drawCircle(Offset.zero, bgR, _paint);

    _paint.color = _paint.color.withAlpha(30);
    canvas.drawCircle(
        Offset(offset.value.dx, offset.value.dy), handleR, _paint);

    _paint.color = Colors.green;
    _paint.style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, offset.value, _paint);
  }

  @override
  bool shouldRepaint(HandlePainter oldDelegate) =>
      oldDelegate.handleR != handleR ||
      oldDelegate.offset != offset ||
      oldDelegate.color != color;
}
