import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  List<Note> get notes => _notes;

  NoteProvider() {
    loadNotes();
  }

  // Load Notes
  Future<void> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? notesJson = prefs.getString('notes');
    if (notesJson != null) {
      List<dynamic> decoded = jsonDecode(notesJson);
      _notes = decoded.map((e) => Note.fromMap(e)).toList();
    }
    notifyListeners();
  }

  // Save Notes
  Future<void> saveNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String encodedNotes =
          jsonEncode(_notes.map((note) => note.toMap()).toList());
      await prefs.setString('notes', encodedNotes);
    } catch (e) {
      debugPrint("Error saving notes: $e");
    }
  }

  // add note

  void addNote(Note note) {
    _notes.add(note);
    saveNotes();
    notifyListeners();
  }

  // delete note

  void deleteNote(Note note) {
    _notes.remove(note);
    saveNotes();
    notifyListeners();
  }

  // update note
  void updateNote(Note oldNote, Note newNote) {
    int index = _notes.indexWhere((note) => note.title == oldNote.title);
    if (index != -1) {
      _notes[index] = newNote;
      saveNotes();
      notifyListeners();
    }
  }
}
