import 'package:flutter/material.dart';
import 'package:notes_app/screens/note_form.dart';
import 'package:notes_app/screens/note_list.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => NoteListScreen(),
        '/add_note': (context) => NoteFormScreen(),
      },
    );
  }
}
