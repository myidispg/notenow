import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

late NotesModel notesModel = NotesModel();
late final Future<FirebaseApp> _initialization;

main() {
  WidgetsFlutterBinding.ensureInitialized();
  readNotesFromFirebase().then((value) => runApp(MyApp()));
}

Future<void> readNotesFromFirebase() async {
  // First initialize the firebase app. Then, read all notes into the memory.
  _initialization = Firebase.initializeApp();
  _initialization.then((value) {
    CollectionReference notes =
        FirebaseFirestore.instance.collection('email@email.com');

    notes.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        notesModel.saveNote(NoteModel(
            id: doc.id, // This is the document name.
            noteTitle: doc['title'],
            noteContent: doc['content'],
            noteLabel: doc['label']));
        // print('Note ID: ${doc.id}');
        // print('Note title: ${doc["title"]}');
        // print('Note content: ${doc["content"]}');
        // print('Note label: ${doc["label"]}');
      });
    });
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
            theme: ThemeData.dark()
                .copyWith(accentColor: kDarkThemeBackgroundColor),
            home: Center(
              child: Text("Something went wrong"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ChangeNotifierProvider(
            create: (context) => notesModel,
            child: MaterialApp(
              theme: ThemeData.dark()
                  .copyWith(accentColor: kDarkThemeBackgroundColor),
              home: HomeScreen(),
            ),
          );
        }
        return MaterialApp(
          theme:
              ThemeData.dark().copyWith(accentColor: kDarkThemeBackgroundColor),
          home: Center(
            child: Text("Loading"),
          ),
        );
      },
    );
  }
}
