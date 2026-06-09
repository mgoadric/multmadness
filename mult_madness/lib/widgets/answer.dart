import 'package:flutter/material.dart';

class Answer extends StatefulWidget {
  const Answer({super.key, required this.number, required this.callback});
  final int number;
  final Function(int)? callback;
  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.callback == null ? null : () => {widget.callback!(widget.number)}, 
      child: Text("${widget.number}", 
        style: TextStyle(fontSize: 60.0)));
  }
}