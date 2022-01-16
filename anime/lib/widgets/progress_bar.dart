import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final questionList;

  const ProgressBar({Key key, this.questionList}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      ...questionList.icons,
    ]);
  }
}
