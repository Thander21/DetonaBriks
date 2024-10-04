import 'package:flutter/material.dart';

// Classe que representa e gerencia uma bola no jogo
class Ball {
  Offset position;
  Offset direction;
  static const double speed = 5.0;
  static const double radius = 10.0;

  Ball({required this.position, required this.direction});

  // Atualiza a posição da bola e verifica colisões com as bordas da tela
  void update(Size screenSize) {
    position += direction * speed;
    _checkBoundaries(screenSize);
  }

  // Verifica e ajusta a direção da bola ao colidir com as bordas da tela
  void _checkBoundaries(Size screenSize) {
    if (position.dx <= radius || position.dx >= screenSize.width - radius) {
      direction = Offset(-direction.dx, direction.dy);
    }
    if (position.dy <= radius) {
      direction = Offset(direction.dx, -direction.dy);
    }
  }

  // Desenha a bola na tela
  void paint(Canvas canvas) {
    final ballPaint = Paint()
      ..color = const Color.fromARGB(255, 7, 133, 155)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(position, radius, ballPaint);
  }

  // Verifica se a bola saiu da tela
  bool isOffScreen(Size screenSize) {
    return position.dy > screenSize.height;
  }
}
