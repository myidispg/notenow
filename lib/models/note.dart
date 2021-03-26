import 'package:notes_app/constants.dart';
import 'package:uuid/uuid.dart';

class NoteModel {
  late String id;
  String? noteTitle;
  String noteContent;
  int noteLabel;

  NoteModel(
      {this.noteTitle,
      required this.noteContent,
      this.noteLabel = 0,
      this.id = "0"}) {
    // ID must be editable because the note object can be created from DB.
    if (this.id == "0") {
      // This means a new note is created.
      var uuid = Uuid();
      id = uuid.v4();
    }
  }

  // DATABASE HELPERS
  Map<String, dynamic?> toMap() {
    var map = <String, dynamic>{
      kColumnId: id,
      kColumnContent: noteContent,
      kColumnLabel: noteLabel
    };

    if (noteTitle != null) {
      map[kColumnTitle] = noteTitle;
    }

    return map;
  }
}
