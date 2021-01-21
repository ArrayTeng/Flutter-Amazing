import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//[1]. 练习平移操作: 通过线的平移绘制出右下角四分之一网格线
//[2]. 练习缩放操作: 通过缩放四分之一网格线，绘制出另外四分之三网格线
//[3]. 了解画布的存储【save】和恢复【restore】用法
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

//练习画布的平移操作
class PaperPainter extends CustomPainter {

  Paint _gridPaint;

  final double step = 20;

  PaperPainter() {
    _gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey
      ..strokeWidth = .5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;

    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(Offset(0, 0), 50, paint);

    canvas.drawLine(Offset(0, 0),Offset(50,60), paint
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = Colors.red);

    _drawGrid(canvas,size);

  }

  void _drawBottomRight(Canvas canvas, Size size){
    canvas.save();
    for(int i = 0;i<size.height/2/step;i++){
      canvas.drawLine(Offset(0, 0),Offset(size.width/2, 0), _gridPaint);
      //translate 移动画布起点
      canvas.translate(0, step);
    }
    canvas.restore();
    
    canvas.save();
    for(int i = 0;i<size.width/2/step;i++){
      canvas.drawLine(Offset(0, 0), Offset(0, size.height/2), _gridPaint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size){
    _drawBottomRight(canvas,size);
    canvas.save();
    //沿x轴镜像
    canvas.scale(1,-1);
    _drawBottomRight(canvas,size);
    canvas.restore();

    canvas.save();
    //沿y轴镜像
    canvas.scale(-1,1);
    _drawBottomRight(canvas,size);
    canvas.restore();

    canvas.save();
    //沿原点镜像
    canvas.scale(-1,-1);
    _drawBottomRight(canvas,size);
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
