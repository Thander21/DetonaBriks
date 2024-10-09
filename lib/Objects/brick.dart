import 'package:flutter/material.dart';
import 'dart:math';

class Brick {
  Offset position;
  int value;
  static const double radius = 25.0;
  Color color;

  Brick({required this.position, required this.value, required this.color});

  // Gera uma lista de blocos estrategicamente posicionados
  static List<Brick> generateBricks(Size screenSize, int count) {
    final random = Random();
    final bricks = <Brick>[];
    final gridSize = sqrt(count).ceil();
    final cellWidth = screenSize.width / gridSize;
    final cellHeight = (screenSize.height / 2) / gridSize;

    for (int i = 0; i < count; i++) {
      final row = i ~/ gridSize;
      final col = i % gridSize;
      final value = random.nextInt(25) + 1;
      final position = Offset(
        (col + 0.5) * cellWidth,
        (row + 0.5) * cellHeight,
      );

      bricks.add(Brick(
        position: position,
        value: value,
        color: _getColorForValue(value),
      ));
    }

    return bricks;
  }

  // Retorna a cor baseada no valor do bloco
  static Color _getColorForValue(int value) {
    final colorRange = value ~/ 5;
    switch (colorRange) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      default:
        return Colors.purple;
    }
  }

  // Desenha o bloco na tela
  void paint(Canvas canvas) {
    final brickPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, radius, brickPaint);

    // Desenhar o valor do Bloco
    final textPainter = TextPainter(
      text: TextSpan(
        text: value.toString(),
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      position - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }
}
