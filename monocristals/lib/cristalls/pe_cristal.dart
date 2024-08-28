import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'function.dart';
import '../vault.dart';

class PEcristal extends OvalLine{
  PEcristal(super.d110, super.iMul, super.l, super.fi, super.velL_velR, super.b);

  @override
  void draw(Canvas canvas, Size size, Paint circlePaint) {
    Path path = super.getPath();

    circlePaint = circlePaint
      ..strokeWidth = 2
      ..blendMode = BlendMode.srcOver
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke;

    canvas.rotate(PEVault.angle.value / 2);
    canvas.drawLine(
        Offset(-300, 0),
        Offset(300, 0),
        circlePaint);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(pi);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(-pi);
    canvas.rotate(-PEVault.angle.value / 2);
    canvas.scale(1, -1);
    canvas.rotate(PEVault.angle.value / 2);
    canvas.drawLine(Offset(-300, 0), Offset(300, 0), circlePaint);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(pi);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(-pi);
    canvas.rotate(-PEVault.angle.value / 2);
    canvas.scale(1, -1);
    super.draw(canvas, size, circlePaint);
  }
}