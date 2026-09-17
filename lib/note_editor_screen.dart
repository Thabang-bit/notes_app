import 'package:flutter/material.dart';
import 'note.dart';

class NoteEditorScreen extends StatefulWidget {
  final Note? existingNote;

  const NoteEditorScreen({
    super.key,
    this.existingNote,
  });

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(
      text: widget.existingNote?.title ?? '',
    );

    _bodyController = TextEditingController(
      text: widget.existingNote?.body ?? '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();

    super.dispose();
  }

  void _saveNote() {
    if (_titleController.text.trim().isEmpty) {
      return;
    }

    final note = Note(
      id: widget.existingNote?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      body: _bodyController.text.trim(),
      lastEdited: DateTime.now(),
    );

    Navigator.pop(context, note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.existingNote == null ? 'New Note' : 'Edit Note',
        ),
        actions: [
          IconButton(
            onPressed: _saveNote,
            icon: const Icon(Icons.check),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
              ),
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 12),

            Expanded(
              child: TextField(
                controller: _bodyController,
                decoration: const InputDecoration(
                  hintText: 'Start typing...',
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}