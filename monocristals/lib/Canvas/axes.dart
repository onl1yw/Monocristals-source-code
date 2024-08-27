import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void drawAxes(Canvas canvas, Size size, Paint circlePaint) {
  circlePaint = circlePaint
    ..strokeWidth = 2
    ..blendMode = BlendMode.srcOver
    ..color = Colors.grey[300]!
    ..style = PaintingStyle.fill;
  canvas.drawCircle(
      const Offset(0, 0),
      3,
      circlePaint);
// Calculate the length of the axes based on the size of the canvas
  final double axisLength = size.width * 0.8;
  final double axisHeight = size.height * 0.8;

// Draw the horizontal axis
  canvas.drawLine(
    Offset(-axisLength / 2, 0),
    Offset(axisLength / 2, 0),
    circlePaint,
  );

// Draw the vertical axis
  canvas.drawLine(
    Offset(0, -axisHeight / 2),
    Offset(0, axisHeight / 2),
    circlePaint,
  );
}
