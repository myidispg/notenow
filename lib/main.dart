import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/database/database_helper.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

late NotesModel notesModel;
DatabaseHelper databaseHelper = DatabaseHelper();

main() {
  WidgetsFlutterBinding.ensureInitialized();
  getAllNotes().then((value) => runApp(MyApp()));
  // runApp(MyApp());
}

Future<void> getAllNotes() async {
  // Wait to establish a connection to the database
  await databaseHelper.open();

  // Create some dummy data into the notes table of the database.
  notesModel = await databaseHelper.getAllNotes();
  print('Found ${notesModel.notesCount} notes');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => notesModel,
      child: ChangeNotifierProvider(
        create: (context) => databaseHelper,
        child: MaterialApp(
          theme:
              ThemeData.dark().copyWith(accentColor: kDarkThemeBackgroundColor),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
