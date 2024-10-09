import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'ball.dart';
import 'cannon.dart';

class AimLine {
  final Cannon cannon;
  static const double aimLength = 600.0;

  AimLine({required this.cannon});

  void paint(Canvas canvas, Size size, List<Ball> balls) {
    final aimPaint = Paint()
      ..color = Colors.red.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    List<Offset> trajectory = calculateAimTrajectory(size, balls);
    for (int i = 0; i < trajectory.length - 1; i++) {
      canvas.drawLine(trajectory[i], trajectory[i + 1], aimPaint);
    }
  }

  List<Offset> calculateAimTrajectory(Size size, List<Ball> balls) {
    List<Offset> trajectory = [];
    Offset currentPosition = cannon.basePosition;
    Offset direction =
        _normalizeOffset(cannon.targetPosition - cannon.basePosition);

    for (int i = 0; i < 100; i++) {
      trajectory.add(currentPosition);
      currentPosition += direction * 10;

      if (currentPosition.dx < 0 ||
          currentPosition.dx > size.width ||
          currentPosition.dy < 0 ||
          currentPosition.dy > size.height) {
        break;
      }

      // Simular colisão com bolas existentes
      for (var ball in balls) {
        if ((currentPosition - ball.position).distance < Ball.radius * 2) {
          direction = _normalizeOffset(currentPosition - ball.position);
          break;
        }
      }
    }

    return trajectory;
  }

  Offset _normalizeOffset(Offset offset) {
    double length = math.sqrt(offset.dx * offset.dx + offset.dy * offset.dy);
    return Offset(offset.dx / length, offset.dy / length);
  }
}
