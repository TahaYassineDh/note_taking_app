import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../providers/theme_provider.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note note;
  NoteDetailScreen({required this.note});

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final noteProvider = Provider.of<NoteProvider>(context);

    final backgroundColor =
        themeProvider.isDarkMode ? Colors.grey[900] : Colors.white;
    final cardColor =
        themeProvider.isDarkMode ? Colors.grey[800] : Colors.white;
    final textColor = themeProvider.isDarkMode ? Colors.white : Colors.black87;
    final subtitleTextColor =
        themeProvider.isDarkMode ? Colors.grey[400] : Colors.grey[700];
    final appBarColor =
        themeProvider.isDarkMode ? Colors.grey[850] : Colors.blueAccent;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Details'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    backgroundColor: cardColor,
                    title: Text(
                      'Edit Note',
                      style: TextStyle(color: textColor),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _titleController,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(color: subtitleTextColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: subtitleTextColor!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _contentController,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Content',
                            labelStyle: TextStyle(color: subtitleTextColor),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: subtitleTextColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent),
                            ),
                          ),
                          maxLines: 5,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Update the note
                          final updatedNote = Note(
                            title: _titleController.text,
                            content: _contentController.text,
                            date: DateTime.now().toString(),
                          );
                          noteProvider.updateNote(widget.note, updatedNote);
                          setState(() {
                            widget.note.title = updatedNote.title;
                            widget.note.content = updatedNote.content;
                            widget.note.date = updatedNote.date;
                          });
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.note.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.note.content,
                  style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    widget.note.date,
                    style: TextStyle(
                      fontSize: 14,
                      color: subtitleTextColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
