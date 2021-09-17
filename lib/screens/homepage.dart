import 'package:flutter/material.dart';
import 'package:todolist/screens/newtodo.dart';
import 'package:todolist/widgets.dart';
import 'package:todolist/constants.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                child: Image.asset(
                  'images/logo.png',
                  height: 40,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    TaskCard(),
                    TaskCard(),
                    TaskCard(),
                    TaskCard(),
                    TaskCard(),
                    TaskCard(),
                    TaskCard(),
                    TaskCard(),
                  ],
                ),
              ),
              Button(
                text: 'Add a new task',
                colour: addTaskColor,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => todopage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
