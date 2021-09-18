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
  String _taskDescription = '';

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;
  bool _contentVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.task != null) {
      // Set visibility to true
      _contentVisible = true;
      _tasktitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;
    }
    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleFocus.dispose();
    _todoFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
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
                        focusNode: _titleFocus,
                        onSubmitted: (value) async {
                          // make sure the field is not empty
                          if (value != "") {
                            //check if task is null
                            if (widget.task == null) {
                              DatabaseHelper _dbhelper = DatabaseHelper();
                              Task _newtask = Task(title: value);
                              _taskId = await _dbhelper.insertTask(_newtask);
                              setState(() {
                                _contentVisible = true;
                              });
                              print('New task Id: $_taskId');
                            } else {
                              await _dbhelper.updateTaskTitle(_taskId, value);
                              print('task updated');
                            }
                            _descriptionFocus.requestFocus();
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
              Visibility(
                visible: _contentVisible,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    focusNode: _descriptionFocus,
                    onSubmitted: (value) async {
                      if (value != "") {
                        if (_taskId != 0) {
                          await _dbhelper.updateTaskDescription(_taskId, value);
                          _taskDescription = value;
                        }
                      }
                      _todoFocus.requestFocus();
                    },
                    controller: TextEditingController()
                      ..text = _taskDescription,
                    decoration: InputDecoration(
                        hintText: 'Enter a description',
                        border: InputBorder.none),
                  ),
                ),
              ),
              //todo list
              Visibility(
                visible: _contentVisible,
                child: FutureBuilder(
                  initialData: [],
                  future: _dbhelper.getTodo(_taskId),
                  builder: (context, snapshot) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                //switch todo state
                                if (snapshot.data[index].finished == 0) {
                                  await _dbhelper.updateTodoDone(
                                      snapshot.data[index].id, 1);
                                } else {
                                  await _dbhelper.updateTodoDone(
                                      snapshot.data[index].id, 0);
                                }
                                setState(() {});
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
              ),
              //new todo
              Visibility(
                visible: _contentVisible,
                child: Padding(
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
                        focusNode: _todoFocus,
                        controller: TextEditingController()..text = '',
                        onSubmitted: (value) async {
                          // make sure the field is not empty
                          if (value != "") {
                            if (_taskId != 0) {
                              Todo _newTodo = Todo(
                                  title: value, taskId: _taskId, finished: 0);
                              await _dbhelper.insertTodo(_newTodo);
                              setState(() {});
                              _todoFocus.requestFocus();
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
              ),

              Visibility(
                visible: _contentVisible,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Button(
                    text: 'Delete task',
                    colour: deleteTodoColor,
                    onPress: () async {
                      if (_taskId != null) {
                        await _dbhelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
