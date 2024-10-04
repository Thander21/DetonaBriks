import 'package:flutter/material.dart';
import 'dart:math';

class Brick {
  Offset position;
  int value;
  static const double radius = 25.0;

  Brick({required this.position, required this.value});

  // Gera uma lista de blocos aleatórios
  static List<Brick> generateBricks(Size screenSize, int count) {
    final random = Random();
    return List.generate(count, (index) {
      return Brick(
        position: Offset(
          random.nextDouble() * (screenSize.width - 2 * radius),
          random.nextDouble() * (screenSize.height / 2),
        ),
        value: random.nextInt(25) + 1,
      );
    });
  }

  // Desenha o bloco na tela
  void paint(Canvas canvas) {
    final brickPaint = Paint()
      ..color = const Color(0xFFFF79C6) // Cor rosa do tema Dracula
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, radius, brickPaint);

    // Desenhar o valor do Bloco
    final textPainter = TextPainter(
      text: TextSpan(
        text: value.toString(),
        style: const TextStyle(color: Color(0xFF282A36), fontSize: 16),
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
