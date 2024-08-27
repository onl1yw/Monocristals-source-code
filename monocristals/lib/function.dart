import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:monocristals/vault.dart';
import 'settings/settings.dart';

class OvalLine {
  late double _d110;
  late double _iMul;
  late double _l;
  late double _fi;
  late double _velL_velR;
  late double _b;

  late double _A;
  late double _B;
  late double _C;

  static double _scale = 200; //= 0.025;
  static double _step = 0.001;

  late List<Offset> _points;

  static double _cot(double angle) {
    return cos(angle) / sin(angle);
  }

  static double round(double a, int place) {
    double rounded = double.parse(a.toStringAsFixed(place));
    return rounded;
  }

  OvalLine(
      this._d110, this._iMul, this._l, this._fi, this._velL_velR, this._b) {
    _A = (_velL_velR - 1) / 2;
    _B = (_velL_velR + 1) / 2;
    _C = _b * sqrt(_iMul * (_b * 2));
    _getPoints();
  }

  // OvalLine(){
  //   update();
  // }

  void update(
      {double? d110,
      double? iMul,
      double? l,
      double? fi,
      double? velL_velR,
      double? b}) {


    _d110 = d110 ?? _d110;
    _iMul = iMul ?? _iMul;
    _l = l ?? _l;
    _fi = fi ?? _fi;
    _velL_velR = velL_velR ?? _velL_velR;
    _b = b ?? _b;

    _A = (_velL_velR - 1) / 2;
    _B = (_velL_velR + 1) / 2;
    _C = _b * sqrt(_iMul * (_b * 2));

    _getPoints();
  }

  Offset _distortion(double x, double y) {
    y = y * (_d110 / _l);
    if (x /** _scale*/ < _A) {
      x = x - (_d110 * sqrt(_iMul * 2 * _B) - y) * _cot(_fi);
    } else {
      x = x + (_d110 * sqrt(_iMul * 2 * _B) - y) * _cot(-_fi);
    }

    return Offset(x, y);
  }

  double _function(double x) {
    x = ((x /**_scale*/ + _A) / _B);
    double y = (_C * sqrt((1 - pow(x, 2)).abs()));
    y = -y /*/sqrt(_scale)*/;
    return y; // invert the y value
  }

  Future<void> _getPoints() async {
    double start_x = (-_B - _A) /*/_scale*/; // ограничиваем функцию
    double end_x = (_B - _A) /*/_scale*/;
    Offset d;

    _points = []; // Clear the points list

    // Start the path at the first point
    double y = _function(start_x);
    d = _distortion(start_x, y);
    _points.add(d.scale(_scale, _scale)); // Add the point to the list

    for (double x = start_x; x <= end_x + _step; x += _step) {
      double y = _function(x);
      d = _distortion(x, y);
      _points.add(d.scale(_scale, _scale)); // Add the point to the list

      if (x.isInfinite) {
        break;
      }
    }

    d = _distortion(end_x, 0);
    _points.add(d.scale(_scale, 0)); // Add the point to the list
  }

  Path getPath() {
    Path path = Path();

    // Start the path at the first point
    if (_points.isNotEmpty) {
      path.moveTo(_points[0].dx, _points[0].dy);

      // Add the rest of the points to the path
      for (int i = 1; i < _points.length; i++) {
        path.lineTo(_points[i].dx, _points[i].dy);
      }
    }

    return path;
  }

  void draw(Canvas canvas, Size size, Paint circlePaint) {}

  static set scale(double value) {
    _scale = value;
  }

  static set step(double value) {
    _step = value;
  }
}
