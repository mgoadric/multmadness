import 'package:flutter/material.dart';
import 'package:mult_madness/models/flash.dart';
import 'package:mult_madness/widgets/flashwidget.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:FlashCardWidget(card: FlashCard(4, 8), flipped: false),
    );
  }
}