# GunGame

Um jogo de tiro desenvolvido em Flutter, onde o jogador controla um canhão para atirar em elementos na tela.

## Estrutura do Projeto
lib/
├── game_logic/
│ ├── collision_detector.dart
│ ├── element_generator.dart
│ ├── game_controller.dart
│ └── game_state.dart
├── models/
│ ├── ball.dart
│ ├── cannon.dart
│ └── element.dart
├── painters/
│ ├── ball_painter.dart
│ ├── cannon_painter.dart
│ ├── element_painter.dart
│ └── game_painter.dart
├── screens/
│ └── game_screen.dart
├── utils/
│ └── constants.dart
├── widgets/
│ └── game_view.dart
└── main.dart

## Descrição dos Componentes

1. `main.dart`: Ponto de entrada do aplicativo. Inicializa o WindowManager e executa o MyApp.

2. `screens/game_screen.dart`: Tela principal do jogo. Inicializa o GameController, gerencia o estado do jogo e lida com as interações do usuário.

3. `game_logic/game_controller.dart`: Controla a lógica principal do jogo, incluindo a inicialização, atualização e gerenciamento de estados.

4. `game_logic/game_state.dart`: Mantém o estado atual do jogo, incluindo elementos e bolas.

5. `game_logic/collision_detector.dart`: Detecta e gerencia colisões entre bolas e elementos.

6. `game_logic/element_generator.dart`: Gera elementos aleatórios para o jogo.

7. `models/`: Contém as classes de modelo para bolas, canhões e elementos do jogo.

8. `painters/`: Contém classes responsáveis por desenhar os diferentes componentes do jogo na tela.

9. `widgets/game_view.dart`: Widget que renderiza a visualização do jogo usando CustomPaint.

10. `utils/constants.dart`: Armazena constantes utilizadas em todo o projeto.

## Fluxo do Programa

1. O aplicativo inicia em `main.dart`, que configura o WindowManager e executa `MyApp`.
2. `MyApp` define o tema e a rota inicial para `GameScreen`.
3. `GameScreen` inicializa o `GameController`, `Cannon` e configura um timer para atualizar o jogo periodicamente.
4. O `GameController` gerencia a lógica do jogo, incluindo a criação e movimentação de bolas.
5. Quando o jogador toca na tela, `GameScreen` chama `GameController` para criar uma nova bola.
6. `GameView` usa `BallPainter` e `CannonPainter` para renderizar o estado atual do jogo na tela.
7. O ciclo continua com atualizações constantes do estado do jogo e re-renderização da tela.

Este projeto demonstra o uso de conceitos avançados de Flutter, como CustomPainter para renderização personalizada, gerenciamento de estado, e organização de código em uma arquitetura modular.