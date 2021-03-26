import 'package:notes_app/models/note.dart';

class NotesModel {
  List<NoteModel> _notes = [];

  int get notesCount => _notes.length;

  NoteModel getNote(int index) => _notes[index];

  void deleteNote({required NoteModel note}) {
    NoteModel toRemove = _notes.firstWhere((element) => element.id == note.id);
    _notes.remove(toRemove);
  }

  void saveNote(NoteModel note, [int? editIndex]) {
    if (editIndex != null) {
      // The note is being edited and not created.
      _notes[editIndex].noteTitle = note.noteTitle;
      _notes[editIndex].noteContent = note.noteContent;
      _notes[editIndex].noteLabel = note.noteLabel;
    } else {
      _notes.add(note);
    }
  }

  List<int> searchNotes(String searchQuery) {
    /// Search for notes based on the contents/titles of the notes.
    /// Since the whole rendering of note on NoteScreen is dependant upon
    /// the index of the note, this method will return a list of indexes
    /// of the relevant notes. Empty List if no match found.

    List<int> relevantIndexes = [];
    _notes.asMap().forEach((index, note) {
      if (note.noteTitle!.contains(searchQuery) ||
          note.noteContent.contains(searchQuery)) {
        relevantIndexes.add(index);
      }
    });

    return relevantIndexes;
  }
}
