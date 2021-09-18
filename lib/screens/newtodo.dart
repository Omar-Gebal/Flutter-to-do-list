import 'package:flutter/material.dart';
import 'package:todolist/constants.dart';
import 'package:todolist/database.dart';
import 'package:todolist/model/task.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/widgets.dart';

class todopage extends StatefulWidget {
  final Task task;

  todopage({@required this.task});

  @override
  _todopageState createState() => _todopageState();
}

class _todopageState extends State<todopage> {
  DatabaseHelper _dbhelper = DatabaseHelper();

  int _taskId = 0;
  String _tasktitle = '';

  @override
  void initState() {
    // TODO: implement initState
    if (widget.task != null) {
      _tasktitle = widget.task.title;
      _taskId = widget.task.id;
    }
    super.initState();
  }

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
                        onSubmitted: (value) async {
                          // make sure the field is not empty
                          if (value != "") {
                            //check if task is null
                            if (widget.task == null) {
                              DatabaseHelper _dbhelper = DatabaseHelper();
                              Task _newtask = Task(title: value);
                              await _dbhelper.insertTask(_newtask);
                              print("Task addition succesful");
                            } else {
                              print('edit');
                            }
                          }
                        },
                        controller: TextEditingController()..text = _tasktitle,
                        decoration: InputDecoration(
                          hintText: 'Enter a task',
                          border: InputBorder.none,
                        ),
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
              FutureBuilder(
                initialData: [],
                future: _dbhelper.getTodo(_taskId),
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              //switch todo state
                            },
                            child: TodoCard(
                              text: snapshot.data[index].title,
                              finished: snapshot.data[index].finished == 0
                                  ? false
                                  : true,
                            ),
                          );
                        }),
                  );
                },
              ),
              //new todo
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      padding: EdgeInsets.all(5),
                      child: Image.asset('images/check_icon.png'),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.black),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                      onSubmitted: (value) async {
                        // make sure the field is not empty
                        if (value != "") {
                          //check if task is null
                          if (widget.task != null) {
                            Todo _newTodo = Todo(
                                title: value,
                                taskId: widget.task.id,
                                finished: 0);
                            await _dbhelper.insertTodo(_newTodo);
                            setState(() {});
                          }
                        }
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter todo item',
                          border: InputBorder.none),
                    )),
                  ],
                ),
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
