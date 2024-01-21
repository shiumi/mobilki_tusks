import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  final _mybox = Hive.box('mybox');

//first open of app
  void createInitialData(){
    toDoList = [
      ["make someth", false],
    ];
  }

  void loadData(){
    toDoList = _mybox.get("TODOLIST");
  }

  void updateDataBase(){
    _mybox.put("TODOLIST", toDoList);
  }
}