import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mult_madness/models/flash.dart';
import 'package:mult_madness/widgets/flashwidget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Animation start from https://github.com/GONZALEZD/flutter_demos/blob/main/flip_animation/lib/main.dart

class _MyHomePageState extends State<MyHomePage> {
  bool _showAnswer = false;
  bool _flipXAxis = true;
  final FlashCardDeck _deck = FlashCardDeck([2, 3, 6, 12]);

  @override
  void initState() {
    super.initState();
    _showAnswer = false;
    _flipXAxis = true;
    _deck.shuffle();
    //const oneSec = Duration(seconds:2);
    //Timer.periodic(oneSec, (Timer t) => _switchCard());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: RotatedBox(
              quarterTurns: _flipXAxis ? 0 : 1,
              child: Icon(Icons.flip),
            ),
            onPressed: _changeRotationAxis,
          ),
        ],
      ),
      body: Center(child:_buildFlipAnimation(),),
          
    );
  }

  void _changeRotationAxis() {
    setState(() {
      _flipXAxis = !_flipXAxis;
    });
  }

  void _switchCard() {
    setState(() {
      _showAnswer = !_showAnswer;
    });
  }

  Widget _buildFlipAnimation() {
    return GestureDetector(
      onTap: _switchCard,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder: __transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.easeInBack,
        switchOutCurve: Curves.easeInBack.flipped,
        child: _showAnswer ? _buildRear() : _buildFront(),
      ),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showAnswer) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: _flipXAxis
              ? (Matrix4.rotationY(value)..setEntry(3, 0, tilt))
              : (Matrix4.rotationX(value)..setEntry(3, 1, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(
      key: ValueKey(false),
      child: FlashCardWidget(card: _deck.cards[0], answer: false),
    );
  }

  Widget _buildRear() {
    return __buildLayout(
      key: ValueKey(true),
      child: FlashCardWidget(card: _deck.cards[0], answer: true)
    );
  }

  Widget __buildLayout({required Key key, required Widget child}) {
    return Container(
      key: key,
      child: child,
    );
  }
}