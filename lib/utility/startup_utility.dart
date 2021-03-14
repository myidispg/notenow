import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartupUtility {
  /// This class is supposed to handle all the startup related functions
  /// that are managing user online sync and handling offline data functions
  /// that are required to be done at startup.

  static late final SharedPreferences prefs;
  static NotesModel notesModel = NotesModel();

  static Future<NotesModel> readData() async {
    prefs = await SharedPreferences.getInstance();
    String? userEmail = prefs.getString(kEmailKeySharedPreferences);
    if (userEmail == null) {
      prefs.setString(kEmailKeySharedPreferences, kDefaultEmail);
      userEmail = kDefaultEmail;
    }
    CollectionReference notes =
        FirebaseFirestore.instance.collection(kDefaultEmail);

    notes.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        notesModel.saveNote(NoteModel(
            id: doc.id, // This is the document name.
            noteTitle: doc['title'],
            noteContent: doc['content'],
            noteLabel: doc['label']));
      });
    });
    return notesModel;
  }
}
