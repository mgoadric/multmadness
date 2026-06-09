import 'package:flutter/material.dart';
import 'package:mult_madness/models/flash.dart';

class FlashCardWidget extends StatelessWidget {
  const FlashCardWidget({super.key, required this.card, required this.answer, required this.color});
  final FlashCard card;
  final bool answer;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200, 
      child: Card(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,          
          children: [Text("${card.a} x ${card.b}", style: TextStyle(fontSize: 50.0)),
          Text(answer ? "${card.answer()}" : "?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 70.0))],
        ),
      ),);
  }
}