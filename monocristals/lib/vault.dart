import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

enum CristalType {
  PE,
  POE,
  VENIL,
  TEST, // Add new cristal type
}


String getCristalTypeText(CristalType type) {
  switch (type) {
    case CristalType.PE:
      return "PE Crystal";
    case CristalType.POE:
      return "POE Crystal";
    case CristalType.VENIL:
      return "Venil Crystal";
    // case CristalType.TEST:
    //   return "Test Crystal"; // Add new cristal type text
    default:
      return "PE Crystal";
  }
}

class Vault {
  //pe_cristal
  // static ValueNotifier<double> d_110 = ValueNotifier(0);
  // static ValueNotifier<double> i = ValueNotifier(0);
  // static ValueNotifier<double> l_0 = ValueNotifier(0);
  // static ValueNotifier<double> fi = ValueNotifier(0);
  // static ValueNotifier<double> velL_velR = ValueNotifier(0);
  // static ValueNotifier<double> b = ValueNotifier(0);
  // static ValueNotifier<double> angle = ValueNotifier(0);

  static ValueNotifier<double> imRotate = ValueNotifier(0.5 * pi);
  static ValueNotifier<double> imScale = ValueNotifier(1);
  static ValueNotifier<double> imX = ValueNotifier(0);
  static ValueNotifier<double> imY = ValueNotifier(0);
  static ValueNotifier<double> scale = ValueNotifier(200);
  static ValueNotifier<ui.Image?> bgImage = ValueNotifier<ui.Image?>(null);

  static ValueNotifier<CristalType> cristalType = ValueNotifier(CristalType.PE);

  static ValueNotifier<Path> path = ValueNotifier<Path>(Path());
}

class PEVault {
  static ValueNotifier<double> d_110 = ValueNotifier(0.25);
  static ValueNotifier<double> i = ValueNotifier(0.25);
  static ValueNotifier<double> l_0 = ValueNotifier(4.45);
  static ValueNotifier<double> fi = ValueNotifier((56.3 / 180) * pi);
  static ValueNotifier<double> velL_velR = ValueNotifier(1);
  static ValueNotifier<double> b = ValueNotifier(4.93);
  static ValueNotifier<double> angle = ValueNotifier((56.3 / 180) * pi);

  static void defaultValues() {
    double a0 = 7.4;
    double b0 = 4.93;
    double c0 = 2.55;

    // d_110.value = 0;
    // i.value = 0;
    l_0.value = 4.45;
    fi.value = (56.3 / 180) * pi;
    // velL_velR.value = 0;
    // b.value = 0;
    angle.value = (56.3 / 180) * pi;
  }
}

class POEVault {
  static ValueNotifier<bool> isAdvancedMode = ValueNotifier(false);

  static ValueNotifier<double> d_110_10 = ValueNotifier(0.1);
  static ValueNotifier<double> i_10 = ValueNotifier(0.1);
  static ValueNotifier<double> l_0_10 = ValueNotifier(4.6);
  static ValueNotifier<double> fi_10 = ValueNotifier((90.3/180)*pi);
  static ValueNotifier<double> velL_velR_10 = ValueNotifier(1);
  static ValueNotifier<double> b_10 = ValueNotifier(13.04);

  static ValueNotifier<double> d_110_12 = ValueNotifier(0.25);
  static ValueNotifier<double> i_12 = ValueNotifier(0.0001);
  static ValueNotifier<double> l_0_12 = ValueNotifier(4.6);
  static ValueNotifier<double> fi_12 = ValueNotifier(pi / 2 );
  static ValueNotifier<double> velL_velR_12 = ValueNotifier(1);
  static ValueNotifier<double> b_12 = ValueNotifier(13.04);

  static ValueNotifier<double> angle = ValueNotifier((90.3/180)*pi);

  static void defaultValues() {
    double a0 = 9.64;
    double b0 = 4.96;
    double c0 = 4.62;

    // d_110.value = 0;
    // i.value = 0;
    l_0_10.value = 4.6;
    fi_10.value = (90.3/180)*pi;
    // velL_velR.value = 0;
    // b.value = 0;
    angle.value = (90.3/180)*pi;
  }
}

class VenilVault {
  static ValueNotifier<double> d_110 = ValueNotifier(0);
  static ValueNotifier<double> i = ValueNotifier(0);
  static ValueNotifier<double> l_0 = ValueNotifier(0);
  static ValueNotifier<double> fi = ValueNotifier(0);
  static ValueNotifier<double> velL_velR = ValueNotifier(0);
  static ValueNotifier<double> b = ValueNotifier(0);
  static ValueNotifier<double> angle = ValueNotifier(0);
}

class TestVault {
  static ValueNotifier<double> d_110 = ValueNotifier(0);
  static ValueNotifier<double> i = ValueNotifier(0);
  static ValueNotifier<double> l_0 = ValueNotifier(0);
  static ValueNotifier<double> fi = ValueNotifier(0);
  static ValueNotifier<double> velL_velR = ValueNotifier(0);
  static ValueNotifier<double> b = ValueNotifier(0);
  static ValueNotifier<double> angle = ValueNotifier(0);
}