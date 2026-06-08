import 'package:flutter/material.dart';
import 'package:mult_madness/models/flash.dart';
import 'package:mult_madness/widgets/flashwidget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child:FlashCardWidget(FlashCard(4, 8)),
        ),
      ),
    );
  }
}
