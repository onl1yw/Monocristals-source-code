import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:monocristals/Floating%20settings/save.dart';
import 'package:monocristals/Floating%20settings/image.dart';

import 'memo.dart';

class FloatingButtons extends StatelessWidget {
  FloatingButtons();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      top: 10,
      child: Row(
        children: <Widget>[
          SaveFloatingButton(),
          const SizedBox(width: 5),
          ImageFloatingButton(),
          const SizedBox(width: 5),
          MemoFloatingButton(),
        ],
      ),
    );
  }
}
