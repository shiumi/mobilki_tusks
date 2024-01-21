import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_list/data/database.dart';
import 'package:to_do_list/util/todo_tile.dart';
import 'package:to_do_list/util/dialog_box.dart';
import 'package:to_do_list/util/my_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  //box
  final _mybox = Hive.box('mybox');

  @override
  void initState() {
    //first start
    if (_mybox.get("TODOLIST") == null){
      db.createInitialData();
    } else {
      db.loadData();
    }


    super.initState();
  }

  //controller
  final _controller = TextEditingController();

  ToDoDataBase db = ToDoDataBase();

//check box tap
  void checkBoxChanged(bool? value, int index){
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  //save new task
  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  //create task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
          );
        },
    );
  }

  //delete
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleated: db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}