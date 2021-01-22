import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_widget/page03_canvas/operation_scale_grid/paper.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(Paper());
}
