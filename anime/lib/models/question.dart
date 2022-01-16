import 'package:flutter/material.dart';

class Question {
  final String title;
  final List<Map> answers;
  final int index;
  final String typeQuiz;

  Question({
    @required this.title,
    @required this.answers,
    @required this.index,
    @required this.typeQuiz,
  });
}
