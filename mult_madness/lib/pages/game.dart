import 'package:flutter/material.dart';

import 'package:mult_madness/models/flash.dart';
import 'package:mult_madness/widgets/challenge.dart';
import 'package:mult_madness/widgets/progress.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Animation start from https://github.com/GONZALEZD/flutter_demos/blob/main/flip_animation/lib/main.dart

class _MyHomePageState extends State<MyHomePage> {
  final FlashCardDeck _deck = FlashCardDeck([2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]);

  FlashCard? current;
  bool playing = false;

  @override
  void initState() {
    super.initState();
    _deck.shuffle();
    gotime();
  }

  @override
  Widget build(BuildContext context) {
    var progress = _deck.levels.map<LevelProgress>((item) {
      return LevelProgress(value: item.length / _deck.total(), color: Colors.blue);
    }).toList();

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
          ...progress,
          _deck.wrong.isNotEmpty
              ? LevelProgress(
                  value: _deck.wrong.length / _deck.total(),
                  color: Colors.red,
                )
              : SizedBox(height: 0),
          playing
              ? Challenge(
                  card: current!,
                  nextCallback: _nextCard,
                  answerCallback: answer,
                )
              : Expanded(child: Center(child: ElevatedButton(onPressed: gotime, child: Text("Ready?", style: TextStyle(fontSize: 30.0))))),
        ],
      ),
    );
  }

  void gotime() {
    setState(() {
      _deck.startRound();
      current = _deck.next();
      playing = true;
    });
  }

  void answer(bool right, FlashCard card) {
    setState(() {
      if (right) {
        _deck.correct(card);
      } else {
        _deck.incorrect(card);
      }
    });
    print(
      "${_deck.topTotal()} + ${_deck.current.length} + ${_deck.wrong.length} = ${_deck.total()}",
    );
  }

  bool _nextCard() {
    if (_deck.hasNext()) {
      setState(() {
        current = _deck.next();
      });
      return true;
    } else {
      playing = false;
      _deck.advance();
      return false;
    }
  }
}
