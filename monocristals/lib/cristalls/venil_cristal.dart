import 'dart:js';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'function.dart';
import '../vault.dart';

class Venilcristal extends Cristal {
  Venilcristal(super.d110, super.iMul, super.l, super.fi, super.velL_velR,
      super.b, super.angle);

  @override
  Future<void> updateIntersectionPoints() async {
    List<MapEntry<Cristal, Map<String, dynamic>>> cristalsWithAngles = [
      MapEntry(this, {'angle': pi / 3, 'mirror': false}),
      MapEntry(this, {'angle': pi, 'mirror': false}),
      MapEntry(this, {'angle': pi + pi / 3, 'mirror': false}),
    ];

    await intersection(cristalsWithAngles);
    // Ensure the state is updated after calculating intersection points
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Trigger a rebuild to reflect the updated intersection points
      if (context is Element) {
        (context as Element).markNeedsBuild();
      }
    });
  }

  @override
  Future<void> intersection(
      List<MapEntry<Cristal, Map<String, dynamic>>> cristalsWithAngles) async {
    List<Offset> result = [];

    //print(result);
    intersectionPoints = result;
  }

  @override
  void draw(Canvas canvas, Size size, Paint circlePaint) {
    Path path = super.getPath();

    circlePaint = circlePaint
      ..strokeWidth = 2
      ..blendMode = BlendMode.srcOver
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 3; i++) {
      canvas.rotate((i == 0 ? 1 : 2) / 3 * pi);
      canvas.drawLine(Offset(-300, 0), Offset(300, 0), circlePaint);
      canvas.drawPath(path, circlePaint);
    }
    canvas.rotate(1 / 3 * pi);

    super.draw(canvas, size, circlePaint);
  }
}
