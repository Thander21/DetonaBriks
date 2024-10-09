import 'package:flutter/material.dart';
import 'dart:math' as math;

class Cannon {
  final Offset basePosition;
  Offset targetPosition;
  static const double length = 50.0;
  static const double width = 10.0;

  Cannon({required this.basePosition}) : targetPosition = basePosition;

  void updateTarget(Offset newTarget) {
    targetPosition = newTarget;
  }

  void paint(Canvas canvas, Size size) {
    final cannonPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    // Desenha o canhão
    canvas.save();
    canvas.translate(basePosition.dx, basePosition.dy);
    double angle = math.atan2(targetPosition.dy - basePosition.dy,
        targetPosition.dx - basePosition.dx);
    canvas.rotate(angle);
    canvas.drawRect(Rect.fromLTWH(0, -width / 2, length, width), cannonPaint);
    canvas.restore();

    // Desenha a base
    canvas.drawCircle(basePosition, width * 1.5, cannonPaint);
  }
}
