import 'package:flutter/material.dart';
import '../Objects/ball.dart';
import '../Objects/brick.dart';
import '../Objects/cannon.dart';
import '../Objects/aim.dart';
import '../logic/collision_handler.dart';

// Widget principal da tela do jogo
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

// Estado do widget GameScreen, gerencia a lógica do jogo
class _GameScreenState extends State<GameScreen> with TickerProviderStateMixin {
  late List<Brick> bricks;
  late List<Ball> balls;
  late Cannon cannon;
  late AimLine aimLine;
  late AnimationController _controller;

  // Inicializa o estado do jogo
  @override
  void initState() {
    super.initState();
    bricks = [];
    balls = [];
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(_updateGame);
    _controller.repeat();
  }

  // Gera os blocos iniciais do jogo
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenSize = MediaQuery.of(context).size;
    bricks = Brick.generateBricks(screenSize, 10);
    cannon =
        Cannon(basePosition: Offset(screenSize.width / 2, screenSize.height));
    aimLine = AimLine(cannon: cannon);
  }

  // Atualiza o estado do jogo a cada frame
  void _updateGame() {
    final screenSize = MediaQuery.of(context).size;
    setState(() {
      for (var ball in balls) {
        ball.update(screenSize, balls); // Modificado aqui
        CollisionHandler.handleCollisions(ball, bricks);
      }
      balls.removeWhere((ball) => ball.isOffScreen(screenSize));
      bricks.removeWhere((brick) => brick.value <= 0);
    });
  }

  // Lança uma bola a partir de uma posição e direção específicas
  void _launchBall(Offset position, Offset direction) {
    setState(() {
      balls.add(Ball(position: position, direction: direction));
    });
  }

  // Cria a interface do usuário do jogo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF282A36),
      body: GestureDetector(
        onPanUpdate: _onPanUpdate,
        onPanStart: (details) {
          final launchPosition = Offset(
            MediaQuery.of(context).size.width / 2,
            MediaQuery.of(context).size.height,
          );
          final offset = details.localPosition - launchPosition;
          final direction =
              Offset(offset.dx / offset.distance, offset.dy / offset.distance);
          _launchBall(launchPosition, direction);
        },
        child: CustomPaint(
          painter: GamePainter(
              bricks: bricks, balls: balls, cannon: cannon, aimLine: aimLine),
          size: Size.infinite,
        ),
      ),
    );
  }

  // Atualiza a posição alvo do canhão
  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      cannon.updateTarget(details.localPosition);
    });
  }

// Limpa os recursos do controlador quando o widget é descartado
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Painter para desenhar os objetos do jogo
class GamePainter extends CustomPainter {
  final List<Brick> bricks;
  final List<Ball> balls;
  final Cannon cannon;
  final AimLine aimLine;

  GamePainter({
    required this.bricks,
    required this.balls,
    required this.cannon,
    required this.aimLine,
  });

  // Desenha os objetos do jogo na tela
  @override
  void paint(Canvas canvas, Size size) {
    // Desenhar Blocos
    for (var brick in bricks) {
      brick.paint(canvas);
    }

    // Desenhar bolas
    for (var ball in balls) {
      ball.paint(canvas);
    }

    // Desenhar canhão
    cannon.paint(canvas, size);

    // Desenhar mira
    aimLine.paint(canvas, size, balls);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
