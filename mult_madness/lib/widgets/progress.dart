import 'package:flutter/material.dart';

class LevelProgress extends StatelessWidget {
  const LevelProgress({super.key, required this.value, required this.color});
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const .symmetric(horizontal: 16, vertical: 5),
      child: LinearProgressIndicator(
        minHeight: 30,
        color: color,
        value: value,
      ),
    );
  }
}

