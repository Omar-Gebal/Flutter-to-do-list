import 'package:flutter/material.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/widgets.dart';

class todopage extends StatefulWidget {
  const todopage({Key key}) : super(key: key);

  @override
  _todopageState createState() => _todopageState();
}

class _todopageState extends State<todopage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title and back
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset('images/back_arrow_icon.png'
                            ''),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: 'Enter a task', border: InputBorder.none),
                      ),
                    ),
                  ],
                ),
              ),
              // description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: 'Enter a description',
                      border: InputBorder.none),
                ),
              ),
              //todo list
              Expanded(
                child: ListView(children: [
                  TodoCard(
                    finished: false,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Button(text: 'Delete todo', colour: deleteTodoColor),
              )
            ],
          ),
        ),
      ),
    );
  }
}
