import 'package:flutter/material.dart';
import 'note.dart';

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
                );
              },
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // We'll wire this up to the editor screen next
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
