import 'package:flutter/material.dart';
import 'package:mult_madness/models/flash.dart';

class FlashCardWidget extends StatelessWidget {
  const FlashCardWidget({super.key, required this.card, required this.flipped});
  final FlashCard card;
  final bool flipped;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 325, 
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,          
          children: [Text("${card.a} x ${card.b}", style: TextStyle(fontSize: 50.0)),
          Text(flipped ? "?" : "${card.answer()}", style: TextStyle(fontSize: 70.0))],
        ),
      ),);
  }
}