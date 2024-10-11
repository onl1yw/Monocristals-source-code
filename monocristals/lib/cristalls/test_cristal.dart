import 'dart:js';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'function.dart';

class TestCristal extends Cristal {
  TestCristal(super.d110, super.iMul, super.l, super.fi, super.velL_velR,
      super.b, super.angle);

  @override
  void draw(Canvas canvas, Size size, Paint circlePaint) {
    Path path = super.getPath();

    circlePaint = circlePaint
      ..strokeWidth = 2
      ..blendMode = BlendMode.srcOver
      ..color = Colors.blue
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 3; i++) {
      canvas.rotate((i == 0 ? 1 : 2) / 3 * pi);
      canvas.drawLine(Offset(-300, 0), Offset(300, 0), circlePaint);
      canvas.drawPath(path, circlePaint);
    }
    canvas.rotate(1 / 3 * pi);
    canvas.drawPath(path, circlePaint);

    for (int i = 0; i < points.length; i += 1) {
      canvas.drawCircle(
          points[i].scale(Cristal.scale, Cristal.scale) + Offset(0, 0),
          3,
          circlePaint = circlePaint
            ..strokeWidth = 2
            ..blendMode = BlendMode.srcOver
            ..color = Colors.green
            ..style = PaintingStyle.stroke);
      canvas.drawCircle(
          reverseDistortion(points[i].scale(Cristal.scale, Cristal.scale)) +
              Offset(0 * Cristal.scale, 0),
          3,
          circlePaint = circlePaint
            ..strokeWidth = 2
            ..blendMode = BlendMode.srcOver
            ..color = Colors.grey
            ..style = PaintingStyle.stroke);
    }

    Paint redPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Paint greenPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (Offset point in intersectionPoints) {
      canvas.drawCircle(point, 3, redPaint);
    }

    super.draw(canvas, size, circlePaint);
  }

  @override
  Future<void> updateIntersectionPoints() async {
    List<MapEntry<Cristal, Map<String, dynamic>>> cristalsWithAngles = [
      MapEntry(this, {'angle': pi / 3, 'mirror': false}),
      MapEntry(this, {'angle': pi, 'mirror': false}),
      MapEntry(this, {'angle': -pi / 3, 'mirror': false}),
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

    double centerX = 0;
    double centerY = 0;
    double radius = 0;
    double radiusIncrement = 1;
    int increment = 20;// Adjust as needed

    while (radius < 1000) { // Adjust the maximum radius as needed
      radius += radiusIncrement;

      List<Offset> intersections = [];

      for (var entry in cristalsWithAngles) {
        Cristal cristal = entry.key;
        double angle = entry.value['angle'];
        bool mirror = entry.value['mirror'];

        // Rotate and mirror points if necessary
        List<Offset> points = Cristal.rotateLine(cristal.points, angle);
        if (mirror) {
          points = Cristal.mirrorPoints(points);
        }

        for (int i = 0; i < points.length; i += increment) {
          Offset point = points[i].scale(Cristal.scale, Cristal.scale);
          double dx = point.dx - centerX;
          double dy = point.dy - centerY;
          double distancesq = dx * dx + dy * dy;

          if ((distancesq - radius * radius).abs() < 5) { // Adjust the tolerance as needed
            intersections.add(point.scale(Cristal.scale, Cristal.scale));
          }
        }
      }
      // Add unique intersection points to the result
      for (Offset intersection in intersections) {
        bool isUnique = true;
        for (Offset existing in result) {
          if ((existing - intersection).distanceSquared < 5) { // Adjust the tolerance as needed
            isUnique = false;
            break;
          }
        }
        if (isUnique) {
          result.add(intersection);
          //print("penis");
        }
      }
    }
    intersectionPoints = result;
  }
}

//   @override
//   Future<void> intersection(
//       List<MapEntry<Cristal, Map<String, dynamic>>> cristalsWithAngles) async {
//     List<Offset> result = [];
//
//     for (var entry in cristalsWithAngles) {
//       Cristal cristal = entry.key;
//       double angle = entry.value['angle'];
//       bool mirror = entry.value['mirror'];
//
//       // Rotate and mirror points if necessary
//       List<Offset> points = Cristal.rotateLine(cristal.points, angle);
//       if (mirror) {
//         points = Cristal.mirrorPoints(points);
//       }
//
//       // var point = points[52];
//       // point = points[0];
//       //
//       // result.add(points[210].scale(Cristal.scale, Cristal.scale));
//       // result.add(points[205].scale(Cristal.scale, Cristal.scale));
//       // result.add(points[200].scale(Cristal.scale, Cristal.scale));
//
//       for (int i = 0; i < points.length; i += 1) {
//         var point = points[i];
//
//           //result.add(point.scale(Cristal.scale, Cristal.scale));
//         for (var otherEntry in cristalsWithAngles) {
//           //if (otherEntry.key == cristal) continue; // Skip the current crystal
//           Cristal otherCristal = otherEntry.key;
//           double otherAngle = otherEntry.value['angle'];
//           bool otherMirror = otherEntry.value['mirror'];
//
//           // Rotate and mirror points of the other crystal if necessary
//           Offset checkPoint = Cristal.rotatePoint(point, -angle + otherAngle);
//             //result.add(checkPoint.scale(Cristal.scale, Cristal.scale));
//           //result.add(checkPoint * Cristal.scale);
//           // if (otherMirror) {
//           //   checkPoint = Offset(-point.dx, point.dy);
//           // }
//           checkPoint = otherEntry.key.reverseDistortion(checkPoint);
//             //result.add(checkPoint.scale(Cristal.scale, Cristal.scale));
//           checkPoint = checkPoint;
//             result.add(checkPoint.scale(Cristal.scale, Cristal.scale));
//
//           // Add the point and its transformations to the result
//           if ((otherCristal.function(checkPoint.dx) - checkPoint.dy).abs() <
//               0.05) {
//             Offset fin = Cristal.rotatePoint(
//                 point.scale(Cristal.scale, Cristal.scale), 0);
//             result.add(fin);
//           }
//         }
//       }
//     }
//     result.add(Offset(0, 0));
//
//     intersectionPoints = result;
//   }
// }

// result.add(points[adad]);
// result.add(Cristal.rotatePoint(points[adad] , -pi / 3));
// result.add(reverseDistortion( Cristal.rotatePoint(points[adad] , -pi / 3)));
