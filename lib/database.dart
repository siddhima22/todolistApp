import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class ToDoDataBase
{
  List toDoList = [];
  final _myBox = Hive.box('mybox');

  void createInitialData(){
    toDoList=[["Make your to-do list",false],
               ["Work Out",false],];
  }

  void loadData(){
    toDoList= _myBox.get("TODOLIST");
  }
  void updateDatabase(){
    _myBox.put("TODOLIST",toDoList);

  }
}