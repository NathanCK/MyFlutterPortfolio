import 'package:conway_game_of_life/game_of_life_board.dart';
import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: GameOfLife(
        cellSize: 7,
        autoStart: true,
        showControlPanel: false,
        speed: Duration(milliseconds: 500),
      ),
    );
  }
}
