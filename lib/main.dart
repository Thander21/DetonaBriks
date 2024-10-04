import 'package:flutter/material.dart';
import 'ui/game_screen.dart';

// Função principal que inicia a aplicação
void main() {
  runApp(const MyApp());
}

// Classe principal do aplicativo, que herda de StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Método build que constrói a interface do usuário
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GameGun',
      theme: ThemeData(),
      home: const GameScreen(),
    );
  }
}
