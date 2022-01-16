import 'package:anime/screens/Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime',
      home: Scaffold(
        backgroundColor: Color(0xff0a0d1b),
        body: HomePage(),
      ),
    );
  }
}
