import 'dart:js';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'function.dart';
import '../vault.dart';

class PEcristal extends Cristal {
  PEcristal(super.d110, super.iMul, super.l, super.fi, super.velL_velR, super.b,
      super.angle);

  @override
  Future<void> updateIntersectionPoints() async {
    List<MapEntry<Cristal, Map<String, dynamic>>> cristalsWithAngles = [
      MapEntry(this, {'angle': angle / 2, 'mirror': false}),
      MapEntry(this, {'angle': angle / 2 + pi, 'mirror': false}),
      MapEntry(this, {'angle': angle / 2 - pi, 'mirror': true}),
      MapEntry(this, {'angle': angle / 2, 'mirror': true}),
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

    for (var entry in cristalsWithAngles) {
      Cristal cristal = entry.key;
      double angle = entry.value['angle'];
      bool mirror = entry.value['mirror'];

      // Rotate and mirror points if necessary
      List<Offset> points = Cristal.rotateLine(cristal.points, angle);
      if (mirror) {
        points = Cristal.mirrorPoints(points);
      }

      // Check for intersections with the coordinate axes
      for (int i = 0; i < points.length - 1; i++) {
        Offset p1 = points[i];
        Offset p2 = points[i + 1];

        // Check intersection with x-axis (y = 0)
        if ((p1.dy <= 0 && p2.dy >= 0) || (p1.dy >= 0 && p2.dy <= 0)) {
          double t = p1.dy / (p1.dy - p2.dy);
          double x = p1.dx + t * (p2.dx - p1.dx);
          result.add(Offset(x, 0).scale(Cristal.scale, 0));
        }

        // Check intersection with y-axis (x = 0)
        if ((p1.dx <= 0 && p2.dx >= 0) || (p1.dx >= 0 && p2.dx <= 0)) {
          double t = p1.dx / (p1.dx - p2.dx);
          double y = p1.dy + t * (p2.dy - p1.dy);
          result.add(Offset(0, y).scale(0, Cristal.scale));
        }
      }
    }

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


    for (int i = 0; i < 2; i++) {
      canvas.rotate(PEVault.angle.value / 2);
      canvas.drawPath(path, circlePaint);
      canvas.drawLine(Offset(-300, 0), Offset(300, 0), circlePaint);
      canvas.rotate(pi);
      canvas.drawPath(path, circlePaint);
      canvas.rotate(-pi);
      canvas.rotate(-PEVault.angle.value / 2);
      canvas.scale(1, -1);
    }

    // Close the combined path

    Paint redPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw red circles at intersection points
    for (Offset point in intersectionPoints) {
      canvas.drawCircle(point, 3, redPaint);
    }

    // Draw red circles at intersection points

    super.draw(canvas, size, circlePaint);
  }
}
