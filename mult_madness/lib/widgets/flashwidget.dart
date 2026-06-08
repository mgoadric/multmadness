import 'package:flutter/material.dart';
import 'package:mult_madness/models/flash.dart';

class FlashCardWidget extends StatelessWidget {
  final FlashCard card;
  const FlashCardWidget(this.card, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            constraints: BoxConstraints.tight(Size.square(200.0)), child: Card(
      child: Center(
        child: Text("${card.a} x ${card.b}", style: TextStyle(fontSize: 60.0)),
      ),
            ),
    );
  }
}