import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // NotesModel _notesModel = NotesModel();

  @override
  Widget build(BuildContext context) {
    // _notesModel.buildDummyData();

    return ChangeNotifierProvider(
      create: (context) => NotesModel(),
      child: MaterialApp(
        theme:
            ThemeData.dark().copyWith(accentColor: kDarkThemeBackgroundColor),
        home: HomeScreen(),
      ),
    );
  }
}
