import 'package:flutter/material.dart';
import 'dart:math' as math;

// Classe que representa e gerencia uma bola no jogo
class Ball {
  Offset position;
  Offset direction;
  double speed;
  static const double defaultSpeed = 5.0;
  static const double radius = 10.0;
  static const double speedIncrease = 0.5;
  static const double speedDecrease = 0.2;

  Ball({required this.position, required this.direction})
      : speed = defaultSpeed;

  // Atualiza a posição da bola e verifica colisões com as bordas da tela
  void update(Size screenSize, List<Ball> balls) {
    position += direction * speed;
    _checkBoundaries(screenSize);
    _checkCollisionsWithBalls(balls);
  }

  // Verifica e ajusta a direção da bola ao colidir com as bordas da tela
  void _checkBoundaries(Size screenSize) {
    if (position.dx <= radius || position.dx >= screenSize.width - radius) {
      direction = Offset(-direction.dx, direction.dy);
      _decreaseSpeed();
    }
    if (position.dy <= radius) {
      direction = Offset(direction.dx, -direction.dy);
      _decreaseSpeed();
    }
  }

  // Verifica e ajusta a direção da bola ao colidir com outras bolas
  void _checkCollisionsWithBalls(List<Ball> balls) {
    for (var otherBall in balls) {
      if (otherBall != this) {
        if (_isColliding(otherBall)) {
          _handleCollision(otherBall);
          _increaseSpeed();
        }
      }
    }
  }

  // Verifica se a bola está colidindo com outra bola
  bool _isColliding(Ball otherBall) {
    return (position - otherBall.position).distance <= 2 * radius;
  }

  // Ajusta a direção das bolas ao colidir
  void _handleCollision(Ball otherBall) {
    final collisionVector = position - otherBall.position;
    final collisionAngle = math.atan2(collisionVector.dy, collisionVector.dx);

    final thisNewDirection = Offset(
      math.cos(collisionAngle),
      math.sin(collisionAngle),
    );
    final otherNewDirection = Offset(
      math.cos(collisionAngle + math.pi),
      math.sin(collisionAngle + math.pi),
    );

    direction = thisNewDirection;
    otherBall.direction = otherNewDirection;
  }

  // Aumenta a velocidade da bola
  void _increaseSpeed() {
    speed += speedIncrease;
  }

  // Diminui a velocidade da bola
  void _decreaseSpeed() {
    speed = math.max(defaultSpeed, speed - speedDecrease);
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
