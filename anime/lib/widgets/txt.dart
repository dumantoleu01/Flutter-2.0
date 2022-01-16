import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  final String title;
  final Color color;
  final int fontSize;

  const Txt({Key key, this.title, this.color, this.fontSize});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: color,
        fontSize: fontSize.toDouble(),
      ),
    );
  }
}
