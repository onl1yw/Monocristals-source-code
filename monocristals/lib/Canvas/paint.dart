import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:monocristals/Canvas/image.dart';
import 'package:monocristals/cristalls/pe_cristal.dart';

import 'package:flutter/services.dart';

import '../function.dart';
import 'axes.dart';

GlobalKey key = GlobalKey();
Paint circlePaint = Paint()
  ..strokeWidth = 3
  ..color = Colors.black
  ..style = PaintingStyle.stroke
  ..blendMode = BlendMode.multiply
  ..strokeCap = StrokeCap.round;

class MyPainter extends CustomPainter {
  final OvalLine cristal;
  final ui.Image? bgImage;

  MyPainter(this.cristal, this.bgImage);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);

    if (bgImage != null) {
      drawImage(canvas, size, bgImage!); // bg image
    }

    canvas.translate(size.width / 2, size.height / 2); //translates canvas to the center

    drawAxes(canvas, size, circlePaint); // axes

    cristal.draw(canvas, size, circlePaint); // pe
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}