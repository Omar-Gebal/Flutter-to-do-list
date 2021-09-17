import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:todolist/screens/homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var previewText = 'not changed';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
