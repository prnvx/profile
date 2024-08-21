import 'package:flutter/material.dart';
import 'create_note.dart';

class NoteApp extends StatefulWidget {
  NoteApp({super.key});

  @override
  State<NoteApp> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteApp> {
  List<Map<String, String>> notesList = [];

  void addNote({required Map<String, String> note}) {
    setState(() {
      notesList.add(note);
    });
  }

  void deleteNoteAtIndex(int index) {
    setState(() {
      notesList.removeAt(index);
    });
  }

  void editNoteAtIndex(int index, Map<String, String> editedNote) {
    setState(() {
      notesList[index] = editedNote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'NOTES',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 25),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: notesList.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'No Notes Yet',
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
      )
          : ListView.builder(
        itemCount: notesList.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.grey[800],
            margin:
            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListTile(
              title: Text(
                notesList[index]['title'] ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                notesList[index]['note'] ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () async {
                      final editedNote = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateNote(
                            initialTitle: notesList[index]['title']!,
                            initialNote: notesList[index]['note']!,
                          ),
                        ),
                      );

                      if (editedNote != null) {
                        editNoteAtIndex(index, editedNote);
                      }
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      deleteNoteAtIndex(index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateNote(),
            ),
          ).then((value) {
            if (value != null) {
              addNote(note: value);
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateNote extends StatefulWidget {
  final String? initialTitle;
  final String? initialNote;

  CreateNote({this.initialTitle, this.initialNote, super.key});

  @override
  State<CreateNote> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateNote> {
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialTitle != null) {
      _titleController.text = widget.initialTitle!;
    }
    if (widget.initialNote != null) {
      _notesController.text = widget.initialNote!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'NOTES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.white)
              ),
            ),
            SizedBox(height: 20),
            TextField(
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              controller: _notesController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Your Note',
                  hintStyle: TextStyle(color: Colors.white)
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, {
            'title': _titleController.text,
            'note': _notesController.text,
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
