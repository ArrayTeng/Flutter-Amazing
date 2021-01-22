import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_widget/page04_canvas_image/level1_image/paper.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIOverlays([]);

  runApp(
    Container(
      color: Colors.white,
      child: Paper(),
    ),
  );
}
