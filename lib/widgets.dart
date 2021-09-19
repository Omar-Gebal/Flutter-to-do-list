import 'dart:math';
import 'package:flutter/material.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/screens/newtodo.dart';

class TaskCard extends StatelessWidget {
  final title;
  final description;
  TaskCard({this.title, this.description});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: taskCardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "unnamed task",
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: titleColor),
          ),
          Text(
            description ?? 'That is a task without a description',
            style: TextStyle(color: descriptionColor, fontSize: 20),
          )
        ],
      ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final String text;
  final bool finished;
  TodoCard({this.text, @required this.finished});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 5),
            padding: EdgeInsets.all(5),
            child: Image.asset('images/check_icon.png'),
            decoration: BoxDecoration(
              color: finished ? Colors.pink : Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              border: finished ? null : Border.all(color: todoBorderColor),
            ),
          ),
          Flexible(
            child: Text(
              text ?? 'no todo',
              style: TextStyle(color: todoColor, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String text;
  final colour;
  final onPress;
  Button({@required this.text, @required this.colour, this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          '$text',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: myBackGroundColor),
        ),
      ),
    );
  }
}
