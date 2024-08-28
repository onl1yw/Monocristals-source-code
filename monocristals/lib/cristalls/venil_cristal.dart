import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'function.dart';
import '../vault.dart';

class Venilcristal extends OvalLine{
  Venilcristal(super.d110, super.iMul, super.l, super.fi, super.velL_velR, super.b);

  @override
  void draw(Canvas canvas, Size size, Paint circlePaint) {
    Path path = super.getPath();

    circlePaint = circlePaint
      ..strokeWidth = 2
      ..blendMode = BlendMode.srcOver
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke;

    canvas.rotate(-1/6 * pi);
    canvas.rotate(1/2 * pi);
    canvas.drawLine(
        Offset(-300, 0),
        Offset(300, 0),
        circlePaint);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(2/3 * pi);
    canvas.drawLine(
        Offset(-300, 0),
        Offset(300, 0),
        circlePaint);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(2/3 * pi);
    canvas.drawLine(
        Offset(-300, 0),
        Offset(300, 0),
        circlePaint);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(2/3 * pi);
    canvas.rotate(-1/2 * pi);
    canvas.rotate(1/6 * pi);

    canvas.scale(1, -1);

    super.draw(canvas, size, circlePaint);
  }
}