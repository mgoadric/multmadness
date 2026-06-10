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
  final FlashCardDeck _deck = FlashCardDeck([
    2,
  ]);

  FlashCard? current;
  bool playing = false;

  @override
  void initState() {
    super.initState();
    _deck.shuffle();
    _deck.startRound();
    current = _deck.next();
    playing = true;
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
      body: Column(
        children: [
          Padding(
            padding: const .symmetric(horizontal: 16, vertical: 20),
            child: LinearProgressIndicator(
              minHeight: 30,
              value: _deck.topTotal() / _deck.total(),
            ),
          ),
          playing
              ? Challenge(card: current!, nextCallback: _nextCard, answerCallback: answer)
              : Placeholder(),
        ],
      ),
    );
  }

  void answer(bool right, FlashCard card) {
    setState(() {
      if (right) {
        _deck.correct(card);
      } else {
        _deck.incorrect(card);
      }
    });
    print("${_deck.topTotal()} + ${_deck.current.length} + ${_deck.wrong.length} = ${_deck.total()}");
  }

  bool _nextCard() {
    if (_deck.hasNext()) {
      setState(() {
        current = _deck.next();
      });
      return true;
    } else {
      playing = false;
      return false;
    }
  }


}
