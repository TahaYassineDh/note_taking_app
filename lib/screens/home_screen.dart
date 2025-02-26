import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:note_taking_app/providers/note_provider.dart';
import 'package:note_taking_app/screens/note_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final noteProvider = Provider.of<NoteProvider>(context);

    // Define colors for light and dark themes
    final backgroundColor =
        themeProvider.isDarkMode ? Colors.grey[900] : Colors.white;
    final cardColor =
        themeProvider.isDarkMode ? Colors.grey[800] : Colors.white;
    final textColor = themeProvider.isDarkMode ? Colors.white : Colors.black87;
    final subtitleTextColor =
        themeProvider.isDarkMode ? Colors.grey[400] : Colors.grey[700];
    final appBarColor =
        themeProvider.isDarkMode ? Colors.grey[850] : Colors.blueAccent;
    final floatingActionButtonColor =
        themeProvider.isDarkMode ? Colors.blueGrey : Colors.blueAccent;

    // Function to show the add note dialog
    void _showAddNoteDialog() {
      final TextEditingController _titleController = TextEditingController();
      final TextEditingController _contentController = TextEditingController();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: cardColor,
            title: Text(
              'Add New Note',
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
                  Navigator.pop(context); // Close the dialog
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Add the new note
                  if (_titleController.text.isNotEmpty &&
                      _contentController.text.isNotEmpty) {
                    noteProvider.addNote(Note(
                      title: _titleController.text,
                      content: _contentController.text,
                      date: DateTime.now().toString(),
                    ));
                    Navigator.pop(context); // Close the dialog
                  }
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            icon: Icon(
              themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
              color: Colors.white,
            ),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Container(
        color: backgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (noteProvider.notes.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    "No notes yet!",
                    style: TextStyle(
                      fontSize: 18,
                      color: subtitleTextColor,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: noteProvider.notes.length,
                  itemBuilder: (context, index) {
                    final note = noteProvider.notes[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      color: cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          note.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              (note.content.length > 40)
                                  ? "${note.content.substring(0, 40)}..."
                                  : note.content,
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              note.date,
                              style: TextStyle(
                                fontSize: 12,
                                color: subtitleTextColor,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            noteProvider.deleteNote(note);
                          },
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NoteDetailScreen(note: note),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddNoteDialog, // Open the add note dialog
        backgroundColor: floatingActionButtonColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
