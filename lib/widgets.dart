import 'package:flutter/material.dart';

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
          borderRadius: BorderRadius.circular(15.0), color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "unnamed task",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(description ?? 'That is a task without a description')
        ],
      ),
    );
  }
}
