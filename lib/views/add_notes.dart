import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes/services/api_services.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isSubmitting = false;

  void addNote() async {
    if (isSubmitting) return; // Prevent multiple calls
    isSubmitting = true;

    if (titleController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      if (await ApiService.addNote(
          titleController.text, descriptionController.text)) {
        Navigator.pop(context);
      } else {
        log("Failed adding note");
      }
    }

    isSubmitting = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Note")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 24,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: "Description")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: addNote, child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
