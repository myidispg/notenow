import 'package:flutter/material.dart';
import 'package:notes_app/app_state/app_state.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

late NotesModel notesModel;
late AppState appState;

main() {
  WidgetsFlutterBinding.ensureInitialized();

  /// [AppState] handles all the important stuff for firebase, offline sql
  /// storage and the [NotesModel] object in the memory.
  appState = AppState();
  appState.initialization().then((_) => appState.readNotes());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => appState,
      child: Builder(
        builder: (BuildContext context) => MaterialApp(
          theme: Provider.of<AppState>(context).isDarkTheme
              ? ThemeData.dark()
                  .copyWith(accentColor: kDarkThemeBackgroundColor)
              : ThemeData.light(),
          // theme:
          //     ThemeData.dark().copyWith(accentColor: kDarkThemeBackgroundColor),
          home: HomeScreen(),
        ),
      ),
    );
  }
}
