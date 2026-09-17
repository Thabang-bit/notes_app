import 'package:flutter/material.dart';
import 'note.dart';
import 'note_editor_screen.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const NotesListScreen(),
    );
  }
}

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final List<Note> _notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes'),
      ),

      body: _notes.isEmpty
          ? const Center(
              child: Text(
                'No notes yet. Tap + to add one.',
              ),
            )
          : ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];

                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(
                    note.body,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () async { final updatedNote = await Navigator.push<Note>(
                     context,
                    MaterialPageRoute( 
                      builder: (context) => NoteEditorScreen( 
                        existingNote: note, 
                      ), 
                    ), 
                  );
                  if (updatedNote != null) { 
                    setState(() { 
                      _notes[index] = updatedNote;
                   }); 
                  } 
                }, 
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newNote = await Navigator.push<Note>(
            context,
            MaterialPageRoute(builder: (context) => const NoteEditorScreen()),
          );
          if (newNote != null) {
            setState(() {
              _notes.add(newNote);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}