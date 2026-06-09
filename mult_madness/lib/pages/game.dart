import 'package:flutter/material.dart';

import 'package:mult_madness/models/flash.dart';
import 'package:mult_madness/widgets/challenge.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Animation start from https://github.com/GONZALEZD/flutter_demos/blob/main/flip_animation/lib/main.dart

class _MyHomePageState extends State<MyHomePage> {
  final FlashCardDeck _deck = FlashCardDeck([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]);

  @override
  void initState() {
    super.initState();
    _deck.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_right_outlined),
            onPressed: _nextCard,
          ),
        ],
      ),
      body:
      _deck.cards.isNotEmpty ? 
        Challenge(card: _deck.cards[0], nextCallback: _nextCard,) : Placeholder(),
          
    );
  }

  bool _nextCard() {
    if (_deck.cards.isNotEmpty) {
      setState(() {
        _deck.cards.removeAt(0);
      });
      if (_deck.cards.isNotEmpty) {
        return true;
      }
    }
    return false;
  }
}