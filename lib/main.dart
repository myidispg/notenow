import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(accentColor: kDarkThemeBackgroundColor),
      home: ChangeNotifierProvider(
        create: (context) => NotesModel(),
        child: HomeScreen(),
      ),
    );
  }
}
