import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:monocristals/Canvas/paint.dart';
import 'dart:async';

import '../Floating settings/floating_buttons.dart';
import '../function.dart';

class CustomCanvas extends StatelessWidget {
  final OvalLine cristal;
  final ui.Image? bgImage;

  const CustomCanvas({required this.cristal, this.bgImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomPaint(
            painter: MyPainter(cristal, bgImage),
            child: Container(),
          ),
          FloatingButtons(),
        ],
      ),
    );
  }
}
