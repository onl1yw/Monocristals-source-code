import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:monocristals/Canvas/paint.dart';
import 'dart:async';

import '../Floating settings/floating_buttons.dart';
import '../cristalls/function.dart';

class CustomCanvas extends StatelessWidget {
  final List<OvalLine> cristals;
  final ui.Image? bgImage;

  const CustomCanvas({required this.cristals, this.bgImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomPaint(
            painter: MyPainter(cristals, bgImage),
            child: Container(),
          ),
          FloatingButtons(),
        ],
      ),
    );
  }
}
