import 'dart:math';
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cristal {
  late double _d110;
  late double _iMul;
  late double _l;
  late double _fi;
  late double _velL_velR;
  late double _b;
  late double angle;

  late double _A;
  late double _B;
  late double _C;

  static double scale = 1; //= 0.025;
  static double _step = 0.005;

  late List<Offset> _points;
  late List<Offset> intersectionPoints = [];

  static double _cot(double angle) {
    return cos(angle) / sin(angle);
  }

  static double round(double a, int place) {
    double rounded = double.parse(a.toStringAsFixed(place));
    return rounded;
  }

  Cristal(this._d110, this._iMul, this._l, this._fi, this._velL_velR, this._b,
      this.angle) {
    _A = (_velL_velR - 1) / 2;
    _B = (_velL_velR + 1) / 2;
    _C = _b * sqrt(_iMul * (_b * 2));
    _getPoints();
    updateIntersectionPoints();
  }

  void update(
      {double? d110,
      double? iMul,
      double? l,
      double? fi,
      double? velL_velR,
      double? b,
      double? angle}) {
    _d110 = d110 ?? _d110;
    _iMul = iMul ?? _iMul;
    _l = l ?? _l;
    _fi = fi ?? _fi;
    _velL_velR = velL_velR ?? _velL_velR;
    _b = b ?? _b;
    angle = angle ?? angle;

    _A = (_velL_velR - 1) / 2;
    _B = (_velL_velR + 1) / 2;
    _C = _b * sqrt(_iMul * (_b * 2));

    _getPoints();
    updateIntersectionPoints();
  }

  Future<void> updateIntersectionPoints() async {}

  Offset _distortion(double x, double y) {
    y = y * (_d110 / _l);
    if (x < _A) {
      x = x - (_d110 * sqrt(_iMul * 2 * _B) - y) * _cot(_fi);
    } else {
      //x = x + (_d110 * sqrt(_iMul * 2 * _B) - y) * _cot(-_fi);
      x = x + (_d110 * sqrt(_iMul * 2 * _B) - y) * _cot((pi - _fi) / 2);
    }

    return Offset(x, y);
  }

  Offset reverseDistortion(Offset a) {
    double x = a.dx;
    double y = a.dy;
    double yn = y * (_l / _d110);

    double xn1 = x + ((_d110 * sqrt(_iMul * 2 * _B) - y) * _cot(_fi));
    double xn2 =
        x - ((_d110 * sqrt(_iMul * 2 * _B) - y) * _cot((pi - _fi) / 2));

    double xn;
    if (xn1 < _A) {
      xn = xn1;
    } else {
      xn = xn2;
    }

    return Offset(xn, yn);
  }

  double _function(double x) {
    x = ((x /**_scale*/ + _A) / _B);
    double y = (_C * sqrt((1 - pow(x, 2)).abs()));
    y = -y /*/sqrt(_scale)*/;
    return y; // invert the y value
  }

  // временно
  List<Offset> getCleanPoints() {
    double start_x = (-_B - _A) /*/_scale*/; // ограничиваем функцию
    double end_x = (_B - _A) /*/_scale*/;
    Offset d;

    List<Offset> res = []; // Clear the points list

// Start the path at the first point
    double y = _function(start_x);
    d = Offset(start_x, y);
    res.add(d /*.scale(_scale, _scale)*/); // Add the point to the list

    for (double x = start_x; x <= end_x + _step; x += _step) {
      double y = _function(x);
      d = Offset(x, y);
      res.add(d /*.scale(_scale, _scale)*/);
      // Add the point to the list

      if (x.isInfinite) {
        break;
      }
    }

    d = Offset(end_x, 0);
    res.add(d /*.scale(_scale, 0)*/); // Add the point to the list
    return res;
  }

  Future<void> _getPoints() async {
    double start_x = (-_B - _A) /*/_scale*/; // ограничиваем функцию
    double end_x = (_B - _A) /*/_scale*/;
    Offset d;

    _points = []; // Clear the points list

// Start the path at the first point
    double y = _function(start_x);
    d = _distortion(start_x, y);
    _points.add(d /*.scale(_scale, _scale)*/); // Add the point to the list
    Offset previousPoint = d;

    for (double x = start_x; x <= end_x + _step; x += _step) {
      double y = _function(x);
      d = _distortion(x, y);

      if ((previousPoint - d).distanceSquared > _step) {
        int numPoints = ((previousPoint - d).distance / (_step)).ceil();
        for (int j = 1; j < numPoints; j++) {
          double t = j / numPoints;
          Offset interpolatedPoint = Offset(
            previousPoint.dx + t * (d.dx - previousPoint.dx),
            previousPoint.dy + t * (d.dy - previousPoint.dy),
          );
          _points.add(interpolatedPoint);
        }
      }
      _points.add(d /*.scale(_scale, _scale)*/); // Add the point to the list

      previousPoint = d;
      if (x.isInfinite) {
        break;
      }
    }

    d = _distortion(end_x, 0);
    _points.add(d /*.scale(_scale, 0)*/); // Add the point to the list
  }

  Path getPath() {
    Path path = Path();

// Start the path at the first point
    if (_points.isNotEmpty) {
      Offset a = _points[0].scale(scale, scale);
      path.moveTo(a.dx, a.dy);

// Add the rest of the points to the path
      for (int i = 1; i < _points.length; i++) {
        a = _points[i].scale(scale, scale);
        path.lineTo(a.dx, a.dy);
      }
    }

    return path;
  }

  void draw(Canvas canvas, Size size, Paint circlePaint) {}

  List<Offset> get points => _points;

  Offset point(x) => _distortion(x, _function(x)) /** _scale*/;

  List<double> get domain => [-_B - _A, _B - _A];

  double function(x) => _function(x);

  Offset distortion(Offset x) => _distortion(x.dx, x.dy);

  static List<Offset> translate(List<Offset> points, Offset offset) {
    List<Offset> result = [];

    for (Offset point in points) {
      double x = point.dx + offset.dx;
      double y = point.dy + offset.dy;

      result.add(Offset(x, y));
    }

    return result;
  }

  static Offset rotatePoint(Offset point, double angle) {
    double x = point.dx;
    double y = point.dy;

    double cosA = cos(angle);
    double sinA = sin(angle);

    double x1 = x * cosA - y * sinA;
    double y1 = x * sinA + y * cosA;

    return Offset(x1, y1);
  }

  static List<Offset> rotateLine(List<Offset> points, double angle) {
    List<Offset> result = [];

    double cosA = cos(angle);
    double sinA = sin(angle);

    for (Offset point in points) {
      double x = point.dx;
      double y = point.dy;

      double x1 = x * cosA - y * sinA;
      double y1 = x * sinA + y * cosA;

      result.add(Offset(x1, y1));
    }

    return result;
  }

  static List<Offset> mirrorPoints(List<Offset> points) {
    return points.map((point) => Offset(-point.dx, point.dy)).toList();
  }

  Future<void> intersection(
      List<MapEntry<Cristal, Map<String, dynamic>>> cristalsWithAngles) async {
    List<Offset> result = [];

    intersectionPoints = result;
  }

  static set step(double value) {
    _step = value;
  }
}
