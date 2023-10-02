import 'package:flutter/material.dart';
import 'package:todohive/database.dart';
import 'package:todohive/todotile.dart';
import 'package:todohive/dialogbox.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

       final _myBox = Hive.box('mybox');
  
        final _controller= TextEditingController();

         ToDoDataBase db= ToDoDataBase();
  void initState(){

    if(_myBox.get("TODOLIST")==null){
      db.createInitialData();
    }
    else{
      db.loadData();
    }
    super.initState();
  }

         void checkBoxChanged(bool? value,int index){
           setState(() {
             db.toDoList[index][1]=!db.toDoList[index][1];
           });
           db.updateDatabase();
         }

         void saveNewTask(){
           setState(() {
             db.toDoList.add([_controller.text,false]);
             _controller.clear();
           });
           Navigator.of(context).pop();
           db.updateDatabase();
         }
          void createNewTask(){
           showDialog(context: context,
               builder: (context){
             return DialogBox(controller:_controller ,
                               onSave:saveNewTask ,
                               onCancel: ()=>Navigator.of(context).pop(),);
               },
           );
           db.updateDatabase();
         }
 void deleteTask(int index){
           setState(() {
             db.toDoList.removeAt(index);
           });
           db.updateDatabase();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'MY TODO LIST',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

        ),
        backgroundColor: Colors.blue[500],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(

            itemCount: db.toDoList.length,
           itemBuilder: (context,index){
             return ToDoTile(taskName: db.toDoList[index][0],
                 taskCompleted:  db.toDoList[index][1],
                 onChanged: (value) => checkBoxChanged(value,index),
               deleteFunction: (context)=>deleteTask(index),
             );
           },

      ),
    );
  }
}
