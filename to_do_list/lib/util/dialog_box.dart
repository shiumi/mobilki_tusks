import 'package:flutter/material.dart';
import 'package:to_do_list/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.lightBlueAccent,
      content: Container(
        height: 120,
        child: Column(
          children: [

            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "add new task",
              ),
            ),
            //buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //save
              MyButton(text: "save", onPressed: onSave )
            ],)
          ],
        ),
      ),
    );
  }
}
