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
    setState(() {});
  }

  void deleteNote(int id) async {
    await ApiService.deleteNote(id);
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddNoteScreen()));
          fetchNotes(); // Refresh notes after adding
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note['title']),
            subtitle: Text(note['description']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
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
