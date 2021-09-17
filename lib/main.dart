import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var previewText = 'not changed';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('To do list'),
        ),
        body: Center(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a new todo item'),
                onChanged: (input) {
                  previewText = input;
                },
              ),
              Text('$previewText'),
              Image(image: AssetImage('images/back_arrow_icon.png'))
            ],
          ),
        ),
      ),
    );
  }
}
