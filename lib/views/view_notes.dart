import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notes/services/api_services.dart';
import 'package:notes/views/add_notes.dart';
import 'package:notes/views/edit_notes.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<dynamic> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void fetchNotes() async {
    notes = await ApiService.getNotes();
    log('get notes------------------');
    setState(() {});
  }

  void deleteNote(String id) async {
    await ApiService.deleteNote(id);
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    log(notes.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Notes",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        elevation: 2,
        // shadowColor: Colors.indigo.shade50,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNoteScreen()));
          fetchNotes(); // Refresh notes after adding
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            tileColor: Colors.indigo.shade100.withOpacity(0.2),
            visualDensity: VisualDensity.compact,
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(24)),
            title: Text(note['title']),
            subtitle: Text(note['description']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.indigo.shade900,
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditNoteScreen(note: note),
                      ),
                    );
                    fetchNotes();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => deleteNote(note['id']),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
