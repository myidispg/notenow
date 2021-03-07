import 'package:notes_app/models/note.dart';

class Notes {
  List<Note> _notes = [];

  int get notesCount => _notes.length;

  Note getNote(int index) => _notes[index];

  void deleteNote({required Note note}) {
    Note toRemove = _notes.firstWhere((element) =>
        element.noteTitle == note.noteTitle &&
        element.noteContent == note.noteContent &&
        element.noteLabel == element.noteLabel);
    _notes.remove(toRemove);
  }

  void saveNote(Note note, [int editIndex = -1]) {
    if (editIndex != -1) {
      // The note is being edited and not created.
      _notes[editIndex].noteTitle = note.noteTitle;
      _notes[editIndex].noteContent = note.noteContent;
      _notes[editIndex].noteLabel = note.noteLabel;
    } else {
      _notes.add(note);
    }
  }
}
