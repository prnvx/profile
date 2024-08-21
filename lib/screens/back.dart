import 'package:flutter/material.dart';

class Screen3 extends StatefulWidget {
  Screen3({super.key});

  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  // List of notes
  List<Map<String, String>> notes = [
    {'title': 'Note 1', 'content': 'This is the first note.'},
    {'title': 'Note 2', 'content': 'This is the second note.'},
    {'title': 'Note 3', 'content': 'This is the third note.'},
    {'title': 'Note 4', 'content': 'This is the fourth note.'},
    {'title': 'Note 5', 'content': 'This is the fifth note.'},
  ];

  void onNewNoteCreated(Map<String, String> note) {
    setState(() {
      notes.add(note);
    });
  }

  void onNoteDeleted(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'SCREEN 3',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
        ),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[800],
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text(
                notes[index]['title'] ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                notes[index]['content'] ?? '',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  onNoteDeleted(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNote(),
            ),
          );

          if (newNote != null) {
            onNewNoteCreated(newNote);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateNote extends StatelessWidget {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  CreateNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Create Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(hintText: 'Content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newNote = {
                  'title': _titleController.text,
                  'content': _contentController.text,
                };
                Navigator.pop(context, newNote);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
