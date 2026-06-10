import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:mult_madness/models/flash.dart';
import 'package:mult_madness/widgets/answer.dart';
import 'package:mult_madness/widgets/flashwidget.dart';

class Challenge extends StatefulWidget {
  const Challenge({super.key, required this.card, required this.nextCallback, required this.answerCallback});

  final FlashCard card;
  final bool Function() nextCallback;
  final void Function(bool, FlashCard) answerCallback;

  @override
  State<Challenge> createState() => _ChallengeState();
}

// Animation start from https://github.com/GONZALEZD/flutter_demos/blob/main/flip_animation/lib/main.dart

class _ChallengeState extends State<Challenge> {
  bool _showAnswer = false;
  bool _showOptions = true;
  CardStatus correct = CardStatus.ready;
  List answers = [];
  Timer? timer;
  Timer? timer2;
  Map<CardStatus, Color> cardColor = {
    CardStatus.ready:Colors.amber,
    CardStatus.right:Colors.green,
    CardStatus.wrong:Colors.red,
  };

  @override
  void initState() {
    print("hello");
    super.initState();
    _showAnswer = false;
    _showOptions = true;
    timer = Timer(Duration(seconds: 5), () => _switchCard(0));
    answers = getAnswers();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Expanded(child: SizedBox.expand()),
          Center(child: _buildFlipAnimation()),
          Expanded(child: SizedBox.expand()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Answer(
                callback: _showOptions ? _switchCard : null,
                number: answers[0],
              ),
              SizedBox(width: 20),
              Answer(
                callback: _showOptions ? _switchCard : null,
                number: answers[1],
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Answer(
                callback: _showOptions ? _switchCard : null,
                number: answers[2],
              ),
              SizedBox(width: 20),
              Answer(
                callback: _showOptions ? _switchCard : null,
                number: answers[3],
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  List<int> getAnswers() {
    final ans = {
      widget.card.answer() + 1,
      widget.card.answer() - 1,
      widget.card.answer() + 2,
      widget.card.answer() - 2,
      widget.card.a * (widget.card.b - 1),
      widget.card.a * (widget.card.b + 1),
      widget.card.b * (widget.card.a + 1),
      widget.card.b * (widget.card.a - 1),
    };
    var subans = ans.toList();
    subans.shuffle();
    var newList = [subans[0], subans[1], subans[2], widget.card.answer()];
    newList.shuffle();
    return newList;
  }

  void _switchCard(int ans) {
    setState(() {
      _showAnswer = true;
      _showOptions = false;
      if (ans == widget.card.answer()) {
        correct = CardStatus.right;
      } else {
        correct = CardStatus.wrong;
      }
    });
    timer?.cancel();
    timer2 = Timer(Duration(seconds: 3), () => _resetCard());
  }

  void _resetCard() {
    timer2?.cancel();
    widget.answerCallback(correct == CardStatus.right, widget.card);
    if (widget.nextCallback()) {
      setState(() {
        _showAnswer = false;
        correct = CardStatus.ready;
      });
      timer = Timer(Duration(seconds: 5), () => _switchCard(0));
    }
  }

  void _resetAnswers() {
    answers = getAnswers();

    Timer(
      Duration(milliseconds: 300),
      () => setState(() {
        _showOptions = true;
      }),
    );
  }

  Widget _buildFlipAnimation() {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      transitionBuilder: __transitionBuilder,
      layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
      switchInCurve: Curves.easeInBack,
      switchOutCurve: Curves.easeInBack.flipped,
      child: _showAnswer ? _buildRear() : _buildFront(),
    );
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    rotateAnim.addStatusListener(
      ((status) => {
        if (status.isCompleted && !_showAnswer) {_resetAnswers()},
      }),
    );
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(_showAnswer) != widget!.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder
            ? min(rotateAnim.value, pi / 2)
            : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  Widget _buildFront() {
    return __buildLayout(answer: false);
  }

  Widget _buildRear() {
    return __buildLayout(answer: true);
  }

  Widget __buildLayout({required bool answer}) {
    return Container(
      key: ValueKey(answer),
      child: FlashCardWidget(
        card: widget.card,
        answer: answer,
        color: cardColor[correct]!,
      ),
    );
  }
}
