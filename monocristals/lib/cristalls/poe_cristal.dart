import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:monocristals/cristalls/function.dart';

import '../vault.dart';

class POEcristal120 extends OvalLine{
  POEcristal120(super.d110, super.iMul, super.l, super.fi, super.velL_velR, super.b);
  @override
  void draw(Canvas canvas, Size size, Paint circlePaint) {
    Path path = super.getPath();

    circlePaint = circlePaint
      ..strokeWidth = 2
      ..blendMode = BlendMode.srcOver
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke;

    canvas.rotate(1/2 * pi);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(pi);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(-pi);
    canvas.rotate(-1/2 * pi);

    super.draw(canvas, size, circlePaint);
  }
}

class POEcristal100 extends OvalLine{
  POEcristal100(super.d110, super.iMul, super.l, super.fi, super.velL_velR, super.b);
  @override
  void draw(Canvas canvas, Size size, Paint circlePaint) {
    Path path = super.getPath();

    circlePaint = circlePaint
      ..strokeWidth = 2
      ..blendMode = BlendMode.srcOver
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke;

    canvas.rotate(POEVault.angle.value / 2);
    canvas.drawLine(
        Offset(-300, 0),
        Offset(300, 0),
        circlePaint);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(pi);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(-pi);
    canvas.rotate(-POEVault.angle.value / 2);
    canvas.scale(1, -1);
    canvas.rotate(POEVault.angle.value / 2);
    canvas.drawLine(Offset(-300, 0), Offset(300, 0), circlePaint);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(pi);
    canvas.drawPath(path, circlePaint);
    canvas.rotate(-pi);
    canvas.rotate(-POEVault.angle.value / 2);
    canvas.scale(1, -1);

    super.draw(canvas, size, circlePaint);
  }
}


