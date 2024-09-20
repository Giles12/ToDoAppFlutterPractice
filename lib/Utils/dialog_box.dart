import 'package:flutter/material.dart';
import 'package:myapp/Utils/new_homeButton.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel; // Explicit type
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  }); // Required to ensure controller is passed

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blueGrey[900],
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Task Input Field
            TextField(
              controller: controller, // Use the passed controller
              decoration: InputDecoration(
                hintText: 'Enter Task Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            // Row for buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Save Button
                MyButton(
                    text: 'Save',
                    onPressed: () {
                      onSave(); // Call the passed function
                    }),
                // Cancel Button
                MyButton(
                    text: 'Cancel',
                    onPressed: () {
                      onCancel(); // Call the passed function
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
