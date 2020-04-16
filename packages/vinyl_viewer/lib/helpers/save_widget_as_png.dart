import 'dart:ui' as ui;
import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

Future<Uint8List> saveWidgetAsPng(GlobalKey key,
    {double pixelRatio = 1.0}) async {
  try {
    RenderRepaintBoundary boundary = key.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    List<int> pngBytes = byteData.buffer.asUint8List();
    return pngBytes;
  } catch (e) {
    print(e);
    return Future<Uint8List>.value();
  }
}
