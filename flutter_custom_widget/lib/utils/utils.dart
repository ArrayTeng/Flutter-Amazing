import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;


//读取 assets 中的图片
Future<ui.Image> loadImageFromAssets(String path) async {
  ByteData data = await rootBundle.load(path);
  List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  return decodeImageFromList(bytes);
}