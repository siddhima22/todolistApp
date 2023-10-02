import 'package:flutter/material.dart';
import 'package:todohive/mybutton.dart';

class DialogBox extends StatelessWidget {

 final controller;
 VoidCallback onSave;
 VoidCallback onCancel;

 DialogBox({super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.blue[200],
      content: Container(
        height: 120,
        child: Column(children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new task",
            ),
          ),
          const SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyButton(text: "Save", onPressed:onSave),
              Icon(Icons.save_alt),
              const SizedBox(width: 60,),

              MyButton(text: "Cancel", onPressed:onCancel),
              Icon(Icons.cancel)

            ],
          )
        ],),
      ),
    );
  }
}
