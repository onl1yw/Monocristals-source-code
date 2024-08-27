import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';


class Vault {
  //pe_cristal
  static ValueNotifier<double> d_110 = ValueNotifier(0);
  static ValueNotifier<double> i = ValueNotifier(0);
  static ValueNotifier<double> l_0 = ValueNotifier(0);
  static ValueNotifier<double> fi = ValueNotifier(0);
  static ValueNotifier<double> velL_velR = ValueNotifier(0);
  static ValueNotifier<double> b = ValueNotifier(0);
  static ValueNotifier<double> angle = ValueNotifier(0);

  static ValueNotifier<double> imRotate = ValueNotifier(0.5 * pi);
  static ValueNotifier<double> imScale = ValueNotifier(1);
  static ValueNotifier<double> imX = ValueNotifier(0);
  static ValueNotifier<double> imY = ValueNotifier(0);
  static ValueNotifier<double> scale = ValueNotifier(200);
  static ValueNotifier<ui.Image?> bgImage = ValueNotifier<ui.Image?>(null);


  static ValueNotifier<Path> path = ValueNotifier<Path>(Path());
}

class PEVault {
  static ValueNotifier<double> d_110 = ValueNotifier(0);
  static ValueNotifier<double> i = ValueNotifier(0);
  static ValueNotifier<double> l_0 = ValueNotifier(0);
  static ValueNotifier<double> fi = ValueNotifier(0);
  static ValueNotifier<double> velL_velR = ValueNotifier(0);
  static ValueNotifier<double> b = ValueNotifier(0);
  static ValueNotifier<double> angle = ValueNotifier(0);

  void defaultValues() {
    double a0 = 7.4;
    double b0 = 4.93;
    double c0 = 2.55;

    // d_110.value = 0;
    // i.value = 0;
    l_0.value = 4.45;
    fi.value = (56.3 / 180) * pi;
    // velL_velR.value = 0;
    // b.value = 0;
    // angle.value = 0;
  }
}
