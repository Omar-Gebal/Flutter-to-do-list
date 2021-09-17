import 'package:flutter/material.dart';
import 'package:todolist/database.dart';
import 'package:todolist/screens/newtodo.dart';
import 'package:todolist/widgets.dart';
import 'package:todolist/constants.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHelper _dbHelper = DatabaseHelper();
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
                  child: FutureBuilder(
                initialData: [],
                future: _dbHelper.getTasks(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        title: snapshot.data[index].title,
                      );
                    },
                  );
                },
              )),
              Button(
                text: 'Add a new task',
                colour: addTaskColor,
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => todopage(),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
