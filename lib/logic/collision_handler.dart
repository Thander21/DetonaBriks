import 'package:flutter/material.dart' show Offset;
import '../Objects/ball.dart';
import '../Objects/brick.dart';
import 'dart:math' as math;

class CollisionHandler {
  // Verifica e trata as colisões entre uma bola e todos os blocos
  static void handleCollisions(Ball ball, List<Brick> bricks) {
    for (var brick in bricks) {
      if (_checkCollision(ball, brick)) {
        _handleCollision(ball, brick);
        brick.value--;
        break; // Assume que a bola só pode colidir com um bloco por vez
      }
    }
  }

  // Verifica se há colisão entre uma bola e um bloco
  static bool _checkCollision(Ball ball, Brick brick) {
    final distance = (ball.position - brick.position).distance;
    return distance < (Ball.radius + Brick.radius);
  }

  // Trata a colisão entre uma bola e um bloco
  static void _handleCollision(Ball ball, Brick brick) {
    // Calcula o vetor normal da colisão
    final normal = _normalizeOffset(ball.position - brick.position);

    // Calcula o vetor de reflexão
    final dotProduct =
        ball.direction.dx * normal.dx + ball.direction.dy * normal.dy;
    final reflection = Offset(ball.direction.dx - 2 * normal.dx * dotProduct,
        ball.direction.dy - 2 * normal.dy * dotProduct);

    // Atualiza a direção da bola
    ball.direction = _normalizeOffset(reflection);

    // Move a bola ligeiramente para fora do bloco para evitar colisões múltiplas
    ball.position += ball.direction *
        (Ball.radius +
            Brick.radius -
            (ball.position - brick.position).distance);
  }

  // Função auxiliar para normalizar um Offset
  static Offset _normalizeOffset(Offset offset) {
    final length = math.sqrt(offset.dx * offset.dx + offset.dy * offset.dy);
    return length > 0
        ? Offset(offset.dx / length, offset.dy / length)
        : Offset.zero;
  }
}
