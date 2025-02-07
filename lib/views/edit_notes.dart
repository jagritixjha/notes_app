import 'package:flutter/material.dart';
import 'package:notes/services/api_services.dart';

class EditNoteScreen extends StatefulWidget {
  final Map<String, dynamic> note;

  EditNoteScreen({required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note['title']);
    descriptionController =
        TextEditingController(text: widget.note['description']);
  }

  void updateNote() async {
    await ApiService.updateNote(
        widget.note['id'], titleController.text, descriptionController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Note")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title")),
            TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: updateNote, child: Text("Update"))
          ],
        ),
      ),
    );
  }
}
