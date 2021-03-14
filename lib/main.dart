import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes.dart';
import 'package:notes_app/screens/home_screen.dart';
import 'package:notes_app/utility/startup_utility.dart';
import 'package:provider/provider.dart';

NotesModel notesModel = NotesModel();
StartupUtility startupUtility = StartupUtility();
late final Future<FirebaseApp> _initialization;

main() {
  WidgetsFlutterBinding.ensureInitialized();
  // First initialize firebase. This is required for reading offline/online
  // data and checking user online status.
  _initialization = Firebase.initializeApp();
  _initialization.then(
      (value) => readNotesFromFirebase().then((value) => runApp(MyApp())));
}

Future<void> readNotesFromFirebase() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: kDefaultEmail, password: "password@123");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }

  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: kDefaultEmail, password: "password@123");
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }

  // First of all, set the email for the user.
  FirebaseAuth auth = FirebaseAuth.instance;
  if (auth.currentUser != null) {
    notesModel.userEmail = auth.currentUser!.email!;
  }

  print('\n\nCurrent User:');
  print('user: ${auth.currentUser}');

  CollectionReference notes =
      FirebaseFirestore.instance.collection(kDefaultEmail);

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
