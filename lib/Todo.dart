// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:myapp/Utils/Data/database.dart'; // Import ToDodataBase
import 'package:myapp/Utils/Todo_tile.dart';
import 'package:myapp/Utils/dialog_box.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  ToDodataBase db = ToDodataBase();
  final _myBox = Hive.box('myBox');

  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (_myBox.get('TODOLIST') == null) {
      db.createIntialData();
      db.updateData();
    } else {
      db.loadData();
    }
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDolist[index][1] = value;
    });
    print(db.toDolist[index][1]);
    db.updateData();
  }

  void SaveNewTask() {
    setState(() {
      db.toDolist.add([controller.text, false]);
      controller.clear();
      Navigator.pop(context);
    });
    db.updateData();
  }

  void MakeNewTask(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: controller,
            onSave: SaveNewTask,
            onCancel: () {
              Navigator.pop(context);
            },
          );
        });
  }

  void DeleteTask(int index) {
    setState(() {
      db.toDolist.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 7, 44, 63),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'To Do',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView.builder(
        itemCount: db.toDolist.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: db.toDolist[index][0],
            taskCompleted: db.toDolist[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => DeleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => MakeNewTask(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
