import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          color: Colors.blue,
          width: 300, height: 300, child: _buildChildWidget()),
    );
  }

  Widget _buildChildWidget() {
    final Widget withLayoutBuilder = LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return CustomPaint(
        size: Size(constraints.maxWidth, constraints.maxHeight),
        painter: BgPainter(),
      );
    });

    return withLayoutBuilder;
  }
}

//建议数据成员都从外界获得原因之一，这样可以很明确知道有哪些成员，容易比较他们是否一致。
class BgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    Paint paint = Paint()
      ..color = Colors.yellow
      //..strokeWidth = 5
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawArc(
        Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100),
        pi * (1 / 6),
        pi * (5 / 3),
        true,
        paint);

    canvas.drawCircle(Offset(100, 0), 20, paint);

    canvas.drawCircle(Offset(150, 0), 20, paint);


    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
