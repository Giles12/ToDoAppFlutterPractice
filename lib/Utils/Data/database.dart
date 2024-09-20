import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDodataBase {
  final _myBox = Hive.box('myBox');

  final controller = TextEditingController();
  List toDolist = [];
  //run this method if this is the first time the app is opened
  void createIntialData() {
    toDolist = [
      ["Make", true],
      ["Do Exercise", false],
      ["Do work", false],
      ["Zoom", false],
    ];
  }

  void loadData() {
    toDolist = _myBox.get('TODOLIST');
  }

  void updateData() {
    _myBox.put('TODOLIST', toDolist);
  }
}
